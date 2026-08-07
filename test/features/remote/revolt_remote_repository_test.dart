import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/remote/data/revolt_remote_repository.dart';

void main() {
  group('RevoltRemoteRepository Tests', () {
    test('fetchVehicleState returns VehicleSnapshot tagged with TelemetrySource.cloud', () async {
      final client = MockClient((request) async {
        expect(request.url.path, contains('/api/v1/vehicle/telematics/live'));
        return http.Response(
          jsonEncode({
            'batteryPercent': 85,
            'batteryVoltage': 78.5,
            'batteryCurrent': 12.4,
            'batteryTemp': 32,
            'motorTemp': 40,
            'speed': 45.0,
            'tripDistance': 14.2,
            'odometer': 1250.0,
            'rideMode': 'Normal',
            'range': 90.0,
            'power': 0.97,
            'batteryHealth': 95,
            'gpsCoords': '28.6139,77.2090',
            'faultCodes': [],
            'timestamp': '2026-08-07T12:00:00Z',
          }),
          200,
        );
      });

      final repo = RevoltRemoteRepository(httpClient: client);
      final snapshot = await repo.fetchVehicleState();

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryPercent, 85);
      expect(snapshot.batteryVoltage, 78.5);
      expect(snapshot.speed, 45.0);
      expect(snapshot.rideMode, 'Normal');
      expect(snapshot.source, TelemetrySource.cloud);
      expect(snapshot.source.label, 'Cloud Sync');
    });

    test('fetchVehicleState returns null on HTTP error response', () async {
      final client = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      final repo = RevoltRemoteRepository(httpClient: client);
      final snapshot = await repo.fetchVehicleState();

      expect(snapshot, isNull);
    });

    test('setAuthToken attaches Authorization header to telematics requests', () async {
      late String? authHeader;
      final client = MockClient((request) async {
        authHeader = request.headers['Authorization'];
        return http.Response(jsonEncode({'soc': 90}), 200);
      });

      final repo = RevoltRemoteRepository(httpClient: client);
      repo.setAuthToken('test-secret-token');

      expect(repo.isAuthenticated, isTrue);
      await repo.fetchVehicleState();

      expect(authHeader, 'Bearer test-secret-token');
    });

    test('authenticateWithOtp returns auth token on successful OTP verification', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({'success': true, 'token': 'jwt-auth-token-123'}),
          200,
        );
      });

      final repo = RevoltRemoteRepository(httpClient: client);
      final token = await repo.authenticateWithOtp('9876543210', '123456');

      expect(token, 'jwt-auth-token-123');
      expect(repo.isAuthenticated, isTrue);
    });
  });
}
