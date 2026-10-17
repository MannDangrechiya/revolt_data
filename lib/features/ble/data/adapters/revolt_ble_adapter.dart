import 'dart:async';
import 'dart:typed_data';

import '../../domain/ev_protocol_adapter.dart';
import '../../domain/vehicle_snapshot.dart';
import '../ble_vehicle_repository.dart';
import '../revolt_ble_repository.dart';

/// EV Protocol Adapter for Revolt RV400 motorcycles using proprietary ASCII BLE GATT service.
class RevoltBleAdapter implements EvProtocolAdapter {
  final BleVehicleRepository _bleRepo;
  final StreamController<VehicleSnapshot> _telemetryController =
      StreamController<VehicleSnapshot>.broadcast();
  StreamSubscription<VehicleSnapshot>? _repoSub;

  RevoltBleAdapter({BleVehicleRepository? bleRepo})
      : _bleRepo = bleRepo ?? RevoltBleRepository() {
    _initStream();
  }

  void _initStream() {
    _repoSub = _bleRepo.getVehicleSnapshotStream().listen((snapshot) {
      if (!_telemetryController.isClosed) {
        _telemetryController.add(snapshot);
      }
    });
  }

  @override
  String get vehicleBrand => 'Revolt Motors';

  @override
  String get protocolName => 'Revolt RV400 ASCII BLE';

  @override
  Stream<VehicleSnapshot> get telemetryStream => _telemetryController.stream;

  @override
  Future<void> sendCommand(String command) async {
    // Validate RV400 protocol commands
    final cleanCommand = command.trim().toUpperCase();
    final validCommands = {
      'START#',
      'STOP#',
      'LOCK#',
      'UNLOCK#',
      'FIND#',
      'SOUND0#',
      'SOUND1#',
      'SOUND2#',
      'SOUND3#',
      'LIGHT#',
    };

    if (!validCommands.contains(cleanCommand) && !cleanCommand.endsWith('#')) {
      throw ArgumentError(
        'Invalid Revolt BLE command: "$command". Commands must terminate with #.',
      );
    }

    await _bleRepo.sendCommand(cleanCommand);
  }

  @override
  Future<bool> connect(String deviceId) async {
    try {
      await _bleRepo.connect(deviceId);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await _bleRepo.disconnect();
  }

  /// Manually feeds a raw ASCII string packet (e.g. "LD,...") into the adapter pipeline.
  VehicleSnapshot? ingestAsciiPacket(String packet) {
    final snapshot = VehicleSnapshot.parseLdString(packet.trim());
    if (snapshot != null && !_telemetryController.isClosed) {
      _telemetryController.add(snapshot);
    }
    return snapshot;
  }

  /// Manually feeds raw bytes into the adapter pipeline.
  VehicleSnapshot? ingestBytes(Uint8List bytes) {
    final snapshot = VehicleSnapshot.parseRawBytes(bytes);
    if (snapshot != null && !_telemetryController.isClosed) {
      _telemetryController.add(snapshot);
    }
    return snapshot;
  }

  void dispose() {
    _repoSub?.cancel();
    _telemetryController.close();
  }
}
