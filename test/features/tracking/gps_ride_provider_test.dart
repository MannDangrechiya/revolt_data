import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_data/features/rides/data/rides_provider.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/tracking/data/background_location_service.dart';
import 'package:revolt_data/features/tracking/domain/gps_tracking_state.dart';
import 'package:revolt_data/features/tracking/presentation/providers/gps_ride_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;

  setUp(() {
    BackgroundLocationService().reset();
    container = ProviderContainer(
      overrides: [
        ridesProvider.overrideWith(() => MockRides()),
      ],
    );
  });

  tearDown(() {
    BackgroundLocationService().reset();
    container.dispose();
  });

  group('GpsRideNotifier Unit Tests', () {
    test('startGpsTracking emits Active state', () async {
      final notifier = container.read(gpsRideProvider.notifier);

      await notifier.startGpsTracking(startOdometer: 500.0);

      final state = container.read(gpsRideProvider);
      expect(state, isA<GpsTrackingStateActive>());
      final active = state as GpsTrackingStateActive;
      expect(active.startOdometer, equals(500.0));
    });

    test('location updates append to route list', () async {
      final notifier = container.read(gpsRideProvider.notifier);

      await notifier.startGpsTracking(startOdometer: 500.0);

      final pos = Position(
        latitude: 12.9716,
        longitude: 77.5946,
        timestamp: DateTime.now(),
        altitude: 900.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        accuracy: 2.0,
        speed: 8.5,
        speedAccuracy: 1.0,
      );

      notifier.onLocationUpdate(pos);

      final state = container.read(gpsRideProvider);
      expect(state, isA<GpsTrackingStateActive>());
      final active = state as GpsTrackingStateActive;
      expect(active.route.length, equals(1));
      expect(active.route.first.latitude, equals(12.9716));
    });

    test('finalizeGpsRide emits Completed state after finalization', () async {
      final notifier = container.read(gpsRideProvider.notifier);

      await notifier.startGpsTracking(startOdometer: 500.0);
      await notifier.finalizeGpsRide();

      final state = container.read(gpsRideProvider);
      expect(state, isA<GpsTrackingStateCompleted>());
    });
  });
}

class MockRides extends Rides {
  @override
  Stream<List<Ride>> build() {
    return Stream.value([]);
  }

  @override
  Future<void> addRide(Ride ride, {String source = 'manual'}) async {
    // No-op for testing
  }
}
