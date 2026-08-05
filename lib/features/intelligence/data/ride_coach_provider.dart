import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';
import '../../bikes/data/bike_provider.dart';
import '../domain/coach_tip.dart';

part 'ride_coach_provider.g.dart';

@riverpod
Future<RideCoachTip> rideCoach(Ref ref) async {
  final rides = await ref.watch(ridesProvider.future);
  final bike = await ref.watch(currentBikeProvider.future);
  final now = DateTime.now();

  final claimedRange = bike?.claimedRange ?? 150.0;
  final optimalEfficiency = claimedRange / 100.0; // km per % battery

  if (rides.isEmpty) {
    return RideCoachTip(
      tip: 'Great riding habits! Your efficiency is above average.',
      severity: CoachSeverity.info,
      confidence: 70.0,
      lastUpdated: now,
    );
  }

  // Compute average efficiency across rides where battery was consumed
  final validRides =
      rides.where((r) => r.batteryConsumed > 0 && r.distance > 0).toList();
  final totalDist = validRides.fold<double>(0, (s, r) => s + r.distance);
  final totalBatt = validRides.fold<int>(0, (s, r) => s + r.batteryConsumed);

  final avgEfficiency = validRides.isNotEmpty && totalBatt > 0
      ? totalDist / totalBatt
      : optimalEfficiency;

  // Check avg highway speed
  final speedRides = rides
      .where((r) => r.averageSpeed != null && r.averageSpeed! > 0)
      .toList();
  final avgHighwaySpeed = speedRides.isNotEmpty
      ? speedRides.map((r) => r.averageSpeed!).reduce((a, b) => a + b) /
          speedRides.length
      : 0.0;

  // Check hard acceleration proxy (> 5 per ride average)
  final hardAccCount = rides
      .where((r) =>
          r.maxSpeed != null &&
          r.averageSpeed != null &&
          r.averageSpeed! > 0 &&
          (r.maxSpeed! / r.averageSpeed! > 1.8 || r.maxSpeed! > 75))
      .length;
  final avgHardAcc =
      validRides.isNotEmpty ? hardAccCount / validRides.length * 6.0 : 0.0;

  if (avgEfficiency < 0.8 * optimalEfficiency) {
    final diffPct =
        (((optimalEfficiency - avgEfficiency) / optimalEfficiency) * 100)
            .round();
    return RideCoachTip(
      tip:
          'Your ride efficiency is $diffPct% below optimal. Try Eco mode for city rides.',
      severity: CoachSeverity.warning,
      confidence: 85.0,
      lastUpdated: now,
    );
  } else if (avgHighwaySpeed > 55.0) {
    final roundedSpeed = avgHighwaySpeed.round();
    return RideCoachTip(
      tip:
          'Average speed on highway rides is $roundedSpeed km/h. Optimal for range is 45-50 km/h.',
      severity: CoachSeverity.warning,
      confidence: 80.0,
      lastUpdated: now,
    );
  } else if (avgHardAcc > 5.0) {
    return RideCoachTip(
      tip:
          'You accelerate hard frequently. Gentle acceleration improves range by ~10%.',
      severity: CoachSeverity.warning,
      confidence: 75.0,
      lastUpdated: now,
    );
  } else {
    return RideCoachTip(
      tip: 'Great riding habits! Your efficiency is above average.',
      severity: CoachSeverity.info,
      confidence: 90.0,
      lastUpdated: now,
    );
  }
}
