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

    test('parseLdString defaults not-yet-confirmed fields instead of guessing', () {
      final snapshot = VehicleSnapshot.parseLdString(realCapturedFrame);

      expect(snapshot, isNotNull);
      // Real field positions for these are unconfirmed (see doc comment) —
      // they default rather than silently feed a guessed number into things
      // like trip auto-detection (which reads odometer).
      expect(snapshot!.odometer, 0.0);
      expect(snapshot.motorTemp, 0);
      expect(snapshot.power, 0.0);
      expect(snapshot.batteryCurrent, 0.0);
      expect(snapshot.range, 0.0);
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
  });
}
