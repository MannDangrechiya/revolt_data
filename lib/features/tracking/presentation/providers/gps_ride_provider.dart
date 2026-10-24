import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../../rides/data/rides_provider.dart';
import '../../../rides/domain/ride.dart';
import '../../data/background_location_service.dart';
import '../../data/ride_merger.dart';
import '../../domain/gps_tracking_state.dart';
import '../../../sync/data/sync_state_service.dart';

part 'gps_ride_provider.g.dart';

/// Typical RV400 energy consumption used to estimate GPS-only ride battery use.
const double kEstimatedWhPerKm = 30.0;

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

  /// Starts a commute GPS ride from the commute notification or banner.
  ///
  /// Returns false if location permission is missing; no-op (true) when a
  /// ride is already being tracked.
  Future<bool> startCommuteTracking() async {
    if (state is GpsTrackingStateActive) return true;
    final service = BackgroundLocationService();
    if (!await service.requestPermissions()) return false;
    await startGpsTracking(startOdometer: _resolveStartOdometer());
    return true;
  }

  double _resolveStartOdometer() {
    final snapshot = ref.read(lastKnownVehicleSnapshotProvider);
    final persisted = ref.read(persistedVehicleSnapshotProvider).value;
    final syncState = ref.read(syncStateServiceProvider).value;
    return snapshot?.odometer ??
        persisted?.odometer ??
        syncState?.getCalibratedOdometer() ??
        19920.0;
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
      final startOdo = _resolveStartOdometer();
      final batteryAfter = (batteryPercent -
              estimateBatteryDropPercent(currentState.totalDistanceKm))
          .clamp(0, batteryPercent)
          .toInt();

      final ride = Ride(
        id: now.millisecondsSinceEpoch.toString(),
        date: currentState.startTime,
        startOdometer: startOdo,
        endOdometer: startOdo + currentState.totalDistanceKm,
        batteryBefore: batteryPercent,
        batteryAfter: batteryAfter,
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

  /// Estimated state-of-charge drop for a GPS-only ride, from the typical
  /// RV400 consumption of [kEstimatedWhPerKm] (no BLE battery readings exist
  /// while disconnected).
  static int estimateBatteryDropPercent(double distanceKm) {
    final usedKwh = distanceKm * kEstimatedWhPerKm / 1000.0;
    return (usedKwh / AppConstants.defaultBatteryCapacityKwh * 100).round();
  }

  Future<void> stopGpsTracking() async {
    await BackgroundLocationService().stopTracking();
  }
}
