import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../rides/data/rides_provider.dart';
import '../../charging/data/charging_provider.dart';
import '../../expenses/data/expenses_provider.dart';

part 'efficiency_service.g.dart';

class EfficiencyStats {
  final double kmPerPercentBattery;
  final double kmPerCharge;
  final double kmPerKwh;
  final double costPerKm;
  final double bestEfficiencyKmPerPercent;
  final double worstEfficiencyKmPerPercent;
  final Map<DateTime, double> dailyAverageDistance;

  EfficiencyStats({
    required this.kmPerPercentBattery,
    required this.kmPerCharge,
    required this.kmPerKwh,
    required this.costPerKm,
    required this.bestEfficiencyKmPerPercent,
    required this.worstEfficiencyKmPerPercent,
    required this.dailyAverageDistance,
  });
}

@riverpod
Future<EfficiencyStats> efficiencyStats(Ref ref) async {
  final rides = await ref.watch(ridesProvider.future);
  final charges = await ref.watch(chargingLogsProvider.future);
  final expenses = await ref.watch(expensesProvider.future);

  double totalDistance = 0.0;
  double totalBatteryUsed = 0.0;
  double totalCost = 0.0;
  double totalKwh = 0.0;

  double bestEfficiency = 0.0;
  double worstEfficiency = double.infinity;
  
  Map<DateTime, double> dailyDistance = {};

  for (var ride in rides) {
    double distance = (ride.endOdometer - ride.startOdometer).abs();
    int batteryUsed = (ride.batteryBefore - ride.batteryAfter).abs();
    
    totalDistance += distance;
    totalBatteryUsed += batteryUsed;

    if (batteryUsed > 0) {
      double efficiency = distance / batteryUsed;
      if (efficiency > bestEfficiency) bestEfficiency = efficiency;
      if (efficiency < worstEfficiency) worstEfficiency = efficiency;
    }

    DateTime day = DateTime(ride.date.year, ride.date.month, ride.date.day);
    dailyDistance[day] = (dailyDistance[day] ?? 0.0) + distance;
  }

  for (var charge in charges) {
    totalKwh += charge.kwhAdded;
  }

  for (var expense in expenses) {
    totalCost += expense.amount;
  }

  double kmPerPercent = totalBatteryUsed > 0 ? totalDistance / totalBatteryUsed : 0;
  double kmPerCharge = charges.isNotEmpty ? totalDistance / charges.length : totalDistance;
  double kmPerKwh = totalKwh > 0 ? totalDistance / totalKwh : 0;
  double costPerKm = totalDistance > 0 ? totalCost / totalDistance : 0;

  if (worstEfficiency == double.infinity) worstEfficiency = 0;

  return EfficiencyStats(
    kmPerPercentBattery: kmPerPercent,
    kmPerCharge: kmPerCharge,
    kmPerKwh: kmPerKwh,
    costPerKm: costPerKm,
    bestEfficiencyKmPerPercent: bestEfficiency,
    worstEfficiencyKmPerPercent: worstEfficiency,
    dailyAverageDistance: dailyDistance,
  );
}
