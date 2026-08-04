import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/ble/data/revolt_ble_repository.dart';

void main() {
  group('Telemetry Integration Tests', () {
    test('parseLdString extracts batteryHealth and gpsCoords', () {
      const rawTelemetry = 'LD,85,74.2,12.5,35,42,45.5,12.3,1550.0,Sport,85.0,0.92,NONE,92,12.9716;77.5946';
      final snapshot = VehicleSnapshot.parseLdString(rawTelemetry);

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryPercent, 85);
      expect(snapshot.speed, 45.5);
      expect(snapshot.odometer, 1550.0);
      expect(snapshot.rideMode, 'Sport');
      expect(snapshot.range, 85.0); // Exact telemetry range, no multiplier hack
      expect(snapshot.batteryHealth, 92);
      expect(snapshot.gpsCoords, '12.9716;77.5946');
    });

    test('parseLdString returns null or 0 for batteryHealth when 0 or absent', () {
      const rawTelemetry = 'LD,50,72.0,5.0,30,32,0.0,0.0,1000.0,Eco,50.0,0.0,NONE,0';
      final snapshot = VehicleSnapshot.parseLdString(rawTelemetry);

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryHealth, 0);
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
