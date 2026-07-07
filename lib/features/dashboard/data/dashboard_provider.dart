import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/dashboard_data.dart';

part 'dashboard_provider.g.dart';

@riverpod
class DashboardDataNotifier extends _$DashboardDataNotifier {
  @override
  Stream<DashboardData> build() {
    final db = ref.watch(databaseProvider);

    // Watch multiple tables using Drift's customSelect or stream zip.
    // For simplicity, we can watch the tables we need.
    // However, since we need to combine them, watching all updates might trigger frequently.
    
    // Using a Stream.multi or similar, but the easiest is to just watch the tables
    // and recompute. We will watch rides, charges, maintenance, expenses, reminders.

    final stream = db.customSelect(
      'SELECT 1', // Dummy select to just trigger on any change if we use a trigger
      readsFrom: {
        db.ridesTable,
        db.chargeLogsTable,
        db.maintenanceLogsTable,
        db.expensesTable,
        db.remindersTable,
        db.bikesTable,
      },
    ).watch().asyncMap((_) => _computeDashboardData(db));

    // Yield initial data
    _computeDashboardData(db).then((data) {
      if (state.value == null) {
         state = AsyncValue.data(data);
      }
    });

    return stream;
  }

  Future<DashboardData> _computeDashboardData(AppDatabase db) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final weekStart = todayStart.subtract(Duration(days: now.weekday - 1));
    final monthStart = DateTime(now.year, now.month, 1);

    // 1. Rides
    final ridesRows = await (db.select(db.ridesTable)
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();
    
    final rides = ridesRows.map((r) => r.toDomain()).toList();
    
    double totalDistance = 0;
    double todayDistance = 0;
    double weeklyDistance = 0;
    double monthlyDistance = 0;
    double maxOdometer = 0;
    int latestBattery = 100;

    for (final ride in rides) {
      final distance = ride.endOdometer - ride.startOdometer;
      totalDistance += distance;
      
      if (ride.date.isAfter(todayStart) || ride.date.isAtSameMomentAs(todayStart)) {
        todayDistance += distance;
      }
      if (ride.date.isAfter(weekStart) || ride.date.isAtSameMomentAs(weekStart)) {
        weeklyDistance += distance;
      }
      if (ride.date.isAfter(monthStart) || ride.date.isAtSameMomentAs(monthStart)) {
        monthlyDistance += distance;
      }
      
      if (ride.endOdometer > maxOdometer) {
        maxOdometer = ride.endOdometer;
      }
    }

    if (rides.isNotEmpty) {
      latestBattery = rides.first.batteryAfter;
    }

    // 2. Charges
    final chargesRows = await (db.select(db.chargeLogsTable)
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();
    
    final charges = chargesRows.map((c) => c.toDomain()).toList();
    
    double totalChargingCost = 0;
    for (final charge in charges) {
      totalChargingCost += charge.cost;
    }

    // Update battery if charge is more recent than ride
    if (charges.isNotEmpty) {
      if (rides.isEmpty || charges.first.date.isAfter(rides.first.date)) {
        latestBattery = charges.first.endBattery;
      }
    }

    // 3. Reminders
    final remindersRows = await (db.select(db.remindersTable)
          ..where((t) => t.isCompleted.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.targetDate, mode: OrderingMode.asc)]))
        .get();
    
    final reminders = remindersRows.map((r) => r.toDomain()).toList();

    // 4. Recent Activities
    List<RecentActivity> activities = [];
    
    for (var i = 0; i < (rides.length > 5 ? 5 : rides.length); i++) {
      activities.add(RecentActivity(
        id: rides[i].id,
        type: ActivityType.ride,
        date: rides[i].date,
        title: 'Ride',
        subtitle: '${rides[i].startOdometer} - ${rides[i].endOdometer} km',
        value: rides[i].endOdometer - rides[i].startOdometer,
      ));
    }
    
    for (var i = 0; i < (charges.length > 5 ? 5 : charges.length); i++) {
      activities.add(RecentActivity(
        id: charges[i].id,
        type: ActivityType.charge,
        date: charges[i].date,
        title: 'Charge',
        subtitle: '${charges[i].startBattery}% to ${charges[i].endBattery}%',
        value: charges[i].cost,
      ));
    }
    
    activities.sort((a, b) => b.date.compareTo(a.date));
    if (activities.length > 5) {
      activities = activities.sublist(0, 5);
    }

    // 5. Calculations
    // Assume ICE bike gives 40km/l, Petrol price ₹100
    final petrolSaved = (totalDistance / 40) * 100;
    // Assume EV saves ~60g CO2 per km
    final co2Saved = (totalDistance * 60) / 1000; // in kg

    return DashboardData(
      currentOdometer: maxOdometer,
      todayDistance: todayDistance,
      weeklyDistance: weeklyDistance,
      monthlyDistance: monthlyDistance,
      totalDistance: totalDistance,
      lastRide: rides.isNotEmpty ? rides.first : null,
      lastCharge: charges.isNotEmpty ? charges.first : null,
      upcomingReminder: reminders.isNotEmpty ? reminders.first : null,
      recentActivities: activities,
      totalCharges: charges.length,
      totalChargingCost: totalChargingCost,
      petrolSaved: petrolSaved,
      co2Saved: co2Saved,
      latestBatteryPercentage: latestBattery,
    );
  }
}
