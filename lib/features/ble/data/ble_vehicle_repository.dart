import '../domain/ble_device_info.dart';
import '../domain/connection_state.dart';
import '../domain/vehicle_snapshot.dart';

/// Abstract repository interface for Revolt RV400 BLE operations.
abstract class BleVehicleRepository {
  /// Stream of current connection lifecycle states.
  Stream<BleConnectionState> get connectionStateStream;

  /// Current connection state snapshot.
  BleConnectionState get currentConnectionState;

  /// Scans for nearby RV400 BLE devices.
  Future<List<BleDeviceInfo>> scan({Duration timeout = const Duration(seconds: 10)});

  /// Connects to a target BLE device by [deviceId].
  Future<void> connect(String deviceId);

  /// Performs PAIR authentication with [token].
  Future<bool> pair(String token);

  /// Disconnects from the current device and cancels reconnect attempts.
  Future<void> disconnect();

  /// Returns a stream of real-time vehicle telemetry snapshots.
  Stream<VehicleSnapshot> getVehicleSnapshotStream();
}
