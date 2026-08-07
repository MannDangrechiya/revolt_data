import 'dart:convert';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_snapshot.freezed.dart';
part 'vehicle_snapshot.g.dart';

/// Immutable model representing real-time telemetry snapshot from the Revolt RV400.
@freezed
abstract class VehicleSnapshot with _$VehicleSnapshot {
  const VehicleSnapshot._();

  const factory VehicleSnapshot({
    int? batteryPercent,
    double? batteryVoltage,
    double? batteryCurrent,
    int? batteryTemp,
    int? motorTemp,
    double? speed,
    double? tripDistance,
    double? odometer,
    String? rideMode,
    double? range,
    double? power,
    @Default([]) List<String> faultCodes,
    int? batteryHealth,
    String? gpsCoords,
    DateTime? timestamp,
  }) = _VehicleSnapshot;

  factory VehicleSnapshot.fromJson(Map<String, dynamic> json) =>
      _$VehicleSnapshotFromJson(json);

  // Safe display helper getters for UI rendering
  String get formattedBatteryPercent =>
      batteryPercent != null ? '$batteryPercent%' : '--%';

  String get formattedVoltage =>
      batteryVoltage != null ? '${batteryVoltage!.toStringAsFixed(1)} V' : '-- V';

  String get formattedCurrent =>
      batteryCurrent != null ? '${batteryCurrent!.toStringAsFixed(1)} A' : '-- A';

  String get formattedBatteryTemp =>
      batteryTemp != null ? '$batteryTemp °C' : '-- °C';

  String get formattedMotorTemp =>
      motorTemp != null ? '$motorTemp °C' : '-- °C';

  String get formattedSpeed =>
      speed != null ? '${speed!.toStringAsFixed(0)} km/h' : '-- km/h';

  String get formattedTripDistance =>
      tripDistance != null ? '${tripDistance!.toStringAsFixed(1)} km' : '-- km';

  String get formattedOdometer =>
      odometer != null ? '${odometer!.toStringAsFixed(1)} km' : '-- km';

  String get formattedRideMode =>
      rideMode != null && rideMode!.isNotEmpty ? rideMode! : '--';

  String get formattedRange =>
      range != null ? '${range!.toStringAsFixed(0)} km' : '-- km';

  String get formattedPower =>
      power != null ? '${power!.toStringAsFixed(2)} kW' : '-- kW';

  String get formattedBatteryHealth =>
      batteryHealth != null ? '$batteryHealth%' : '--%';

  /// Decodes a raw BLE notification packet into a typed [VehicleSnapshot].
  static VehicleSnapshot? parseRawBytes(Uint8List bytes) {
    if (bytes.isEmpty) return null;

    try {
      final rawString = utf8.decode(bytes, allowMalformed: true).trim();
      if (rawString.startsWith('LD,')) {
        return parseLdString(rawString);
      }
    } catch (_) {
      // Fall through to binary parsing
    }

    return _parseBinaryBytes(bytes);
  }

