import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../charging/data/charging_provider.dart';
import '../../../charging/domain/charge_log.dart';
import '../../domain/ble_charge_state.dart';
import '../../domain/connection_state.dart';
import '../../domain/vehicle_snapshot.dart';
import 'ble_connection_provider.dart';
import 'vehicle_snapshot_provider.dart';

part 'ble_charge_provider.g.dart';

@Riverpod(keepAlive: true)
class BleChargeNotifier extends _$BleChargeNotifier {
  Timer? _noIncreaseTimer;
  Timer? _tricklePlateauTimer;
  Timer? _disconnectGraceTimer;

  DateTime? _lastTransitionTime;
  int _lastBatteryPercent = 0;

  @override
  BleChargeState build() {
    // Listen to live telemetry updates
    ref.listen<AsyncValue<VehicleSnapshot>>(vehicleSnapshotProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _handleSnapshot(next.value!);
      }
    });

    // Listen to connection state changes for mid-charge disconnection handling
    ref.listen<AsyncValue<BleConnectionState>>(bleConnectionStateProvider, (prev, next) {
      if (next.hasValue && next.value != null) {
        _handleConnectionStateChange(next.value!);
      }
    });

    ref.onDispose(() {
      _noIncreaseTimer?.cancel();
      _tricklePlateauTimer?.cancel();
      _disconnectGraceTimer?.cancel();
    });

    return const BleChargeState();
  }

  void _handleSnapshot(VehicleSnapshot snapshot) {
    final now = DateTime.now();

    // 1. Idle/Completed State -> Start Detection
    if (state.status != BleChargeStatus.charging) {
      if (snapshot.speed == 0 && snapshot.batteryPercent > _lastBatteryPercent && _lastBatteryPercent > 0) {
        // Debounce state transitions by 10 seconds
        if (_lastTransitionTime != null &&
            now.difference(_lastTransitionTime!) < const Duration(seconds: 10)) {
          _lastBatteryPercent = snapshot.batteryPercent;
          return;
        }

        _startChargeSession(snapshot, now);
      } else {
        _lastBatteryPercent = snapshot.batteryPercent;
      }
      return;
    }

    // 2. Active Charging Session Tracking
    final batteryGained = (snapshot.batteryPercent - state.startBattery).clamp(0, 100);
    final kwhAdded = AppConstants.defaultBatteryCapacityKwh * (batteryGained / 100.0);
    final peakTemp = snapshot.batteryTemp > state.peakBatteryTemp ? snapshot.batteryTemp : state.peakBatteryTemp;
    final peakPower = snapshot.power > state.peakPowerKw ? snapshot.power : state.peakPowerKw;
    final durationSeconds = state.startTime != null ? now.difference(state.startTime!).inSeconds : 0;

    state = state.copyWith(
      currentBattery: snapshot.batteryPercent,
      batteryGained: batteryGained,
      kwhAdded: kwhAdded,
      durationSeconds: durationSeconds,
      peakBatteryTemp: peakTemp,
      peakPowerKw: peakPower,
    );

    // 3. Stop Detection Checks
    if (snapshot.batteryPercent > _lastBatteryPercent) {
      // Battery percentage increased -> reset no-increase timer
      _lastBatteryPercent = snapshot.batteryPercent;
      _noIncreaseTimer?.cancel();
      _noIncreaseTimer = null;
    } else {
      // Battery percentage held steady or dropped -> start 60s no-increase timer
      _noIncreaseTimer ??= Timer(const Duration(seconds: 60), () {
        _finalizeChargeSession();
      });
    }

    // Trickle-charge plateau check: if battery == 100%, start 5-minute plateau timer
    if (snapshot.batteryPercent >= 100) {
      _tricklePlateauTimer ??= Timer(const Duration(minutes: 5), () {
        _finalizeChargeSession();
      });
    } else {
      _tricklePlateauTimer?.cancel();
      _tricklePlateauTimer = null;
    }
  }

  void _startChargeSession(VehicleSnapshot snapshot, DateTime now) {
    _noIncreaseTimer?.cancel();
    _noIncreaseTimer = null;
    _tricklePlateauTimer?.cancel();
    _tricklePlateauTimer = null;
    _disconnectGraceTimer?.cancel();
    _disconnectGraceTimer = null;

    _lastTransitionTime = now;
    _lastBatteryPercent = snapshot.batteryPercent;

    state = BleChargeState(
      status: BleChargeStatus.charging,
      startTime: now,
      startBattery: snapshot.batteryPercent,
      currentBattery: snapshot.batteryPercent,
      batteryGained: 0,
      kwhAdded: 0.0,
      durationSeconds: 0,
      peakBatteryTemp: snapshot.batteryTemp,
      peakPowerKw: snapshot.power,
    );
  }

  void _handleConnectionStateChange(BleConnectionState connectionState) {
    if (state.status != BleChargeStatus.charging) return;

    if (connectionState == BleConnectionState.disconnected ||
        connectionState == BleConnectionState.error) {
      // Start 120s grace timer on disconnection
      _disconnectGraceTimer ??= Timer(const Duration(seconds: 120), () {
        _finalizeChargeSession();
      });
    } else if (connectionState == BleConnectionState.connected ||
        connectionState == BleConnectionState.authenticated) {
      // Reconnected within 120s grace period -> resume session
      _disconnectGraceTimer?.cancel();
      _disconnectGraceTimer = null;
    }
  }

  Future<void> _finalizeChargeSession() async {
    _noIncreaseTimer?.cancel();
    _noIncreaseTimer = null;
    _tricklePlateauTimer?.cancel();
    _tricklePlateauTimer = null;
    _disconnectGraceTimer?.cancel();
    _disconnectGraceTimer = null;

    if (state.status != BleChargeStatus.charging) return;

    final now = DateTime.now();
    _lastTransitionTime = now;

    final batteryGain = state.batteryGained;
    final startTime = state.startTime ?? now;

    // Minimum charge delta: Ignore sessions with < 2% battery gain
    if (batteryGain < 2) {
      state = state.copyWith(
        status: BleChargeStatus.idle,
        endTime: now,
      );
      return;
    }

    // Duplicate Prevention Check:
    // If a ChargeLog with source='ble' exists within +/- 5 minutes of startTime, skip insertion.
    final existingLogs = ref.read(chargingLogsProvider).value ?? [];
    final isDuplicate = existingLogs.any((log) {
      if (log.source != 'ble') return false;
      final diffMinutes = log.date.difference(startTime).inMinutes.abs();
      final batteryMatch = log.startBattery == state.startBattery && log.endBattery == state.currentBattery;
      return diffMinutes <= 5 || batteryMatch;
    });

    ChargeLog? savedLog;

    if (!isDuplicate) {
      final calculatedMins = (state.durationSeconds / 60.0);
      final minRequiredMins = (state.kwhAdded / AppConstants.assumedTypicalChargingRateKw) * 60.0;
      final durationMins = (calculatedMins < minRequiredMins ? minRequiredMins : calculatedMins).clamp(1.0, 1440.0);

      savedLog = ChargeLog(
        id: now.millisecondsSinceEpoch.toString(),
        date: startTime,
        durationMinutes: durationMins,
        kwhAdded: state.kwhAdded,
        cost: 0.0,
        paymentMethod: PaymentMethod.free,
        locationType: LocationType.home,
        startBattery: state.startBattery,
        endBattery: state.currentBattery,
        startTime: startTime,
        endTime: now,
        notes: 'Auto-logged BLE Charge Session on ${startTime.toIso8601String().substring(0, 10)}',
        source: 'ble',
      );

      try {
        await ref.read(chargingLogsProvider.notifier).addChargeLog(savedLog, source: 'ble');
      } catch (_) {
        // If DB validation or insert fails, gracefully proceed
      }
    }

    state = state.copyWith(
      status: BleChargeStatus.completed,
      endTime: now,
      lastSavedChargeLog: savedLog,
    );
  }

  /// Processes a telemetry snapshot directly (useful for stream listeners or test fixtures).
  void processSnapshot(VehicleSnapshot snapshot) {
    _handleSnapshot(snapshot);
  }

  /// Manually force-start a charge session (useful for testing or explicit UI triggers).
  void manualStartCharge(VehicleSnapshot snapshot) {
    _startChargeSession(snapshot, DateTime.now());
  }

  /// Manually force-stop a charge session (useful for testing or explicit UI triggers).
  Future<void> manualStopCharge() async {
    await _finalizeChargeSession();
  }

  /// Force-starts a charge session (Debug mode only).
  void forceStart() {
    assert(kDebugMode, 'forceStart only available in debug mode');
    if (!kDebugMode) return;

    final snapshot = VehicleSnapshot(
      batteryPercent: 40,
      batteryVoltage: 68.0,
      batteryCurrent: 5.0,
      batteryTemp: 28,
      motorTemp: 28,
      speed: 0.0,
      tripDistance: 0.0,
      odometer: 1250.0,
      rideMode: 'Eco',
      range: 40.0,
      power: 0.34,
      timestamp: DateTime.now(),
    );
    _startChargeSession(snapshot, DateTime.now());
  }

  /// Force-stops a charge session (Debug mode only).
  Future<void> forceStop() async {
    assert(kDebugMode, 'forceStop only available in debug mode');
    if (!kDebugMode) return;

    if (state.status == BleChargeStatus.charging) {
      state = state.copyWith(
        currentBattery: state.startBattery + 25,
        batteryGained: 25,
        kwhAdded: AppConstants.defaultBatteryCapacityKwh * 0.25,
        durationSeconds: 1800,
      );
    }
    await _finalizeChargeSession();
  }
}
