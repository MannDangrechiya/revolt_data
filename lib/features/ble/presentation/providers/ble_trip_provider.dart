import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../rides/data/rides_provider.dart';
import '../../../rides/domain/ride.dart';
import '../../../tracking/data/background_location_service.dart';
import '../../../tracking/data/ride_merger.dart';
import '../../../tracking/domain/gps_point.dart';
import '../../domain/ble_trip_state.dart';
import '../../domain/connection_state.dart';
import '../../domain/vehicle_snapshot.dart';
import 'ble_connection_provider.dart';
import 'vehicle_snapshot_provider.dart';

part 'ble_trip_provider.g.dart';

@Riverpod(keepAlive: true)
class BleTripNotifier extends _$BleTripNotifier {
  Timer? _zeroSpeedTimer;
  Timer? _disconnectGraceTimer;

  DateTime? _lastTransitionTime;
  final List<double> _speedSamples = [];

  @override
  BleTripState build() {
    // Listen to live telemetry updates
    ref.listen<AsyncValue<VehicleSnapshot>>(vehicleSnapshotProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _handleSnapshot(next.value!);
      }
    });

    // Listen to connection state changes for mid-trip disconnection handling
    ref.listen<AsyncValue<BleConnectionState>>(bleConnectionStateProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _handleConnectionStateChange(next.value!);
      }
    });

    ref.onDispose(() {
      _zeroSpeedTimer?.cancel();
      _disconnectGraceTimer?.cancel();
    });

    return const BleTripState();
  }

  void _handleSnapshot(VehicleSnapshot snapshot) {
    final now = DateTime.now();

    // 1. Idle/Stopped State -> Start Detection
    if (state.status != BleTripStatus.riding && state.status != BleTripStatus.gpsHandoff) {
      if (snapshot.speed > 0 && snapshot.odometer > 0) {
        // Debounce state transitions by 5 seconds
        if (_lastTransitionTime != null &&
            now.difference(_lastTransitionTime!) < const Duration(seconds: 5)) {
          return;
        }

        _startTrip(snapshot, now);
      }
      return;
    }

    // 2. Riding State -> Active Telemetry Tracking
    _speedSamples.add(snapshot.speed);
    final updatedMaxSpeed = snapshot.speed > state.maxSpeed ? snapshot.speed : state.maxSpeed;
    final totalSpeedSum = _speedSamples.fold<double>(0.0, (sum, s) => sum + s);
    final updatedAvgSpeed = _speedSamples.isNotEmpty ? totalSpeedSum / _speedSamples.length : 0.0;
    final calculatedDistance = (snapshot.odometer - state.startOdometer).clamp(0.0, 99999.0);
    final currentDuration = state.startTime != null ? now.difference(state.startTime!).inSeconds : 0;

    state = state.copyWith(
      currentOdometer: snapshot.odometer,
      distance: calculatedDistance,
      durationSeconds: currentDuration,
      currentSpeed: snapshot.speed,
      averageSpeed: updatedAvgSpeed,
      maxSpeed: updatedMaxSpeed,
      currentBattery: snapshot.batteryPercent,
      currentRideMode: snapshot.rideMode,
    );

    // 3. Stop Detection: Speed == 0 for >= 30 seconds
    if (snapshot.speed == 0) {
      if (_zeroSpeedTimer == null || !_zeroSpeedTimer!.isActive) {
        _zeroSpeedTimer = Timer(const Duration(seconds: 30), () {
          _finalizeTrip();
        });
      }
    } else {
      // Speed is > 0, cancel zero speed timer
      _zeroSpeedTimer?.cancel();
      _zeroSpeedTimer = null;
    }
  }

  void _startTrip(VehicleSnapshot snapshot, DateTime now) {
    _zeroSpeedTimer?.cancel();
    _zeroSpeedTimer = null;
    _disconnectGraceTimer?.cancel();
    _disconnectGraceTimer = null;

    _lastTransitionTime = now;
    _speedSamples.clear();
    _speedSamples.add(snapshot.speed);

    state = BleTripState(
      status: BleTripStatus.riding,
      startTime: now,
      startOdometer: snapshot.odometer,
      currentOdometer: snapshot.odometer,
      distance: 0.0,
      durationSeconds: 0,
      currentSpeed: snapshot.speed,
      averageSpeed: snapshot.speed,
      maxSpeed: snapshot.speed,
      startBattery: snapshot.batteryPercent,
      currentBattery: snapshot.batteryPercent,
      currentRideMode: snapshot.rideMode,
      isGpsHandoff: false,
    );
  }

  void _handleConnectionStateChange(BleConnectionState connectionState) {
    if (state.status != BleTripStatus.riding && state.status != BleTripStatus.gpsHandoff) return;

    if (connectionState == BleConnectionState.disconnected ||
        connectionState == BleConnectionState.error) {
      if (!state.isGpsHandoff) {
        state = state.copyWith(
          status: BleTripStatus.gpsHandoff,
          isGpsHandoff: true,
        );

        // Immediately trigger background GPS location service
        BackgroundLocationService().startTracking(
          startOdometer: state.startOdometer,
          startTime: state.startTime ?? DateTime.now(),
        );

        // Start 60s grace timer on disconnection
        _disconnectGraceTimer ??= Timer(const Duration(seconds: 60), () {
          _finalizeTrip();
        });
      }
    } else if (connectionState == BleConnectionState.connected ||
        connectionState == BleConnectionState.authenticated) {
      if (state.isGpsHandoff) {
        // Reconnected within 60s grace period -> resume tracking
        _disconnectGraceTimer?.cancel();
        _disconnectGraceTimer = null;

        BackgroundLocationService().onBleReconnected(state.currentOdometer);

        state = state.copyWith(
          status: BleTripStatus.riding,
          isGpsHandoff: false,
        );
      } else {
        _disconnectGraceTimer?.cancel();
        _disconnectGraceTimer = null;
      }
    }
  }

  Future<void> _finalizeTrip() async {
    _zeroSpeedTimer?.cancel();
    _zeroSpeedTimer = null;
    _disconnectGraceTimer?.cancel();
    _disconnectGraceTimer = null;

    if (state.status != BleTripStatus.riding && state.status != BleTripStatus.gpsHandoff) return;

    final now = DateTime.now();
    _lastTransitionTime = now;

    final bgService = BackgroundLocationService();
    final List<GpsPoint> recordedGpsPoints = bgService.getRecordedPoints();
    final wasGpsHandoff = state.isGpsHandoff;
    await bgService.stopTracking(reason: 'trip_finalized');

    double finalDistance = state.distance;
    double finalMaxSpeed = state.maxSpeed;
    double finalAvgSpeed = state.averageSpeed;
    String rideSource = wasGpsHandoff ? 'merged' : 'ble';
    String? polylineJson;

    if (recordedGpsPoints.isNotEmpty) {
      polylineJson = RideMerger.encodeRoutePolyline(recordedGpsPoints);

      // Calculate GPS distance
      double gpsDist = 0.0;
      double gpsMaxSpd = 0.0;
      for (int i = 0; i < recordedGpsPoints.length; i++) {
        if (recordedGpsPoints[i].speedKmh > gpsMaxSpd) {
          gpsMaxSpd = recordedGpsPoints[i].speedKmh;
        }
        if (i > 0) {
          final p1 = recordedGpsPoints[i - 1];
          final p2 = recordedGpsPoints[i];
          final d = RideMerger.mergeBleAndGps(
            bleData: BleTripData(
              startTime: state.startTime ?? now,
              endTime: now,
              startOdometer: state.startOdometer,
              endOdometer: state.currentOdometer,
              odometerDelta: state.distance,
              maxSpeed: state.maxSpeed,
              averageSpeed: state.averageSpeed,
              startBattery: state.startBattery,
              endBattery: state.currentBattery,
            ),
            gpsData: GpsTrackingData(
              startTime: p1.timestamp,
              endTime: p2.timestamp,
              gpsDistance: 0.0,
              maxSpeed: gpsMaxSpd,
              averageSpeed: gpsMaxSpd,
              route: recordedGpsPoints,
            ),
          );
          gpsDist = d.totalDistanceKm;
        }
      }

      final bleData = BleTripData(
        startTime: state.startTime ?? now,
        endTime: now,
        startOdometer: state.startOdometer,
        endOdometer: state.currentOdometer,
        odometerDelta: state.distance,
        maxSpeed: state.maxSpeed,
        averageSpeed: state.averageSpeed,
        startBattery: state.startBattery,
        endBattery: state.currentBattery,
      );

      final gpsData = GpsTrackingData(
        startTime: recordedGpsPoints.first.timestamp,
        endTime: recordedGpsPoints.last.timestamp,
        gpsDistance: gpsDist,
        maxSpeed: gpsMaxSpd,
        averageSpeed: gpsMaxSpd,
        route: recordedGpsPoints,
      );

      final merged = RideMerger.mergeBleAndGps(bleData: bleData, gpsData: gpsData);
      finalDistance = merged.totalDistanceKm;
      finalMaxSpeed = merged.maxSpeedKmh;
      finalAvgSpeed = merged.averageSpeedKmh;
      rideSource = merged.source;
    }

    final startTime = state.startTime ?? now;

    // Edge Case: Ignore trips shorter than 0.1 km
    if (finalDistance < 0.1) {
      state = state.copyWith(
        status: BleTripStatus.idle,
        endTime: now,
        isGpsHandoff: false,
      );
      return;
    }

    // Duplicate Prevention Check
    final existingRides = ref.read(ridesProvider).value ?? [];
    final isDuplicate = existingRides.any((r) {
      if (r.source != 'ble' && r.source != 'merged') return false;
      final diffMinutes = r.date.difference(startTime).inMinutes.abs();
      final odoMatch = (r.startOdometer - state.startOdometer).abs() < 0.05 &&
                       (r.endOdometer - state.currentOdometer).abs() < 0.05;
      return diffMinutes <= 2 || odoMatch;
    });

    Ride? savedRide;

    if (!isDuplicate) {
      RideMode mode;
      final modeStr = state.currentRideMode.toLowerCase();
      if (modeStr.contains('eco')) {
        mode = RideMode.eco;
      } else if (modeStr.contains('sport')) {
        mode = RideMode.sport;
      } else {
        mode = RideMode.normal;
      }

      final rideDurationMinutes = (state.durationSeconds / 60).ceil();

      final rideToSave = Ride(
        id: now.millisecondsSinceEpoch.toString(),
        date: startTime,
        startOdometer: state.startOdometer,
        endOdometer: state.currentOdometer > state.startOdometer
            ? state.currentOdometer
            : (state.startOdometer + finalDistance),
        batteryBefore: state.startBattery,
        batteryAfter: state.currentBattery,
        rideMode: mode,
        roadCondition: RoadCondition.smooth,
        startTime: startTime,
        endTime: now,
        durationMinutes: rideDurationMinutes > 0 ? rideDurationMinutes : 1,
        averageSpeed: finalAvgSpeed,
        maxSpeed: finalMaxSpeed,
        notes: 'Auto-logged $rideSource Ride on ${startTime.toIso8601String().substring(0, 10)}',
        source: rideSource,
        routePolyline: polylineJson,
      );

      try {
        await ref.read(ridesProvider.notifier).addRide(rideToSave, source: rideSource);
        savedRide = rideToSave;
      } catch (e) {
        debugPrint('Failed to auto-save BLE ride: $e');
      }
    }

    state = state.copyWith(
      status: BleTripStatus.stopped,
      endTime: now,
      isGpsHandoff: false,
      lastSavedRide: savedRide,
    );
  }

  /// Processes a telemetry snapshot (called by stream listeners or test fixtures).
  void processSnapshot(VehicleSnapshot snapshot) {
    _handleSnapshot(snapshot);
  }

  /// Manually force-start a trip (useful for testing or explicit UI triggers).
  void manualStartTrip(VehicleSnapshot snapshot) {
    _startTrip(snapshot, DateTime.now());
  }

  /// Manually force-stop a trip (useful for testing or explicit UI triggers).
  Future<void> manualStopTrip() async {
    await _finalizeTrip();
  }

  /// Force-starts a trip (Debug mode only).
  void forceStart() {
    assert(kDebugMode, 'forceStart only available in debug mode');
    if (!kDebugMode) return;

    final snapshot = VehicleSnapshot(
      batteryPercent: 85,
      batteryVoltage: 72.4,
      batteryCurrent: 12.5,
      batteryTemp: 32,
      motorTemp: 38,
      speed: 35.0,
      tripDistance: 0.0,
      odometer: 1250.0,
      rideMode: 'Eco',
      range: 85.0,
      power: 0.9,
      timestamp: DateTime.now(),
    );
    _startTrip(snapshot, DateTime.now());
  }

  /// Force-stops a trip (Debug mode only).
  Future<void> forceStop() async {
    assert(kDebugMode, 'forceStop only available in debug mode');
    if (!kDebugMode) return;

    if (state.status == BleTripStatus.riding) {
      state = state.copyWith(
        currentOdometer: state.startOdometer + 3.2,
        distance: 3.2,
        durationSeconds: 300,
        averageSpeed: 32.0,
        maxSpeed: 45.0,
      );
    }
    await _finalizeTrip();
  }
}
