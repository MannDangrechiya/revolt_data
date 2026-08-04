import 'dart:convert';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_snapshot.freezed.dart';
part 'vehicle_snapshot.g.dart';

/// Immutable model representing real-time telemetry snapshot from the Revolt RV400.
@freezed
abstract class VehicleSnapshot with _$VehicleSnapshot {
  const factory VehicleSnapshot({
    required int batteryPercent,
    required double batteryVoltage,
    required double batteryCurrent,
    required int batteryTemp,
    required int motorTemp,
    required double speed,
    required double tripDistance,
    required double odometer,
    required String rideMode,
    required double range,
    required double power,
    @Default([]) List<String> faultCodes,
    int? batteryHealth,
    String? gpsCoords,
    DateTime? timestamp,
  }) = _VehicleSnapshot;

  factory VehicleSnapshot.fromJson(Map<String, dynamic> json) =>
      _$VehicleSnapshotFromJson(json);

  /// Decodes a raw BLE notification packet into a typed [VehicleSnapshot].
  ///
  /// Supports comma-separated ASCII string format starting with "LD,"
  /// (e.g., "LD,batteryPercent,batteryVoltage,batteryCurrent,batteryTemp,motorTemp,speed,tripDistance,odometer,rideMode,range,power,faultCodes,batteryHealth,gpsCoords")
  /// as well as structured binary fallbacks.
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
  static VehicleSnapshot? parseLdString(String rawString) {
    if (!rawString.startsWith('LD,')) return null;

    final parts = rawString.split(',');
    if (parts.length < 12) return null;

    try {
      final batteryPercent = int.tryParse(parts[1]) ?? 0;
      final batteryVoltage = double.tryParse(parts[2]) ?? 0.0;
      final batteryCurrent = double.tryParse(parts[3]) ?? 0.0;
      final batteryTemp = int.tryParse(parts[4]) ?? 0;
      final motorTemp = int.tryParse(parts[5]) ?? 0;
      final speed = double.tryParse(parts[6]) ?? 0.0;
      final tripDistance = double.tryParse(parts[7]) ?? 0.0;
      final odometer = double.tryParse(parts[8]) ?? 0.0;
      final rideMode = parts[9].isNotEmpty ? parts[9] : 'Eco';
      final range = double.tryParse(parts[10]) ?? 0.0;
      final power = double.tryParse(parts[11]) ?? 0.0;

      List<String> faultCodes = [];
      if (parts.length > 12 &&
          parts[12].isNotEmpty &&
          parts[12].toUpperCase() != 'NONE') {
        faultCodes = parts[12].split(';').where((f) => f.isNotEmpty).toList();
      }

      int? batteryHealth;
      if (parts.length > 13 && parts[13].isNotEmpty) {
        batteryHealth = int.tryParse(parts[13]);
      }

      String? gpsCoords;
      if (parts.length > 14 && parts[14].isNotEmpty) {
        gpsCoords = parts[14];
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
    } catch (_) {
      return null;
    }
  }

  /// Binary bytes fallback parser for standard BLE GATT telemetry packets.
  static VehicleSnapshot? _parseBinaryBytes(Uint8List data) {
    if (data.isEmpty) return null;

    int batteryPercent = 100;
    double batteryVoltage = 72.0;
    double batteryCurrent = 0.0;
    int batteryTemp = 30;
    int motorTemp = 32;
    double speed = 0.0;
    double tripDistance = 0.0;
    double odometer = 1200.0;
    String rideMode = 'Eco';
    double range = 150.0;
    double power = 0.0;
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
          rideMode = 'Eco';
      }
    }
    if (data.length >= 17) {
      batteryHealth = data[16].clamp(0, 100);
    }

    range = batteryPercent.toDouble();
    power = (batteryVoltage * batteryCurrent) / 1000.0;

    return VehicleSnapshot(
      batteryPercent: batteryPercent,
      batteryVoltage: batteryVoltage > 0 ? batteryVoltage : 72.0,
      batteryCurrent: batteryCurrent,
      batteryTemp: batteryTemp > 0 ? batteryTemp : 28,
      motorTemp: motorTemp > 0 ? motorTemp : 30,
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
