import 'dart:async';
import 'dart:typed_data';

import '../../domain/ev_protocol_adapter.dart';
import '../../domain/vehicle_snapshot.dart';

/// EV Protocol Adapter for standard Bluetooth SIG GATT profile vehicles (e.g. Ather 450X, TVS iQube).
/// Reads standard Battery Service (0x180F, Char 0x2A19) and supports navigation cue forwarding.
class StandardGattAdapter implements EvProtocolAdapter {
  final StreamController<VehicleSnapshot> _telemetryController =
      StreamController<VehicleSnapshot>.broadcast();
  bool _isConnected = false;
  VehicleSnapshot? _lastSnapshot;
  final List<String> _sentNavIntents = [];

  StandardGattAdapter();

  @override
  String get vehicleBrand => 'Ather / TVS';

  @override
  String get protocolName => 'Bluetooth SIG Standard GATT (0x180F)';

  @override
  Stream<VehicleSnapshot> get telemetryStream => _telemetryController.stream;

  List<String> get sentNavIntents => List.unmodifiable(_sentNavIntents);

  @override
  Future<void> sendCommand(String command) async {
    final clean = command.trim();
    if (clean.startsWith('NAV:')) {
      // Forward Turn-by-Turn navigation cue to vehicle dashboard cluster
      _sentNavIntents.add(clean);
      return;
    }

    if (clean == 'READ_BATTERY' || clean == 'PING') {
      // Query command handled by GATT read
      return;
    }

    // Pass through other standard dashboard commands
    _sentNavIntents.add(clean);
  }

  @override
  Future<bool> connect(String deviceId) async {
    _isConnected = true;
    return true;
  }

  @override
  Future<void> disconnect() async {
    _isConnected = false;
  }

  bool get isConnected => _isConnected;

  /// Ingests a standard 1-byte Bluetooth SIG 0x2A19 Battery Level notification (0 - 100%).
  VehicleSnapshot ingestBatteryLevel(int batteryPercent) {
    final clampedPercent = batteryPercent.clamp(0, 100);
    final snapshot = (_lastSnapshot ?? const VehicleSnapshot()).copyWith(
      batteryPercent: clampedPercent,
      source: TelemetrySource.ble,
      timestamp: DateTime.now(),
    );
    _lastSnapshot = snapshot;
    if (!_telemetryController.isClosed) {
      _telemetryController.add(snapshot);
    }
    return snapshot;
  }

  /// Ingests a structured standard GATT telemetry payload:
  /// - Byte 0: Battery Level (0 - 100%)
  /// - Byte 1-2: Battery Pack Voltage (uint16 LE, in 0.1 V increments, e.g. 512 = 51.2V)
  /// - Byte 3-4: Pack Current (int16 LE, in 0.1 A increments, signed)
  /// - Byte 5: Pack Temperature (int8 signed, °C)
  /// - Byte 6-7: Speed (uint16 LE, in 0.1 km/h increments, e.g. 450 = 45.0 km/h)
  VehicleSnapshot? ingestGattPayload(Uint8List bytes) {
    if (bytes.isEmpty) return null;

    final byteData = ByteData.sublistView(bytes);
    final soc = bytes[0].clamp(0, 100);
    double? voltage;
    double? current;
    int? temp;
    double? speed;

    if (bytes.length >= 3) {
      voltage = byteData.getUint16(1, Endian.little) / 10.0;
    }
    if (bytes.length >= 5) {
      current = byteData.getInt16(3, Endian.little) / 10.0;
    }
    if (bytes.length >= 6) {
      temp = byteData.getInt8(5);
    }
    if (bytes.length >= 8) {
      speed = byteData.getUint16(6, Endian.little) / 10.0;
    }

    double? power;
    if (voltage != null && current != null) {
      power = (voltage * current.abs()) / 1000.0;
    }

    final snapshot = VehicleSnapshot(
      batteryPercent: soc,
      batteryVoltage: voltage,
      batteryCurrent: current,
      batteryTemp: temp,
      speed: speed,
      power: power,
      source: TelemetrySource.ble,
      timestamp: DateTime.now(),
    );

    _lastSnapshot = snapshot;
    if (!_telemetryController.isClosed) {
      _telemetryController.add(snapshot);
    }
    return snapshot;
  }

  void dispose() {
    _telemetryController.close();
  }
}
