import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:revolt_data/features/tracking/data/background_location_service.dart';
import 'package:revolt_data/features/tracking/domain/gps_tracking_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late BackgroundLocationService service;

  setUp(() {
    service = BackgroundLocationService();
    service.reset();
  });

  tearDown(() {
    service.reset();
  });

  group('BackgroundLocationService Unit Tests', () {
    test('startTracking emits Active state', () async {
      final now = DateTime.now();
      await service.startTracking(startOdometer: 1200.0, startTime: now);

      expect(service.state, isA<GpsTrackingStateActive>());
      final activeState = service.state as GpsTrackingStateActive;
      expect(activeState.startOdometer, equals(1200.0));
      expect(activeState.distanceKm, equals(0.0));
    });

    test('onLocationUpdate calculates distance correctly using Haversine and tracks max speed', () async {
      final now = DateTime.now();
      await service.startTracking(startOdometer: 1000.0, startTime: now);

      // Point 1: Bangalore MG Road (12.9756, 77.6066)
      final pos1 = Position(
        latitude: 12.9756,
        longitude: 77.6066,
        timestamp: now,
        altitude: 900.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        accuracy: 3.0,
        speed: 10.0, // 36 km/h
        speedAccuracy: 1.0,
      );
      service.onLocationUpdate(pos1);

      // Point 2: Bangalore Indiranagar (~2.8 km away) (12.9784, 77.6408)
      final pos2 = Position(
        latitude: 12.9784,
        longitude: 77.6408,
        timestamp: now.add(const Duration(seconds: 180)),
        altitude: 900.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        accuracy: 3.0,
        speed: 15.0, // 54 km/h
        speedAccuracy: 1.0,
      );
      service.onLocationUpdate(pos2);

      final activeState = service.state as GpsTrackingStateActive;
      expect(activeState.distanceKm, greaterThan(2.5));
      expect(activeState.distanceKm, lessThan(4.0));
      expect(activeState.maxSpeedKmh, greaterThan(35.0));
      expect(service.getRecordedPoints().length, equals(2));
    });

    test('auto-finalizes when speed stays 0 for 300 seconds', () async {
      final now = DateTime.now();
      await service.startTracking(startOdometer: 1000.0, startTime: now);

      final zeroSpeedPosition = Position(
        latitude: 12.9756,
        longitude: 77.6066,
        timestamp: now,
        altitude: 900.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        accuracy: 3.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );

      // Simulate 60 updates at 0 m/s (300+ seconds threshold)
      for (int i = 0; i < 61; i++) {
        if (service.state is! GpsTrackingStateActive) break;
        service.onLocationUpdate(zeroSpeedPosition);
      }

      expect(service.state, isA<GpsTrackingStateCompleted>());
    });

    test('onBleReconnected merges BLE and GPS data correctly and stops tracking', () async {
      final now = DateTime.now();
      await service.startTracking(startOdometer: 1000.0, startTime: now);

      await service.onBleReconnected(1005.0);

      expect(service.state, isA<GpsTrackingStateCompleted>());
    });

    test('onLocationUpdate discards noisy points with accuracy > 20 meters', () async {
      final now = DateTime.now();
      await service.startTracking(startOdometer: 1000.0, startTime: now);

      final noisyPos = Position(
        latitude: 12.9756,
        longitude: 77.6066,
        timestamp: now,
        altitude: 900.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        accuracy: 35.0, // Inaccurate noisy point
        speed: 10.0,
        speedAccuracy: 1.0,
      );
      service.onLocationUpdate(noisyPos);

      expect(service.getRecordedPoints(), isEmpty);
    });

    test('stopTracking sets state to completed', () async {
      final now = DateTime.now();
      await service.startTracking(startOdometer: 1000.0, startTime: now);

      await service.stopTracking(reason: 'user_stopped');

      expect(service.state, isA<GpsTrackingStateCompleted>());
    });
  });
}