  /// Parses a comma-separated "LD,..." formatted string into [VehicleSnapshot].
  ///
  /// Confirmed field layout from snoop captures:
  ///   [4]  message timestamp "yyyy-MM-dd HH:mm:ss"
  ///   [14] batteryVoltage          — CONFIRMED
  ///   [15] batteryPercent (SOC)    — CONFIRMED
  ///   [16] batteryHealth (SOH)     — CONFIRMED
  ///   [17] batteryTemp (°C)        — CONFIRMED
  ///   [18] rideMode as 1/2/3       — LOW confidence mapping
  ///   [20] speed (km/h)            — parsed if present
  ///   [21] tripDistance (km)       — parsed if present
  ///   [22] faultCodes, ';'-terminated — parsed if present
  ///
  /// UNCONFIRMED INDEX POSITIONS: odometer, motorTemp, power, batteryCurrent, range, gpsCoords
  /// Unconfirmed fields safely evaluate to null.
  static VehicleSnapshot? parseLdString(String rawString) {
    if (!rawString.startsWith('LD,')) return null;

    final parts = rawString.split(',');
    if (parts.length < 20) return null;

    try {
      final batteryVoltage = double.tryParse(parts[14]);
      final batteryPercent = int.tryParse(parts[15]);
      final batteryHealth = int.tryParse(parts[16]);
      final batteryTemp = int.tryParse(parts[17]);
      final rideModeCode = int.tryParse(parts[18]);
      final rideMode = switch (rideModeCode) {
        1 => 'Eco',
        2 => 'Normal',
        3 => 'Sport',
        _ => null,
      };

      double? speed;
      double? tripDistance;
      List<String> faultCodes = [];
      if (parts.length > 20) speed = double.tryParse(parts[20]);
      if (parts.length > 21) tripDistance = double.tryParse(parts[21]);
      if (parts.length > 22) {
        final faultField = parts[22].replaceAll(';', '');
        if (faultField.isNotEmpty &&
            faultField != '0' &&
            faultField.toUpperCase() != 'NONE') {
          faultCodes = [faultField];
        }
      }

      DateTime? timestamp;
      final parsedTimestamp = DateTime.tryParse(parts[4].replaceFirst(' ', 'T'));
      if (parsedTimestamp != null) timestamp = parsedTimestamp;

      return VehicleSnapshot(
        batteryPercent: batteryPercent,
        batteryVoltage: batteryVoltage,
        batteryCurrent: null, // Unconfirmed ASCII field -> null
        batteryTemp: batteryTemp,
        motorTemp: null, // Unconfirmed ASCII field -> null
        speed: speed,
        tripDistance: tripDistance,
        odometer: null, // Unconfirmed ASCII field -> null
        rideMode: rideMode,
        range: null, // Unconfirmed ASCII field -> null
        power: null, // Unconfirmed ASCII field -> null
        faultCodes: faultCodes,
        batteryHealth: batteryHealth,
        timestamp: timestamp ?? DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Binary bytes fallback parser for standard BLE GATT telemetry packets.
  static VehicleSnapshot? _parseBinaryBytes(Uint8List data) {
    if (data.isEmpty) return null;

    int? batteryPercent;
    double? batteryVoltage;
    double? batteryCurrent;
    int? batteryTemp;
    int? motorTemp;
    double? speed;
    double? tripDistance;
    double? odometer;
    String? rideMode;
    double? range;
    double? power;
    List<String> faultCodes = [];
    int? batteryHealth;
    String? gpsCoords;

    if (data.isNotEmpty) {
      batteryPercent = data[0].clamp(0, 100);
    }
    if (data.length >= 3) {
      batteryVoltage = ((data[1] << 8) | data[2]) / 100.0;
    }
    if (data.length >= 5) {
      batteryCurrent = ((data[3] << 8) | data[4]) / 100.0;
    }
    if (data.length >= 6) {
      batteryTemp = data[5];
    }
    if (data.length >= 7) {
      motorTemp = data[6];
    }
    if (data.length >= 9) {
      speed = ((data[7] << 8) | data[8]) / 10.0;
    }
    if (data.length >= 11) {
      tripDistance = ((data[9] << 8) | data[10]) / 10.0;
    }
    if (data.length >= 15) {
      odometer =
          ((data[11] << 24) | (data[12] << 16) | (data[13] << 8) | data[14]) /
              10.0;
    }
    if (data.length >= 16) {
      switch (data[15]) {
        case 1:
          rideMode = 'Eco';
          break;
        case 2:
          rideMode = 'Normal';
          break;
        case 3:
          rideMode = 'Sport';
          break;
        default:
          rideMode = null;
      }
    }
    if (data.length >= 17) {
      batteryHealth = data[16].clamp(0, 100);
    }

    if (batteryPercent != null) {
      range = batteryPercent.toDouble();
    }
    if (batteryVoltage != null && batteryCurrent != null) {
      power = (batteryVoltage * batteryCurrent) / 1000.0;
    }

    return VehicleSnapshot(
      batteryPercent: batteryPercent,
      batteryVoltage: batteryVoltage,
      batteryCurrent: batteryCurrent,
      batteryTemp: batteryTemp,
      motorTemp: motorTemp,
      speed: speed,
      tripDistance: tripDistance,
      odometer: odometer,
      rideMode: rideMode,
      range: range,
      power: power,
      faultCodes: faultCodes,
      batteryHealth: batteryHealth,
      gpsCoords: gpsCoords,
      timestamp: DateTime.now(),
    );
  }
}

