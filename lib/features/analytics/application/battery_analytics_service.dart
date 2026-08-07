import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../rides/data/rides_provider.dart';
import '../../charging/data/charging_provider.dart';

part 'battery_analytics_service.g.dart';

class BatteryAnalytics {
  final int totalChargeCycles;
  final int fullCharges;
  final double averageChargingDurationMins;
  final double averageBatteryUsagePerTrip;
  final double bestRange;
  final double worstRange;
  final double currentHealthPercent;

  BatteryAnalytics({
    required this.totalChargeCycles,
    required this.fullCharges,
    required this.averageChargingDurationMins,
    required this.averageBatteryUsagePerTrip,
    required this.bestRange,
    required this.worstRange,
    required this.currentHealthPercent,
  });
}

@riverpod
Future<BatteryAnalytics> batteryAnalytics(Ref ref) async {
  final rides = await ref.watch(ridesProvider.future);
  final charges = await ref.watch(chargingLogsProvider.future);
  final liveSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
  final persistedSnapshot = await ref.watch(persistedVehicleSnapshotProvider.future);

  int totalChargeCycles = charges.length;
  int fullCharges = charges.where((c) => c.endBattery == 100).length;

  double totalDuration = charges.fold(0.0, (sum, c) => sum + c.durationMinutes);
  double avgDuration = charges.isEmpty ? 0 : totalDuration / charges.length;

  double totalBatteryUsage = rides.fold(0.0, (sum, r) => sum + (r.batteryBefore - r.batteryAfter).abs());
  double avgBatteryUsage = rides.isEmpty ? 0 : totalBatteryUsage / rides.length;

  double bestRange = 0;
  double worstRange = double.infinity;

  // Calculate range per charge cycle equivalent
  // Range estimate: (distance / battery_used) * 100
  for (var ride in rides) {
    int batteryUsed = (ride.batteryBefore - ride.batteryAfter).abs();
    if (batteryUsed > 5) { // Meaningful trips only
      double distance = (ride.endOdometer - ride.startOdometer).abs();
      double extrapolatedRange = (distance / batteryUsed) * 100;
      
      if (extrapolatedRange > bestRange) bestRange = extrapolatedRange;
      if (extrapolatedRange < worstRange) worstRange = extrapolatedRange;
    }
  }

  if (worstRange == double.infinity) worstRange = 0;

  // Dynamic battery health from SOH telemetry in vehicle snapshot (or 100% default if unrecorded)
  final soh = liveSnapshot?.batteryHealth ?? persistedSnapshot?.batteryHealth;
  double health = soh != null ? soh.toDouble() : 100.0;

  return BatteryAnalytics(
    totalChargeCycles: totalChargeCycles,
    fullCharges: fullCharges,
    averageChargingDurationMins: avgDuration,
    averageBatteryUsagePerTrip: avgBatteryUsage,
    bestRange: bestRange,
    worstRange: worstRange,
    currentHealthPercent: health,
  );
}
