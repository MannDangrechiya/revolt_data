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
  /// Supports the real RV400 "LD,..." comma-separated ASCII format, and a
  /// structured binary fallback. The field layout below was reverse-engineered
  /// from an HCI snoop capture of a real bike (see parseLdString for the
  /// confidence level of each field) — it is NOT the previously-assumed
  /// "LD,batteryPercent,batteryVoltage,..." layout, which was never verified
  /// against real hardware and produced nonsensical values (e.g. 302V,
  /// battery% in the trillions) once tested against a real capture.
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
  /// Real field layout, reverse-engineered from HCI snoop captures of an
  /// actual RV400 and cross-checked against a real "My Bike" diagnostics
  /// screenshot (80.0V / 82% SOC / 88% SOH / 37°C) taken minutes before one
  /// capture — this caught [14]/[15]/[16] being mis-mapped in an earlier pass
  /// (battery% and battery health were swapped for what looked at the time
  /// like current and range):
  ///
  ///   [0]  "LD" literal
  ///   [1]  device IMEI (15 digits) — not vehicle telemetry
  ///   [2]  firmware/model code — not vehicle telemetry
  ///   [3]  batch/serial code — not vehicle telemetry
  ///   [4]  message timestamp "yyyy-MM-dd HH:mm:ss" (bike's own clock)
  ///   [5]  single-letter flag, meaning unconfirmed
  ///   [6][7] unused/empty in every captured frame
  ///   [8]  unconfirmed — a slowly-incrementing counter, NOT battery% (that
  ///        theory is now disproven: it changed while [15]/SOC held steady)
  ///   [9]-[13] unconfirmed — always 0/0/1/0/0 in every captured frame
  ///   [14] batteryVoltage          — CONFIRMED against real diagnostics screen
  ///   [15] batteryPercent (SOC)    — CONFIRMED against real diagnostics screen
  ///   [16] batteryHealth (SOH)     — CONFIRMED against real diagnostics screen
  ///   [17] batteryTemp (°C)        — CONFIRMED (36 vs screenshot's 37, ~30min apart)
  ///   [18] rideMode as 1/2/3       — LOW confidence again: showed "3" while the
  ///        official app displayed "ECO" (~30min apart, mode may have changed,
  ///        or this numeric scheme just isn't Eco/Normal/Sport in that order)
  ///   [19] unconfirmed
  ///   [20] speed (km/h)            — untested: every capture so far was a
  ///        parked/idle bike, this field never left 0
  ///   [21] tripDistance (km)       — untested, same reason
  ///   [22] faultCodes, ';'-terminated — MEDIUM-HIGH confidence ("0" = none)
  ///
  /// NOT YET LOCATED: odometer, motorTemp, power, batteryCurrent, range,
  /// gpsCoords — no capture so far shows the bike actually moving, so nothing
  /// distinguishes these from the unconfirmed slots above. Default to 0/null
  /// rather than a guessed field — a wrong odometer would silently corrupt
  /// permanent ride records. Needs a capture taken while riding.
  static VehicleSnapshot? parseLdString(String rawString) {
    if (!rawString.startsWith('LD,')) return null;

    final parts = rawString.split(',');
    if (parts.length < 20) return null;

    try {
      final batteryVoltage = double.tryParse(parts[14]) ?? 0.0;
      final batteryPercent = int.tryParse(parts[15]) ?? 0;
      final batteryHealth = int.tryParse(parts[16]);
      final batteryTemp = int.tryParse(parts[17]) ?? 0;
      final rideModeCode = int.tryParse(parts[18]);
      final rideMode = switch (rideModeCode) {
        1 => 'Eco',
        2 => 'Normal',
        3 => 'Sport',
        _ => 'Eco',
      };

      double speed = 0.0;
      double tripDistance = 0.0;
      List<String> faultCodes = [];
      if (parts.length > 20) speed = double.tryParse(parts[20]) ?? 0.0;
      if (parts.length > 21) tripDistance = double.tryParse(parts[21]) ?? 0.0;
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
        // batteryCurrent field position not yet confirmed — see doc comment.
        batteryCurrent: 0.0,
        batteryTemp: batteryTemp,
        // motorTemp field position not yet confirmed — see doc comment.
        motorTemp: 0,
        speed: speed,
        tripDistance: tripDistance,
        // odometer field position not yet confirmed — see doc comment.
        odometer: 0.0,
        rideMode: rideMode,
        // range field position not yet confirmed — see doc comment.
        range: 0.0,
        // power field position not yet confirmed — see doc comment.
        power: 0.0,
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
