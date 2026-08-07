import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:revolt_data/features/ble/data/revolt_ble_repository.dart';
import 'package:revolt_data/features/ble/data/telemetry_repository.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/remote/data/revolt_remote_repository.dart';

void main() {
  group('TelemetryRepository Hybrid Stream Tests', () {
    test('TelemetrySource labels and colors format correctly', () {
      expect(TelemetrySource.ble.label, 'Live BLE');
      expect(TelemetrySource.cloud.label, 'Cloud Sync');
      expect(TelemetrySource.cached.label, 'Offline / Cached');
    });

    test('TelemetryRepository falls back to remote cloud when BLE is disconnected', () async {
      final bleRepo = RevoltBleRepository();

      final mockHttpClient = MockClient((request) async {
        return http.Response(
          '{"batteryPercent": 75, "batteryVoltage": 72.0, "speed": 0}',
          200,
        );
      });
      final remoteRepo = RevoltRemoteRepository(httpClient: mockHttpClient);

      final telemetryRepo = TelemetryRepository(
        bleRepository: bleRepo,
        remoteRepository: remoteRepo,
      );

      final snapshot = await telemetryRepo.telemetryStream.first;
      expect(snapshot, isNotNull);
      expect(snapshot.batteryPercent, 75);
      expect(snapshot.source, TelemetrySource.cloud);

      telemetryRepo.dispose();
      bleRepo.dispose();
      remoteRepo.dispose();
    });
  });
}
