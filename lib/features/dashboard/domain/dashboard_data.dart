import 'package:freezed_annotation/freezed_annotation.dart';

import '../../rides/domain/ride.dart';
import '../../charging/domain/charge_log.dart';
import '../../reminders/domain/reminder.dart';

part 'dashboard_data.freezed.dart';

enum ActivityType { ride, charge, maintenance, expense }

@freezed
class RecentActivity with _$RecentActivity {
  const factory RecentActivity({
    required String id,
    required ActivityType type,
    required DateTime date,
    required String title,
    required String subtitle,
    required double value, // e.g. distance, kwh, cost
  }) = _RecentActivity;
}

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required double currentOdometer,
    required double todayDistance,
    required double weeklyDistance,
    required double monthlyDistance,
    required double totalDistance,
    Ride? lastRide,
    ChargeLog? lastCharge,
    Reminder? upcomingReminder,
    @Default([]) List<RecentActivity> recentActivities,
    required int totalCharges,
    required double totalChargingCost,
    required double petrolSaved, // Assume ~ 1 liter per 40km, ₹100/liter
    required double co2Saved, // Assume ~ 40g/km for EV vs 100g/km for ICE
    required int latestBatteryPercentage,
  }) = _DashboardData;
}
