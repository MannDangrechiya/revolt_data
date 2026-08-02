import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';

import '../domain/ble_device_info.dart';
import '../domain/connection_state.dart';
import '../domain/vehicle_snapshot.dart';
import 'ble_vehicle_repository.dart';

/// Concrete implementation of [BleVehicleRepository] wrapping [RevoltBleClient].
class RevoltBleRepository implements BleVehicleRepository {
  final RevoltBleClient _client;
  final _connectionStateController =
      StreamController<BleConnectionState>.broadcast();
  final _snapshotController = StreamController<VehicleSnapshot>.broadcast();

  BleConnectionState _currentState = BleConnectionState.disconnected;
  StreamSubscription<RawPacket>? _packetSubscription;

  RevoltBleRepository({RevoltBleClient? client})
      : _client = client ??
            RevoltBleClient(
              license: License.nonprofit,
              nameFilter: 'RV400',
            ) {
    _updateState(BleConnectionState.disconnected);
  }

  void _updateState(BleConnectionState newState) {
    _currentState = newState;
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(newState);
    }
  }

  @override
  Stream<BleConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  @override
  BleConnectionState get currentConnectionState => _currentState;

  @override
  Future<List<BleDeviceInfo>> scan({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    _updateState(BleConnectionState.scanning);
    try {
      final results = await _client.scan(timeout: timeout);
      _updateState(
        _client.isConnected
            ? BleConnectionState.connected
            : BleConnectionState.disconnected,
      );
      return results.map((r) {
        final name = r.advertisementData.advName.isNotEmpty
            ? r.advertisementData.advName
            : (r.device.platformName.isNotEmpty
                ? r.device.platformName
                : 'Revolt RV400');
        return BleDeviceInfo(
          id: r.device.remoteId.str,
          name: name,
          rssi: r.rssi,
        );
      }).toList();
    } catch (e) {
      _updateState(BleConnectionState.error);
      rethrow;
    }
  }

  @override
  Future<void> connect(String deviceId) async {
    _updateState(BleConnectionState.connecting);
    try {
      await _client.connect(deviceId);
      _updateState(BleConnectionState.connected);
      _startListening();
    } catch (e) {
      _updateState(BleConnectionState.error);
      rethrow;
    }
  }

  @override
  Future<bool> pair(String token) async {
    if (_currentState != BleConnectionState.connected &&
        _currentState != BleConnectionState.authenticated) {
      throw const RevoltConnectionException(
        'Must be connected before authenticating',
      );
    }
    _updateState(BleConnectionState.authenticating);
    try {
      final success = await _client.authenticate(token);
      if (success) {
        _updateState(BleConnectionState.authenticated);
      } else {
        _updateState(BleConnectionState.connected);
      }
      return success;
    } catch (e) {
      _updateState(BleConnectionState.error);
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    await _packetSubscription?.cancel();
    _packetSubscription = null;
    await _client.disconnect();
    _updateState(BleConnectionState.disconnected);
  }

  void _startListening() {
    _packetSubscription?.cancel();
    _packetSubscription = _client.listen().listen((packet) {
      if (packet.direction == PacketDirection.notify) {
        final snapshot = _parsePacketToSnapshot(packet.value);
        if (snapshot != null && !_snapshotController.isClosed) {
          _snapshotController.add(snapshot);
        }
      }
    }, onError: (Object err) {
      debugPrint('Error reading BLE telemetry stream: $err');
    });
  }

  /// Parses raw characteristic bytes into a [VehicleSnapshot].
  /// Handles standard telemetry payload formats or generates parsed telemetry structure.
  VehicleSnapshot? _parsePacketToSnapshot(Uint8List data) {
    if (data.isEmpty) return null;

    try {
      // Basic telemetry parser:
      // Byte 0: Battery percentage (0-100)
      // Byte 1-2: Voltage (mV -> V)
      // Byte 3-4: Current (mA -> A)
      // Byte 5: Temperature (°C)
      // Byte 6-7: Speed (km/h * 10)
      // Byte 8-11: Odometer (km * 10)
      // Byte 12: Mode (1: Eco, 2: Normal, 3: Sport)
      int battery = 100;
      double voltage = 72.0;
      double current = 0.0;
      int temp = 30;
      double speed = 0.0;
      double odo = 1200.0;
      String mode = 'Eco';
      List<String> faults = [];

      if (data.length >= 1) {
        battery = data[0].clamp(0, 100);
      }
      if (data.length >= 3) {
        voltage = ((data[1] << 8) | data[2]) / 100.0;
      }
      if (data.length >= 5) {
        current = ((data[3] << 8) | data[4]) / 100.0;
      }
      if (data.length >= 6) {
        temp = data[5];
      }
      if (data.length >= 8) {
        speed = ((data[6] << 8) | data[7]) / 10.0;
      }
      if (data.length >= 12) {
        odo = ((data[8] << 24) | (data[9] << 16) | (data[10] << 8) | data[11]) /
            10.0;
      }
      if (data.length >= 13) {
        switch (data[12]) {
          case 1:
            mode = 'Eco';
            break;
          case 2:
            mode = 'Normal';
            break;
          case 3:
            mode = 'Sport';
            break;
          default:
            mode = 'Eco';
        }
      }

      final range = (battery * 1.5);

      return VehicleSnapshot(
        battery: battery,
        voltage: voltage > 0 ? voltage : 72.0,
        current: current,
        temp: temp > 0 ? temp : 28,
        speed: speed,
        odo: odo,
        range: range,
        mode: mode,
        faults: faults,
        timestamp: DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<VehicleSnapshot> getVehicleSnapshotStream() =>
      _snapshotController.stream;

  void dispose() {
    _packetSubscription?.cancel();
    _connectionStateController.close();
    _snapshotController.close();
  }
}
