import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ble/domain/vehicle_snapshot.dart';
import '../domain/sync_state.dart';

part 'sync_state_service.g.dart';

class SyncStateService {
  static const String _kLastSyncedOdometerKey = 'sync_last_synced_odometer';
  static const String _kLastSyncedAtKey = 'sync_last_synced_at';
  static const String _kLastKnownBatteryPercentKey = 'sync_last_known_battery_percent';
  static const String _kLastSnapshotKey = 'sync_last_snapshot_json';
  static const String _kCalibratedOdometerKey = 'sync_calibrated_odometer_baseline';

  static const double kDefaultCalibratedOdometer = 19920.0;

  final SharedPreferences _prefs;

  SyncStateService(this._prefs);

  /// Retrieves the calibrated odometer baseline (defaults to 19,920.0 km if unset).
  double getCalibratedOdometer() {
    return _prefs.getDouble(_kCalibratedOdometerKey) ??
        _prefs.getDouble(_kLastSyncedOdometerKey) ??
        kDefaultCalibratedOdometer;
  }

  /// Sets and persists a new calibrated odometer baseline.
  Future<void> setCalibratedOdometer(double odo) async {
    await _prefs.setDouble(_kCalibratedOdometerKey, odo);
    final currentLast = _prefs.getDouble(_kLastSyncedOdometerKey) ?? 0.0;
    if (currentLast < odo) {
      await _prefs.setDouble(_kLastSyncedOdometerKey, odo);
    }
  }

  /// Saves the current sync state persistently with current ISO DateTime string.
  Future<void> saveSyncState({
    double? odometer,
    int? batteryPercent,
  }) async {
    final now = DateTime.now();
    if (odometer != null) await _prefs.setDouble(_kLastSyncedOdometerKey, odometer);
    await _prefs.setString(_kLastSyncedAtKey, now.toIso8601String());
    if (batteryPercent != null) await _prefs.setInt(_kLastKnownBatteryPercentKey, batteryPercent);
  }

  /// Retrieves the last saved sync state, or `null` if none exists or data is incomplete.
  Future<SyncState?> getLastSyncState() async {
    final odo = _prefs.getDouble(_kLastSyncedOdometerKey);
    final timeStr = _prefs.getString(_kLastSyncedAtKey);
    final battery = _prefs.getInt(_kLastKnownBatteryPercentKey);

    if (odo == null || timeStr == null || battery == null) {
      return null;
    }

    final timestamp = DateTime.tryParse(timeStr);
    if (timestamp == null) {
      return null;
    }

    return SyncState(
      lastSyncedOdometer: odo,
      lastSyncedAt: timestamp,
      lastKnownBatteryPercent: battery,
    );
  }

  /// Returns whether this is the first connection of today (or if no prior state exists).
  Future<bool> isFirstConnectToday() async {
    final state = await getLastSyncState();
    if (state == null) {
      return true;
    }
    return state.isFirstConnectOfDay;
  }

  /// Clears all saved sync state data from SharedPreferences.
  Future<void> clearSyncState() async {
    await _prefs.remove(_kLastSyncedOdometerKey);
    await _prefs.remove(_kLastSyncedAtKey);
    await _prefs.remove(_kLastKnownBatteryPercentKey);
    await _prefs.remove(_kLastSnapshotKey);
    await _prefs.remove(_kCalibratedOdometerKey);
  }

  /// Persists the full last-known telemetry snapshot so it survives app
  /// restarts — the app can then show "last synced at X" from disk instead
  /// of going blank until the next BLE connection.
  Future<void> saveLastSnapshot(VehicleSnapshot snapshot) async {
    await _prefs.setString(_kLastSnapshotKey, jsonEncode(snapshot.toJson()));
  }

  VehicleSnapshot? getLastSnapshot() {
    final raw = _prefs.getString(_kLastSnapshotKey);
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return VehicleSnapshot.fromJson(json);
    } catch (_) {
      return null;
    }
  }
}

@riverpod
Future<SyncStateService> syncStateService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return SyncStateService(prefs);
}
