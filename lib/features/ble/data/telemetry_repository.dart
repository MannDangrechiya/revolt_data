import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../remote/data/revolt_remote_repository.dart';
import '../domain/connection_state.dart';
import '../domain/vehicle_snapshot.dart';
import 'ble_vehicle_repository.dart';

/// Unified repository that coordinates live BLE snapshots with remote cloud REST API polling.
///
/// Dual-Engine Data Flow:
/// - When BLE connection is active ([BleConnectionState.connected] or [BleConnectionState.authenticated]),
///   telemetry is delivered at high frequency via Bluetooth (`source: TelemetrySource.ble`).
/// - When BLE is disconnected or unavailable, it automatically falls back to polling [RevoltRemoteRepository]
///   every 30 seconds for background cloud updates (`source: TelemetrySource.cloud`).
class TelemetryRepository {
  final BleVehicleRepository bleRepository;
  final RevoltRemoteRepository remoteRepository;

  final _telemetryController = StreamController<VehicleSnapshot>.broadcast();
  StreamSubscription<BleConnectionState>? _bleStateSub;
  StreamSubscription<VehicleSnapshot>? _bleSnapshotSub;
  Timer? _cloudPollTimer;
  VehicleSnapshot? _lastSnapshot;

  TelemetryRepository({
    required this.bleRepository,
    required this.remoteRepository,
  }) {
    _init();
  }

  void _init() {
    _bleStateSub = bleRepository.connectionStateStream.listen(_handleConnectionStateChange);

    _bleSnapshotSub = bleRepository.getVehicleSnapshotStream().listen((snapshot) {
      if (isBleActive(bleRepository.currentConnectionState)) {
        final bleSnapshot = snapshot.copyWith(source: TelemetrySource.ble);
        _lastSnapshot = bleSnapshot;
        if (!_telemetryController.isClosed) {
          _telemetryController.add(bleSnapshot);
        }
      }
    });

    _handleConnectionStateChange(bleRepository.currentConnectionState);
  }

  bool isBleActive(BleConnectionState state) {
    return state == BleConnectionState.connected ||
        state == BleConnectionState.authenticated;
  }

  void _handleConnectionStateChange(BleConnectionState state) {
    if (isBleActive(state)) {
      _stopCloudPolling();
    } else {
      _startCloudPolling();
    }
  }

  void _startCloudPolling() {
    _stopCloudPolling();
    _pollCloud();
    _cloudPollTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _pollCloud();
    });
  }

  void _stopCloudPolling() {
    _cloudPollTimer?.cancel();
    _cloudPollTimer = null;
  }

  Future<void> _pollCloud() async {
    if (isBleActive(bleRepository.currentConnectionState)) return;
    try {
      final snapshot = await remoteRepository.fetchVehicleState();
      if (snapshot != null) {
        final cloudSnapshot = snapshot.copyWith(source: TelemetrySource.cloud);
        _lastSnapshot = cloudSnapshot;
        if (!_telemetryController.isClosed) {
          _telemetryController.add(cloudSnapshot);
        }
      }
    } catch (e) {
      debugPrint('[TelemetryRepository] Cloud poll error: $e');
    }
  }

  /// Stream emitting unified telemetry snapshots from either BLE or Cloud origin.
  Stream<VehicleSnapshot> get telemetryStream => _telemetryController.stream;

  /// Most recent snapshot received from any active telemetry stream.
  VehicleSnapshot? get lastSnapshot => _lastSnapshot;

  void dispose() {
    _stopCloudPolling();
    _bleStateSub?.cancel();
    _bleSnapshotSub?.cancel();
    _telemetryController.close();
  }
}
