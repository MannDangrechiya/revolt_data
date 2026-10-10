import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../../rides/data/rides_provider.dart';
import '../../../rides/domain/ride.dart';
import '../../data/background_location_service.dart';
import '../../data/ride_merger.dart';
import '../../domain/gps_tracking_state.dart';

part 'gps_ride_provider.g.dart';

@Riverpod(keepAlive: true)
class GpsRideNotifier extends _$GpsRideNotifier {
  @override
  GpsTrackingState build() {
    final service = BackgroundLocationService();
    final subscription = service.trackingStateStream.listen((newState) {
      state = newState;
    });
    ref.onDispose(() {
      subscription.cancel();
    });
    return service.state;
  }

  Future<void> startGpsTracking({
    required double startOdometer,
    DateTime? startTime,
  }) async {
    final service = BackgroundLocationService();
    await service.startTracking(
      startOdometer: startOdometer,
      startTime: startTime ?? DateTime.now(),
    );
  }

  void onLocationUpdate(Position position) {
    BackgroundLocationService().onLocationUpdate(position);
  }

  Future<void> finalizeGpsRide() async {
    final service = BackgroundLocationService();
    if (state is! GpsTrackingStateCompleted) {
      await service.stopTracking(reason: 'user_finalize');
      state = service.state;
    }

    final currentState = state;
    if (currentState is GpsTrackingStateCompleted) {
      final now = DateTime.now();
      final routeJson = RideMerger.encodeRoutePolyline(currentState.route);
      final rideDurationMinutes =
          (currentState.duration.inSeconds / 60).ceil();

      final durationHours = currentState.duration.inSeconds / 3600.0;
      final avgSpeed = durationHours > 0
          ? (currentState.totalDistanceKm / durationHours)
          : currentState.maxSpeedKmh;

      final snapshot = ref.read(lastKnownVehicleSnapshotProvider);
      final persistedSnapshot = ref.read(persistedVehicleSnapshotProvider).value;
      final batteryPercent = snapshot?.batteryPercent ?? persistedSnapshot?.batteryPercent ?? 100;
      final startOdo = snapshot?.odometer ?? persistedSnapshot?.odometer ?? 0.0;

      final ride = Ride(
        id: now.millisecondsSinceEpoch.toString(),
        date: currentState.startTime,
        startOdometer: startOdo,
        endOdometer: startOdo + currentState.totalDistanceKm,
        batteryBefore: batteryPercent,
        batteryAfter: batteryPercent,
        rideMode: RideMode.normal,
        roadCondition: RoadCondition.smooth,
        startTime: currentState.startTime,
        endTime: currentState.endTime,
        durationMinutes: rideDurationMinutes > 0 ? rideDurationMinutes : 1,
        averageSpeed: avgSpeed,
        maxSpeed: currentState.maxSpeedKmh,
        notes:
            'GPS Tracked Ride on ${currentState.startTime.toIso8601String().substring(0, 10)}',
        source: 'gps',
        routePolyline: routeJson,
      );

      try {
        await ref.read(ridesProvider.notifier).addRide(ride, source: 'gps');
      } catch (_) {}
    }
  }

  Future<void> stopGpsTracking() async {
    await BackgroundLocationService().stopTracking();
  }
}
