import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/ble/data/revolt_ble_repository.dart';

void main() {
  group('Telemetry Integration Tests', () {
    // Real frame captured via HCI snoop log from an actual RV400, taken
    // minutes before a "My Bike" diagnostics screenshot showing 80.0V / 82%
    // SOC / 88% SOH / 37°C — that ground truth is what pins these 4 fields
    // down with real confidence (and caught a swap in an earlier pass: SOC
    // and SOH had been mis-mapped as current and range). See
    // vehicle_snapshot.dart's parseLdString doc comment for the full
    // field-by-field confidence breakdown.
    const realCapturedFrame =
        'LD,864218069498106,0302,2023111301379,2026-08-06 23:24:28,N,,,20,0,1,0,0,0,80,82,88,36,3,10,0,0,0;';

    test('parseLdString extracts the confidently-mapped fields from a real capture', () {
      final snapshot = VehicleSnapshot.parseLdString(realCapturedFrame);

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryVoltage, 80.0); // matches diagnostics screen exactly
      expect(snapshot.batteryPercent, 82); // matches diagnostics screen's SOC exactly
      expect(snapshot.batteryHealth, 88); // matches diagnostics screen's SOH exactly
      expect(snapshot.batteryTemp, 36); // diagnostics screen showed 37°C ~30min earlier
      expect(snapshot.speed, 0.0); // bike was parked in this capture
      expect(snapshot.tripDistance, 0.0);
      expect(snapshot.faultCodes, isEmpty);
      expect(snapshot.timestamp, DateTime.parse('2026-08-06T23:24:28'));
    });

    test('parseLdString defaults not-yet-confirmed fields to null instead of guessing', () {
      final snapshot = VehicleSnapshot.parseLdString(realCapturedFrame);

      expect(snapshot, isNotNull);
      // Real field positions for these are unconfirmed —
      // they default to null rather than silently feeding a guessed number.
      expect(snapshot!.odometer, isNull);
      expect(snapshot.motorTemp, isNull);
      expect(snapshot.power, isNull);
      expect(snapshot.batteryCurrent, isNull);
      expect(snapshot.range, isNull);
      expect(snapshot.gpsCoords, isNull);
    });

    test('parseLdString maps ride mode codes and returns null for malformed input', () {
      expect(
        VehicleSnapshot.parseLdString(
          'LD,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0',
        )!.rideMode,
        'Eco',
      );
      expect(
        VehicleSnapshot.parseLdString(
          'LD,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0',
        )!.rideMode,
        'Normal',
      );
      // Too few fields to reach the confident indices — reject rather than
      // parse partial/garbage data.
      expect(VehicleSnapshot.parseLdString('LD,1,2,3'), isNull);
    });

    test('RevoltBleRepository caches last valid VehicleSnapshot and clears cache', () async {
      final repository = RevoltBleRepository();
      expect(repository.lastCachedSnapshot, isNull);

      // Verify clearSnapshotCache does not throw when null
      await repository.clearSnapshotCache();
      expect(repository.lastCachedSnapshot, isNull);
    });

    test('parseLdString accurately parses standard 15-field live ride packet', () {
      const livePacket = 'LD,85,52.4,12.5,35,42,28.5,1234.5,Eco,65,0,0,98,18.5204,73.8567';
      final snapshot = VehicleSnapshot.parseLdString(livePacket);

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryPercent, 85);
      expect(snapshot.batteryVoltage, 52.4);
      expect(snapshot.batteryCurrent, 12.5);
      expect(snapshot.batteryTemp, 35);
      expect(snapshot.motorTemp, 42);
      expect(snapshot.speed, 28.5);
      expect(snapshot.odometer, 1234.5);
      expect(snapshot.rideMode, 'Eco');
      expect(snapshot.range, 65.0);
      expect(snapshot.batteryHealth, 98);
      expect(snapshot.gpsCoords, '18.5204,73.8567');
      expect(snapshot.power, closeTo((52.4 * 12.5) / 1000.0, 0.001));
    });

    test('parseLdString accurately parses standard 15-field charging packet', () {
      const chargePacket = 'LD,45,54.2,-8.5,30,32,0.0,1234.7,Eco,35,0,1,98,18.5220,73.8578';
      final snapshot = VehicleSnapshot.parseLdString(chargePacket);

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryPercent, 45);
      expect(snapshot.batteryVoltage, 54.2);
      expect(snapshot.batteryCurrent, -8.5);
      expect(snapshot.batteryTemp, 30);
      expect(snapshot.motorTemp, 32);
      expect(snapshot.speed, 0.0);
      expect(snapshot.odometer, 1234.7);
      expect(snapshot.gpsCoords, '18.522,73.8578');
      expect(snapshot.power, closeTo((54.2 * 8.5) / 1000.0, 0.001));
    });
  });
}
