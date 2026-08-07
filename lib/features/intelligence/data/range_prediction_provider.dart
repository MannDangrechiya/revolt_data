import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../bikes/data/bike_provider.dart';
import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';
import '../domain/coach_tip.dart';

part 'range_prediction_provider.g.dart';

@riverpod
Future<RangePrediction> rangePrediction(Ref ref) async {
  final liveSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
  final persistedSnapshot = await ref.watch(persistedVehicleSnapshotProvider.future);
  final bike = await ref.watch(currentBikeProvider.future);
  final rides = await ref.watch(ridesProvider.future);
  final now = DateTime.now();

  final batteryPercent = liveSnapshot?.batteryPercent ?? persistedSnapshot?.batteryPercent ?? 0;

  // Calculate real historical consumption (km per % battery) from SQLite rides
  final validRides = rides
      .where((r) => r.batteryConsumed > 0 && r.distance > 0)
      .take(10)
      .toList();

  double historicalKmPerPercent = 0.0;
  if (validRides.isNotEmpty) {
    double totalWeight = 0.0;
    double weightedSum = 0.0;
    for (int i = 0; i < validRides.length; i++) {
      final weight = (validRides.length - i).toDouble();
      final r = validRides[i];
      final eff = r.distance / r.batteryConsumed;
      weightedSum += eff * weight;
      totalWeight += weight;
    }
    historicalKmPerPercent = totalWeight > 0 ? weightedSum / totalWeight : 0.0;
  }

  // Determine baseline efficiency (km/%) dynamically:
  // 1. From real historical SQLite rides
  // 2. Or from live BLE snapshot range (liveSnapshot.range / liveSnapshot.batteryPercent)
  // 3. Or from bike claimed range
  final claimedRange = bike?.claimedRange;
  double dynamicKmPerPercent = 0.0;
  if (historicalKmPerPercent > 0) {
    dynamicKmPerPercent = historicalKmPerPercent;
  } else if (liveSnapshot?.range != null && liveSnapshot!.range! > 0 && batteryPercent > 0) {
    dynamicKmPerPercent = liveSnapshot.range! / batteryPercent;
  } else if (claimedRange != null && claimedRange > 0) {
    dynamicKmPerPercent = claimedRange / 100.0;
  }

  final predictedRange = batteryPercent * dynamicKmPerPercent;

  final margin = predictedRange * 0.1;
  final lowEstimate = (predictedRange - margin).clamp(0.0, double.infinity);
  final highEstimate = predictedRange + margin;

  final confidencePercent = validRides.isNotEmpty
      ? (70.0 + (validRides.length * 2.5)).clamp(70.0, 95.0)
      : (liveSnapshot != null ? 70.0 : 50.0);

  return RangePrediction(
    predictedRangeKm: predictedRange,
    lowEstimate: lowEstimate,
    highEstimate: highEstimate,
    confidencePercent: confidencePercent,
    lastUpdated: now,
  );
}
