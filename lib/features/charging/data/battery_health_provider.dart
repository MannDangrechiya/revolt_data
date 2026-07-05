import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';
import '../domain/charge_log.dart';
import 'charging_provider.dart';

part 'battery_health_provider.g.dart';

@riverpod
Future<int> totalChargeCycles(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  
  // A charge cycle is equivalent to 100% of battery capacity being discharged/charged.
  final totalBatteryAdded = logs.fold<int>(0, (sum, log) => sum + log.batteryAdded);
  return totalBatteryAdded ~/ 100;
}

@riverpod
Future<double> powerEfficiency(Ref ref) async {
  final rides = await ref.watch(ridesProvider.future);
  final logs = await ref.watch(chargingLogsProvider.future);
  
  if (rides.isEmpty || logs.isEmpty) return 0.0;
  
  final totalDistance = rides.fold<double>(0.0, (sum, ride) => sum + ride.distance);
  final totalKwh = logs.fold(0.0, (sum, log) => sum + log.kwhAdded);
  
  if (totalKwh == 0) return 0.0;
  return totalDistance / totalKwh; // km per kWh
}

@riverpod
Future<double> batteryHealthEstimate(Ref ref) async {
  final cycles = await ref.watch(totalChargeCyclesProvider.future);
  
  // Simple heuristic: subtract 0.01% health per cycle, max 100%, min 0%
  double health = 100.0 - (cycles * 0.01);
  return health.clamp(0.0, 100.0);
}
