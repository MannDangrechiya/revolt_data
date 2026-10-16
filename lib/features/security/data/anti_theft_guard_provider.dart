import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/notifications/notification_service.dart';
import '../../ble/domain/connection_state.dart';
import '../../ble/domain/vehicle_snapshot.dart';
import '../../ble/presentation/providers/ble_connection_provider.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';

part 'anti_theft_guard_provider.g.dart';

enum AntiTheftStatus {
  unarmed,
  armed,
  alertTriggered,
}

class AntiTheftState {
  final AntiTheftStatus status;
  final double? parkedLatitude;
  final double? parkedLongitude;
  final DateTime? parkedTime;
  final double? distanceMovedMeters;
  final String? alertMessage;
  final double geofenceRadiusMeters;

  const AntiTheftState({
    this.status = AntiTheftStatus.unarmed,
    this.parkedLatitude,
    this.parkedLongitude,
    this.parkedTime,
    this.distanceMovedMeters,
    this.alertMessage,
    this.geofenceRadiusMeters = 50.0,
  });

  AntiTheftState copyWith({
    AntiTheftStatus? status,
    double? parkedLatitude,
    double? parkedLongitude,
    DateTime? parkedTime,
    double? distanceMovedMeters,
    String? alertMessage,
    double? geofenceRadiusMeters,
  }) {
    return AntiTheftState(
      status: status ?? this.status,
      parkedLatitude: parkedLatitude ?? this.parkedLatitude,
      parkedLongitude: parkedLongitude ?? this.parkedLongitude,
      parkedTime: parkedTime ?? this.parkedTime,
      distanceMovedMeters: distanceMovedMeters ?? this.distanceMovedMeters,
      alertMessage: alertMessage ?? this.alertMessage,
      geofenceRadiusMeters: geofenceRadiusMeters ?? this.geofenceRadiusMeters,
    );
  }
}

