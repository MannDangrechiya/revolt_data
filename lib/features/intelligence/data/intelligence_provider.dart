import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../charging/data/battery_health_provider.dart';
import '../../charging/data/charging_provider.dart';
import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';
import '../../maintenance/data/maintenance_provider.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';

part 'intelligence_provider.g.dart';

/// Ride score heuristic (0-100), computed from fields already on [Ride] —
/// no DB access needed, so this is a plain function rather than a provider.
/// Weighted: efficiency (km per % battery used, vs a ~150km-range baseline)
/// 70%, throttle smoothness (avg/max speed ratio) 30% when speed data exists.
int calculateRideScore(Ride ride) {
  // ponytail: 1.5 km/% is the RV400's claimed-range baseline (150km / 100%),
  // not a per-bike value — good enough for a relative score, revisit if
  // per-bike claimedRange should feed this instead.
  const expectedKmPerPercent = 1.5;
  final batteryUsed = ride.batteryConsumed;
  final efficiencyRatio = batteryUsed > 0
      ? (ride.distance / batteryUsed) / expectedKmPerPercent
      : 1.0;
  final efficiencyScore = efficiencyRatio.clamp(0.0, 1.2) / 1.2 * 70;

  final avg = ride.averageSpeed;
  final max = ride.maxSpeed;
  if (avg == null || max == null || max <= 0) {
    return (efficiencyScore / 70 * 100).round().clamp(0, 100);
  }

  final smoothnessScore = (avg / max).clamp(0.0, 1.0) * 30;
  return (efficiencyScore + smoothnessScore).round().clamp(0, 100);
}

/// Health score (0-100): battery degradation rate 40%, days since last
/// service 30%, live fault status 30%.
@riverpod
Future<int> healthScore(Ref ref) async {
  final degradation =
      await ref.watch(batteryHealthDegradationRateProvider.future);
  final maintenanceLogs = await ref.watch(maintenanceLogsProvider.future);
  final liveSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);

  // 0%/month degradation -> full marks, 2%/month or worse -> 0.
  final degradationScore = (1 - (degradation / 2.0).clamp(0.0, 1.0)) * 40;

  double serviceScore;
  if (maintenanceLogs.isEmpty) {
    serviceScore = 20; // no service history yet -- can't claim full health
  } else {
    final lastService =
        maintenanceLogs.map((l) => l.date).reduce((a, b) => a.isAfter(b) ? a : b);
    final daysSince = DateTime.now().difference(lastService).inDays;
    // Within 90 days -> full marks, 365+ days -> 0.
    final overdueRatio = ((daysSince - 90) / (365 - 90)).clamp(0.0, 1.0);
    serviceScore = (1 - overdueRatio) * 30;
  }

  final hasFaults = liveSnapshot?.faultCodes.isNotEmpty ?? false;
  final faultScore = hasFaults ? 0.0 : 30.0;

  return (degradationScore + serviceScore + faultScore).round().clamp(0, 100);
}

/// Data-driven maintenance tips. Each rule only fires when there's enough
/// history to support it -- no random/static copy.
@riverpod
Future<List<String>> smartAlerts(Ref ref) async {
  final alerts = <String>[];

  final history = await ref.watch(batteryHealthHistoryProvider.future);
  final liveHealth = ref.watch(batteryHealthEstimateProvider);
  final latestHealth =
      history.isNotEmpty ? history.last.healthPercent : liveHealth?.toDouble();
  if (latestHealth != null && latestHealth < 80) {
    alerts.add('Consider battery check-up');
  }

  const slowChargerThresholdKw = 1.5;
  final avgSpeed = await ref.watch(averageChargingSpeedProvider.future);
  if (avgSpeed > 0 && avgSpeed < slowChargerThresholdKw) {
    alerts.add('Slow charger detected frequently. Try a faster outlet.');
  }

  final rides = await ref.watch(ridesProvider.future);
  if (rides.isNotEmpty) {
    final lastRideDate =
        rides.map((r) => r.date).reduce((a, b) => a.isAfter(b) ? a : b);
    final noRideInDays = DateTime.now().difference(lastRideDate).inDays;
    if (noRideInDays > 7) {
      alerts.add('Time for a ride to keep your battery healthy');
    }
  }

  final chargeLogs = await ref.watch(chargingLogsProvider.future);
  if (chargeLogs.length >= 3) {
    // chargingLogsProvider is already sorted newest-first.
    final recent = chargeLogs.take(5).toList();
    final fullChargeRatio =
        recent.where((c) => c.endBattery >= 100).length / recent.length;
    if (fullChargeRatio > 0.5) {
      alerts.add('Charging to 100% daily reduces battery life. Try 80%.');
    }
  }

  return alerts;
}
