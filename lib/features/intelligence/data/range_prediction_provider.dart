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
  final bike = await ref.watch(currentBikeProvider.future);
  final rides = await ref.watch(ridesProvider.future);
  final now = DateTime.now();

  final batteryPercent = liveSnapshot?.batteryPercent ?? 80;
  final claimedRange = bike?.claimedRange ?? 150.0;
  const optimalEfficiency = 1.5; // km per %

  final baseRange = batteryPercent * (claimedRange / 100.0);

  // Weighted average efficiency of last 10 rides
  final validRides = rides
      .where((r) => r.batteryConsumed > 0 && r.distance > 0)
      .take(10)
      .toList();

  double weightedAvgEfficiency = optimalEfficiency;
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
    weightedAvgEfficiency =
        totalWeight > 0 ? weightedSum / totalWeight : optimalEfficiency;
  }

  final efficiencyMultiplier =
      (weightedAvgEfficiency / optimalEfficiency).clamp(0.6, 1.4);
  final predictedRange = baseRange * efficiencyMultiplier;

  final margin = predictedRange * 0.1;
  final lowEstimate = (predictedRange - margin).clamp(0.0, double.infinity);
  final highEstimate = predictedRange + margin;

  final confidencePercent =
      (70.0 + (validRides.length * 2.5)).clamp(70.0, 95.0);

  return RangePrediction(
    predictedRangeKm: predictedRange,
    lowEstimate: lowEstimate,
    highEstimate: highEstimate,
    confidencePercent: confidencePercent,
    lastUpdated: now,
  );
}
