import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/sync/data/duplicate_detector.dart';
import 'package:revolt_data/features/sync/domain/missed_ride_candidate.dart';

void main() {
  group('DuplicateDetector Unit Tests', () {
    final now = DateTime(2026, 8, 6, 12, 0);

    final existingRide = Ride(
      id: 'ride_101',
      date: now,
      startOdometer: 100.0,
      endOdometer: 110.0,
      batteryBefore: 80,
      batteryAfter: 70,
      rideMode: RideMode.normal,
      roadCondition: RoadCondition.smooth,
      startTime: now,
      endTime: now.add(const Duration(minutes: 20)),
      durationMinutes: 20,
    );

    test('duplicate detector finds match within 10 min and 0.5 km', () {
      final candidate = MissedRideCandidate(
        id: 'cand_1',
        estimatedStartTime: now.add(const Duration(minutes: 3)),
        estimatedEndTime: now.add(const Duration(minutes: 23)),
        odometerDeltaKm: 10.2,
        gpsDistanceKm: null,
        gpsMaxSpeedKmh: null,
        gpsRoute: null,
        confidence: 'medium',
        dataSource: 'odometer_only',
      );

      final isDup = DuplicateDetector.isDuplicate(
        candidate: candidate,
        existingRides: [existingRide],
      );

      expect(isDup, isTrue);
    });

    test('duplicate detector returns false for genuinely different rides', () {
      final candidate = MissedRideCandidate(
        id: 'cand_2',
        estimatedStartTime: now.add(const Duration(hours: 4)),
        estimatedEndTime: now.add(const Duration(hours: 4, minutes: 30)),
        odometerDeltaKm: 25.0,
        gpsDistanceKm: null,
        gpsMaxSpeedKmh: null,
        gpsRoute: null,
        confidence: 'medium',
        dataSource: 'odometer_only',
      );

      final isDup = DuplicateDetector.isDuplicate(
        candidate: candidate,
        existingRides: [existingRide],
      );

      expect(isDup, isFalse);
    });
  });
}
