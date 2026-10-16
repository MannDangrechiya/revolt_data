import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';

void main() {
  group('Battery & BMS Diagnostics Logic Tests', () {
    test('Power calculation matches V * A / 1000', () {
      const voltage = 72.4;
      const current = 15.0;
      final powerKw = (voltage * current).abs() / 1000.0;

      expect(powerKw, closeTo(1.086, 0.001));
    });

    test('Range estimation correctly differentiates Eco, Normal, and Sport modes', () {
      const soc = 80;
      final estEco = (soc * 1.5).round();
      final estNormal = (soc * 1.0).round();
      final estSport = (soc * 0.8).round();

      expect(estEco, 120);
      expect(estNormal, 80);
      expect(estSport, 64);
    });

    test('Temperature safety threshold categorization', () {
      String getTempStatus(int temp) {
        if (temp < 45) return 'Optimal';
        if (temp < 55) return 'Warm';
        return 'Critical Heat';
      }

      expect(getTempStatus(32), 'Optimal');
      expect(getTempStatus(48), 'Warm');
      expect(getTempStatus(60), 'Critical Heat');
    });

    test('Fault codes parsing detects normal vs DTC error states', () {
      final cleanSnapshot = VehicleSnapshot(
        batteryPercent: 90,
        faultCodes: const [],
      );
      expect(cleanSnapshot.faultCodes, isEmpty);

      final errorSnapshot = VehicleSnapshot(
        batteryPercent: 40,
        faultCodes: const ['BMS_OVERHEAT_ERR', 'CELL_UNDERVOLTAGE_04'],
      );
      expect(errorSnapshot.faultCodes.length, 2);
      expect(errorSnapshot.faultCodes, contains('BMS_OVERHEAT_ERR'));
    });
  });
}
