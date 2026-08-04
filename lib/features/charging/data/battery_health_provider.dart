import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
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
int? batteryHealthEstimate(Ref ref) {
  final snapshot = ref.watch(lastKnownVehicleSnapshotProvider);
  if (snapshot == null) return null;
  final health = snapshot.batteryHealth;
  if (health == null || health <= 0) return null;
  return health;
}
