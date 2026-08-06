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
  final _rawPacketController = StreamController<RawPacket>.broadcast();

  BleConnectionState _currentState = BleConnectionState.disconnected;
  StreamSubscription<RawPacket>? _packetSubscription;
  VehicleSnapshot? _lastSnapshot;

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
  Stream<RawPacket> get rawPacketStream => _rawPacketController.stream;

  @override
  VehicleSnapshot? get lastCachedSnapshot => _lastSnapshot;

  @override
  Future<void> clearSnapshotCache() async {
    _lastSnapshot = null;
  }

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
        final advName = r.advertisementData.advName;
        final platformName = r.device.platformName;
        final rawName = advName.isNotEmpty ? advName : platformName;

        // Check if advertised service UUIDs match Revolt RV400 GATT Service (49535343-fe7d-4ae5-8fa9-9fafd205e455)
        final hasRevoltUuid = r.advertisementData.serviceUuids.any((u) {
          final str = u.str.toLowerCase();
          return str.contains('49535343') || str.contains('fe7d') || str.contains('issc');
        });

        final upperName = rawName.toUpperCase();
        final isRevoltBike = hasRevoltUuid ||
            upperName.contains('REVOLT') ||
            upperName.contains('RV400') ||
            upperName.contains('RV-400') ||
            upperName.contains('RV_400');

        final displayName = rawName.isNotEmpty
            ? rawName
            : (isRevoltBike ? 'Revolt RV400' : 'Unknown BLE Device');

        return BleDeviceInfo(
          id: r.device.remoteId.str,
          name: displayName,
          rssi: r.rssi,
          isRevoltBike: isRevoltBike,
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
      if (!_rawPacketController.isClosed) {
        _rawPacketController.add(packet);
      }
      if (packet.direction == PacketDirection.notify) {
        final snapshot = VehicleSnapshot.parseRawBytes(packet.value);
        if (snapshot != null) {
          _lastSnapshot = snapshot;
          if (!_snapshotController.isClosed) {
            _snapshotController.add(snapshot);
          }
        }
      }
    }, onError: (Object err) {
      debugPrint('Error reading BLE telemetry stream: $err');
    });
  }

  @override
  Stream<VehicleSnapshot> getVehicleSnapshotStream() =>
      _snapshotController.stream;

  void dispose() {
    _packetSubscription?.cancel();
    _connectionStateController.close();
    _snapshotController.close();
    _rawPacketController.close();
  }
}