@Riverpod(keepAlive: true)
class AntiTheftGuard extends _$AntiTheftGuard {
  @override
  AntiTheftState build() {
    // Listen to BLE connection state transitions
    ref.listen<AsyncValue<BleConnectionState>>(bleConnectionStateProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _handleConnectionChange(next.value!);
      }
    });

    // Listen to telemetry stream snapshots
    ref.listen<AsyncValue<VehicleSnapshot>>(vehicleSnapshotProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _handleTelemetrySnapshot(next.value!);
      }
    });

    return const AntiTheftState();
  }

  void _handleConnectionChange(BleConnectionState connectionState) {
    if (connectionState == BleConnectionState.disconnected ||
        connectionState == BleConnectionState.error) {
      // Auto-arm guard when vehicle is disconnected
      final lastSnapshot = ref.read(lastKnownVehicleSnapshotProvider);
      if (lastSnapshot != null && lastSnapshot.gpsCoords != null) {
        _armWithCoords(lastSnapshot.gpsCoords!);
      } else {
        armGuard();
      }
    } else if (connectionState == BleConnectionState.authenticated ||
        connectionState == BleConnectionState.connected) {
      // Auto-disarm when authenticated owner reconnects via BLE
      disarmGuard();
    }
  }

  void _handleTelemetrySnapshot(VehicleSnapshot snapshot) {
    if (state.status != AntiTheftStatus.armed) return;
    if (snapshot.gpsCoords == null) return;

    final coords = _parseCoords(snapshot.gpsCoords!);
    if (coords == null) return;

    if (state.parkedLatitude == null || state.parkedLongitude == null) {
      _armWithCoords(snapshot.gpsCoords!);
      return;
    }

    final distanceMeters = Geolocator.distanceBetween(
      state.parkedLatitude!,
      state.parkedLongitude!,
      coords.$1,
      coords.$2,
    );

    state = state.copyWith(distanceMovedMeters: distanceMeters);

    // Anti-theft trigger threshold: displacement beyond configured geofence radius
    if (distanceMeters > state.geofenceRadiusMeters) {
      _triggerAntiTheftAlert(distanceMeters, coords.$1, coords.$2);
    }
  }

  void setGeofenceRadius(double radiusMeters) {
    state = state.copyWith(geofenceRadiusMeters: radiusMeters);
  }

  void _armWithCoords(String gpsCoordsStr) {
    final parsed = _parseCoords(gpsCoordsStr);
    if (parsed != null) {
      state = AntiTheftState(
        status: AntiTheftStatus.armed,
        parkedLatitude: parsed.$1,
        parkedLongitude: parsed.$2,
        parkedTime: DateTime.now(),
        distanceMovedMeters: 0.0,
        geofenceRadiusMeters: state.geofenceRadiusMeters,
      );
    }
  }

  void armGuard({double? lat, double? lng}) {
    state = AntiTheftState(
      status: AntiTheftStatus.armed,
      parkedLatitude: lat ?? state.parkedLatitude ?? 28.6139,
      parkedLongitude: lng ?? state.parkedLongitude ?? 77.2090,
      parkedTime: DateTime.now(),
      distanceMovedMeters: 0.0,
      geofenceRadiusMeters: state.geofenceRadiusMeters,
    );
  }

  void disarmGuard() {
    state = AntiTheftState(
      status: AntiTheftStatus.unarmed,
      geofenceRadiusMeters: state.geofenceRadiusMeters,
    );
  }

  void checkPositionAndEvaluate(double currentLat, double currentLng) {
    if (state.status != AntiTheftStatus.armed) return;
    if (state.parkedLatitude == null || state.parkedLongitude == null) return;

    final distanceMeters = Geolocator.distanceBetween(
      state.parkedLatitude!,
      state.parkedLongitude!,
      currentLat,
      currentLng,
    );

    state = state.copyWith(distanceMovedMeters: distanceMeters);

    if (distanceMeters > state.geofenceRadiusMeters) {
      _triggerAntiTheftAlert(distanceMeters, currentLat, currentLng);
    }
  }

  /// Sends a chirp/hazard command ('LOCATE#') to help find the bike in parking areas.
  Future<bool> triggerLocateBike() async {
    final bleRepo = ref.read(bleRepositoryProvider);
    try {
      await bleRepo.sendCommand('LOCATE#');
      return true;
    } catch (e) {
      debugPrint('[AntiTheftGuard] triggerLocateBike error: $e');
      return false;
    }
  }

  /// Sends an emergency engine lock/immobilize command ('LOCK#') to the bike ECU.
  Future<bool> remoteLockEngine() async {
    final bleRepo = ref.read(bleRepositoryProvider);
    try {
      await bleRepo.sendCommand('LOCK#');
      return true;
    } catch (e) {
      debugPrint('[AntiTheftGuard] remoteLockEngine error: $e');
      return false;
    }
  }

  void _triggerAntiTheftAlert(double distanceMeters, double lat, double lng) {
    final alertMsg =
        'CRITICAL ANTI-THEFT ALERT: Bike movement detected! Displaced by ${distanceMeters.toStringAsFixed(0)}m from parked position.';

    state = state.copyWith(
      status: AntiTheftStatus.alertTriggered,
      distanceMovedMeters: distanceMeters,
      alertMessage: alertMsg,
    );

    try {
      final notifier = ref.read(notificationServiceProvider);
      notifier.showImmediateNotification(
        id: 9999,
        title: '🚨 CRITICAL ANTI-THEFT ALERT',
        body: 'Unauthorized movement detected! Vehicle displaced ${distanceMeters.toStringAsFixed(0)}m.',
        payload: 'anti_theft_alert',
      ).catchError((Object err) {
        debugPrint('Failed to send anti-theft notification: $err');
      });
    } catch (e) {
      debugPrint('Failed to send anti-theft notification: $e');
    }
  }

  (double, double)? _parseCoords(String coordsStr) {
    try {
      final parts = coordsStr.split(',');
      if (parts.length >= 2) {
        final lat = double.tryParse(parts[0].trim());
        final lng = double.tryParse(parts[1].trim());
        if (lat != null && lng != null) {
          return (lat, lng);
        }
      }
    } catch (_) {}
    return null;
  }
}
