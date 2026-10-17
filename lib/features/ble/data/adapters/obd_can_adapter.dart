import 'dart:async';

import '../../domain/ev_protocol_adapter.dart';
import '../../domain/vehicle_snapshot.dart';

/// EV Protocol Adapter for ELM327 Bluetooth CAN diagnostic adapters (ISO 15765-4 / SAE J1979).
/// Decodes standard EV powertrain parameters: motor RPM, speed, inverter temperature, and throttle position.
class ObdCanAdapter implements EvProtocolAdapter {
  final StreamController<VehicleSnapshot> _telemetryController =
      StreamController<VehicleSnapshot>.broadcast();

  bool _isConnected = false;
  VehicleSnapshot? _lastSnapshot;
  int? _motorRpm;
  double? _throttlePercent;
  final List<String> _sentObdCommands = [];

  ObdCanAdapter();

  @override
  String get vehicleBrand => 'Universal OBD-II / CAN EV';

  @override
  String get protocolName => 'ELM327 Bluetooth CAN (ISO 15765-4)';

  @override
  Stream<VehicleSnapshot> get telemetryStream => _telemetryController.stream;

  int? get motorRpm => _motorRpm;
  double? get throttlePercent => _throttlePercent;
  List<String> get sentObdCommands => List.unmodifiable(_sentObdCommands);

  @override
  Future<void> sendCommand(String command) async {
    final clean = command.trim().toUpperCase().replaceAll(' ', '');
    _sentObdCommands.add(clean);

    if (clean == '04') {
      // Clear Trouble Codes
      _lastSnapshot = _lastSnapshot?.copyWith(faultCodes: const []);
      if (_lastSnapshot != null && !_telemetryController.isClosed) {
        _telemetryController.add(_lastSnapshot!);
      }
    }
  }

  @override
  Future<bool> connect(String deviceId) async {
    _isConnected = true;
    // Initial ELM327 handshake
    await sendCommand('ATZ'); // Reset
    await sendCommand('ATE0'); // Echo off
    await sendCommand('ATSP0'); // Automatic protocol search
    return true;
  }

  @override
  Future<void> disconnect() async {
    _isConnected = false;
  }

  bool get isConnected => _isConnected;

  /// Ingests an OBD-II response string or multi-line frame.
  /// Examples:
  /// - Speed: "41 0D 3C" -> 60 km/h
  /// - RPM: "41 0C 1A F8" -> 1726 RPM
  /// - Inverter Temp: "41 5C 5A" -> 50 °C
  /// - Battery SOC: "41 5B C8" -> 78%
  /// - Throttle: "41 11 7F" -> 49.8%
  /// - DTC: "43 01 03 0A 1F" -> Fault "P0A1F"
  VehicleSnapshot? ingestObdResponse(String response) {
    final lines = response.split(RegExp(r'[\r\n]+'));
    VehicleSnapshot snapshot = _lastSnapshot ?? const VehicleSnapshot();

    for (final line in lines) {
      final clean = line.replaceAll(' ', '').trim().toUpperCase();
      if (clean.isEmpty || clean.startsWith('AT') || clean == 'OK' || clean.contains('NODATA')) {
        continue;
      }

      // Check standard Mode 01 Responses ("41 XX ...")
      if (clean.startsWith('41')) {
        if (clean.length < 4) continue;
        final pid = clean.substring(2, 4);
        final dataHex = clean.substring(4);

        switch (pid) {
          case '0C': // Motor RPM: ((A * 256) + B) / 4
            if (dataHex.length >= 4) {
              final a = int.tryParse(dataHex.substring(0, 2), radix: 16) ?? 0;
              final b = int.tryParse(dataHex.substring(2, 4), radix: 16) ?? 0;
              _motorRpm = ((a * 256) + b) ~/ 4;
            }
            break;

          case '0D': // Speed: A km/h
            if (dataHex.length >= 2) {
              final speedKmH = (int.tryParse(dataHex.substring(0, 2), radix: 16) ?? 0).toDouble();
              snapshot = snapshot.copyWith(speed: speedKmH);
            }
            break;

          case '11': // Throttle Position: A * 100 / 255
            if (dataHex.length >= 2) {
              final val = int.tryParse(dataHex.substring(0, 2), radix: 16) ?? 0;
              _throttlePercent = (val * 100.0) / 255.0;
            }
            break;

          case '5C': // Inverter / Motor Coolant Temp: A - 40 (°C)
            if (dataHex.length >= 2) {
              final val = int.tryParse(dataHex.substring(0, 2), radix: 16) ?? 40;
              snapshot = snapshot.copyWith(motorTemp: val - 40);
            }
            break;

          case '5B': // Hybrid/EV Battery Remaining SOC: A * 100 / 255 (%)
            if (dataHex.length >= 2) {
              final val = int.tryParse(dataHex.substring(0, 2), radix: 16) ?? 0;
              final soc = ((val * 100.0) / 255.0).round().clamp(0, 100);
              snapshot = snapshot.copyWith(batteryPercent: soc);
            }
            break;
        }
      } else if (clean.startsWith('43')) {
        // Mode 03 DTC response: e.g. "43 01 0A 1F" -> "P0A1F"
        final faultHex = clean.substring(2);
        if (faultHex.length >= 4) {
          final dtc = 'P${faultHex.substring(faultHex.length - 4)}';
          final existing = List<String>.from(snapshot.faultCodes);
          if (!existing.contains(dtc)) {
            existing.add(dtc);
            snapshot = snapshot.copyWith(faultCodes: existing);
          }
        }
      }
    }

    // Estimate instantaneous power if speed & throttle are available
    if (snapshot.speed != null && _throttlePercent != null) {
      final estimatedPower = ((snapshot.speed! * _throttlePercent!) / 1000.0).clamp(0.0, 5.0);
      snapshot = snapshot.copyWith(power: double.parse(estimatedPower.toStringAsFixed(2)));
    }

    snapshot = snapshot.copyWith(
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
