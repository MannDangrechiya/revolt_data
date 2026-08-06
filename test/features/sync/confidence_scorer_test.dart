import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/sync/data/confidence_scorer.dart';
import 'package:revolt_data/features/sync/domain/missed_ride_candidate.dart';
import 'package:revolt_data/features/tracking/domain/gps_point.dart';

void main() {
  group('ConfidenceScorer Unit Tests', () {
    test('confidence scorer returns high when GPS and odometer match within 5%', () {
      final candidate = MissedRideCandidate(
        id: 'c1',
        estimatedStartTime: DateTime(2026, 8, 6, 10, 0),
        estimatedEndTime: DateTime(2026, 8, 6, 10, 30),
        odometerDeltaKm: 10.0,
        gpsDistanceKm: 10.2, // 2% deviation (< 10%)
        gpsMaxSpeedKmh: 45.0,
        gpsRoute: [
          GpsPoint(
            latitude: 12.9716,
            longitude: 77.5946,
            speedKmh: 45.0,
            timestamp: DateTime(2026, 8, 6, 10, 0),
            accuracy: 5.0,
          ),
        ],
        confidence: 'low',
        dataSource: 'merged',
      );

      final confidence = ConfidenceScorer.calculateConfidence(candidate);
      expect(confidence, equals('high'));
    });

    test('confidence scorer returns low when only odometer delta with 8+ hour gap', () {
      final candidate = MissedRideCandidate(
        id: 'c2',
        estimatedStartTime: DateTime(2026, 8, 6, 8, 0),
        estimatedEndTime: DateTime(2026, 8, 6, 17, 0), // 9 hour gap
        odometerDeltaKm: 15.0,
        gpsDistanceKm: null,
        gpsMaxSpeedKmh: null,
        gpsRoute: null,
        confidence: 'low',
        dataSource: 'odometer_only',
      );

      final confidence = ConfidenceScorer.calculateConfidence(candidate);
      expect(confidence, equals('low'));
    });

    test('confidence scorer returns medium when distance match deviation >= 10%', () {
      final candidate = MissedRideCandidate(
        id: 'c3',
        estimatedStartTime: DateTime(2026, 8, 6, 10, 0),
        estimatedEndTime: DateTime(2026, 8, 6, 10, 30),
        odometerDeltaKm: 10.0,
        gpsDistanceKm: 12.0, // 20% deviation (>= 10%)
        gpsMaxSpeedKmh: 45.0,
        gpsRoute: [
          GpsPoint(
            latitude: 12.9716,
            longitude: 77.5946,
            speedKmh: 45.0,
            timestamp: DateTime(2026, 8, 6, 10, 0),
            accuracy: 5.0,
          ),
        ],
        confidence: 'low',
        dataSource: 'merged',
      );

      final confidence = ConfidenceScorer.calculateConfidence(candidate);
      expect(confidence, equals('medium'));
    });
  });
}
