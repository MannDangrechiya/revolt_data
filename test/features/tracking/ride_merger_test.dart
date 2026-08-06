import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/tracking/data/ride_merger.dart';
import 'package:revolt_data/features/tracking/domain/gps_point.dart';

void main() {
  group('RideMerger Unit Tests', () {
    final now = DateTime.now();

    test('mergeBleAndGps prefers odometer distance when larger', () {
      final bleData = BleTripData(
        startTime: now.subtract(const Duration(minutes: 10)),
        endTime: now,
        startOdometer: 1000.0,
        endOdometer: 1005.5, // 5.5 km
        odometerDelta: 5.5,
        maxSpeed: 45.0,
        averageSpeed: 33.0,
        startBattery: 90,
        endBattery: 85,
      );

      final gpsData = GpsTrackingData(
        startTime: now.subtract(const Duration(minutes: 10)),
        endTime: now,
        gpsDistance: 4.2, // 4.2 km
        maxSpeed: 40.0,
        averageSpeed: 25.2,
        route: [
          GpsPoint(
            latitude: 12.9716,
            longitude: 77.5946,
            speedKmh: 30.0,
            timestamp: now,
            accuracy: 5.0,
          ),
        ],
      );

      final merged = RideMerger.mergeBleAndGps(bleData: bleData, gpsData: gpsData);

      expect(merged.totalDistanceKm, equals(5.5));
      expect(merged.source, equals('merged'));
    });

    test('mergeBleAndGps prefers GPS distance when larger', () {
      final bleData = BleTripData(
        startTime: now.subtract(const Duration(minutes: 10)),
        endTime: now,
        startOdometer: 1000.0,
        endOdometer: 1002.0, // 2.0 km (e.g., missed BLE packets)
        odometerDelta: 2.0,
        maxSpeed: 30.0,
        averageSpeed: 20.0,
        startBattery: 90,
        endBattery: 85,
      );

      final gpsData = GpsTrackingData(
        startTime: now.subtract(const Duration(minutes: 10)),
        endTime: now,
        gpsDistance: 4.8, // 4.8 km
        maxSpeed: 52.0,
        averageSpeed: 28.8,
        route: [
          GpsPoint(
            latitude: 12.9716,
            longitude: 77.5946,
            speedKmh: 45.0,
            timestamp: now,
            accuracy: 4.0,
          ),
        ],
      );

      final merged = RideMerger.mergeBleAndGps(bleData: bleData, gpsData: gpsData);

      expect(merged.totalDistanceKm, equals(4.8));
      expect(merged.source, equals('merged'));
    });

    test('mergeBleAndGps takes max of BLE and GPS maxSpeed', () {
      final bleData = BleTripData(
        startTime: now.subtract(const Duration(minutes: 10)),
        endTime: now,
        startOdometer: 1000.0,
        endOdometer: 1005.0,
        odometerDelta: 5.0,
        maxSpeed: 42.0,
        averageSpeed: 30.0,
        startBattery: 90,
        endBattery: 85,
      );

      final gpsData = GpsTrackingData(
        startTime: now.subtract(const Duration(minutes: 10)),
        endTime: now,
        gpsDistance: 5.0,
        maxSpeed: 58.5,
        averageSpeed: 30.0,
        route: [],
      );

      final merged = RideMerger.mergeBleAndGps(bleData: bleData, gpsData: gpsData);

      expect(merged.maxSpeedKmh, equals(58.5));
      expect(merged.source, equals('merged'));
    });

    test('encodeRoutePolyline and decodeRoutePolyline handle round-trip serialization', () {
      final route = [
        GpsPoint(
          latitude: 12.9716,
          longitude: 77.5946,
          speedKmh: 35.5,
          timestamp: DateTime.parse('2026-08-06T10:00:00Z'),
          accuracy: 3.2,
        ),
        GpsPoint(
          latitude: 12.9750,
          longitude: 77.5980,
          speedKmh: 42.0,
          timestamp: DateTime.parse('2026-08-06T10:01:00Z'),
          accuracy: 2.8,
        ),
      ];

      final jsonStr = RideMerger.encodeRoutePolyline(route);
      final decoded = RideMerger.decodeRoutePolyline(jsonStr);

      expect(decoded.length, equals(2));
      expect(decoded.first.latitude, equals(12.9716));
      expect(decoded.last.speedKmh, equals(42.0));
    });
  });
}
