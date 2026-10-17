import 'dart:async';
import 'dart:typed_data';

import '../../domain/ev_protocol_adapter.dart';
import '../../domain/vehicle_snapshot.dart';

/// EV Protocol Adapter for Smart BMS units (Daly, JK, JBD BMS) over BLE UART (0xFFE0).
/// Decodes cell millivolt voltages, pack current, balancing state, and thermal sensors.
class SmartBmsAdapter implements EvProtocolAdapter {
  final StreamController<VehicleSnapshot> _telemetryController =
      StreamController<VehicleSnapshot>.broadcast();

  bool _isConnected = false;
  VehicleSnapshot? _lastSnapshot;

  // BMS Internal Diagnostics
  final List<int> _cellVoltagesMv = [];
  bool _isBalancingActive = false;
  bool _isChargeMosEnabled = true;
  bool _isDischargeMosEnabled = true;
  final List<String> _sentBmsCommands = [];

  SmartBmsAdapter();

  @override
  String get vehicleBrand => 'Daly / JK / JBD Smart BMS';

  @override
  String get protocolName => 'Smart BMS UART over BLE (0xFFE0)';

  @override
  Stream<VehicleSnapshot> get telemetryStream => _telemetryController.stream;

  List<int> get cellVoltagesMv => List.unmodifiable(_cellVoltagesMv);
  bool get isBalancingActive => _isBalancingActive;
  bool get isChargeMosEnabled => _isChargeMosEnabled;
  bool get isDischargeMosEnabled => _isDischargeMosEnabled;
  List<String> get sentBmsCommands => List.unmodifiable(_sentBmsCommands);

  @override
  Future<void> sendCommand(String command) async {
    final clean = command.trim().toUpperCase();
    _sentBmsCommands.add(clean);

    switch (clean) {
      case 'BALANCE_ON':
        _isBalancingActive = true;
        break;
      case 'BALANCE_OFF':
        _isBalancingActive = false;
        break;
      case 'MOS_CHARGE_ON':
        _isChargeMosEnabled = true;
        break;
      case 'MOS_CHARGE_OFF':
        _isChargeMosEnabled = false;
        break;
      case 'MOS_DISCHARGE_ON':
        _isDischargeMosEnabled = true;
        break;
      case 'MOS_DISCHARGE_OFF':
        _isDischargeMosEnabled = false;
        break;
      default:
        // Pass through custom hex or AT commands
        break;
    }
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

  /// Parses a Daly/JK BMS UART frame:
  /// [0xA5, HostAddr(0x01), CommandID(0x90..0x98), Length(0x08), Data0..Data7, Checksum]
  VehicleSnapshot? ingestDalyFrame(Uint8List frame) {
    if (frame.length < 12) return null;
    if (frame[0] != 0xA5) return null;

    final cmd = frame[2];
    final byteData = ByteData.sublistView(frame);

    switch (cmd) {
      case 0x90: // SOC, Total Voltage, Real Current
        final totalVoltage = byteData.getUint16(4, Endian.big) / 10.0; // 0.1 V
        final rawCurrent = byteData.getUint16(8, Endian.big); // 0.1 A with 30000 offset
        final current = (rawCurrent - 30000) / 10.0;
        final socTenths = byteData.getUint16(10, Endian.big);
        final soc = (socTenths / 10.0).round().clamp(0, 100);

        final power = (totalVoltage * current.abs()) / 1000.0;

        final updated = (_lastSnapshot ?? const VehicleSnapshot()).copyWith(
          batteryPercent: soc,
          batteryVoltage: totalVoltage,
          batteryCurrent: current,
          power: power,
          source: TelemetrySource.ble,
          timestamp: DateTime.now(),
        );
        _lastSnapshot = updated;
        if (!_telemetryController.isClosed) {
          _telemetryController.add(updated);
        }
        return updated;

      case 0x92: // Pack Temperatures
        final temp1 = frame[4] - 40; // 40 degree offset
        final updated = (_lastSnapshot ?? const VehicleSnapshot()).copyWith(
          batteryTemp: temp1,
          source: TelemetrySource.ble,
          timestamp: DateTime.now(),
        );
        _lastSnapshot = updated;
        if (!_telemetryController.isClosed) {
          _telemetryController.add(updated);
        }
        return updated;

      case 0x93: // MOS and Active Balancing Status
        final mosState = frame[4];
        _isChargeMosEnabled = (mosState & 0x01) != 0;
        _isDischargeMosEnabled = (mosState & 0x02) != 0;
        final balanceState = frame[5];
        _isBalancingActive = balanceState != 0;
        return _lastSnapshot;

      case 0x95: // Cell Millivolt Voltages (3 cells per frame chunk)
        final frameSeq = frame[4];
        final cellA = byteData.getUint16(5, Endian.big);
        final cellB = byteData.getUint16(7, Endian.big);
        final cellC = byteData.getUint16(9, Endian.big);

        final startIndex = (frameSeq - 1) * 3;
        while (_cellVoltagesMv.length < startIndex + 3) {
          _cellVoltagesMv.add(0);
        }
        if (cellA > 0) _cellVoltagesMv[startIndex] = cellA;
        if (cellB > 0 && startIndex + 1 < _cellVoltagesMv.length) {
          _cellVoltagesMv[startIndex + 1] = cellB;
        }
        if (cellC > 0 && startIndex + 2 < _cellVoltagesMv.length) {
          _cellVoltagesMv[startIndex + 2] = cellC;
        }
        return _lastSnapshot;

      default:
        return _lastSnapshot;
    }
  }

  void dispose() {
    _telemetryController.close();
  }
}
