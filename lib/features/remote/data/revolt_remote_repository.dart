import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../ble/domain/vehicle_snapshot.dart';

/// Exception thrown when Revolt Remote Cloud API operations fail.
class RevoltRemoteException implements Exception {
  final String message;
  final int? statusCode;

  const RevoltRemoteException(this.message, {this.statusCode});

  @override
  String toString() => 'RevoltRemoteException: $message (Status: $statusCode)';
}

/// Network repository layer for interacting with Revolt Cloud REST API telematics endpoints.
class RevoltRemoteRepository {
  final String baseUrl;
  final http.Client _httpClient;
  String? _authToken;

  RevoltRemoteRepository({
    String? baseUrl,
    http.Client? httpClient,
    String? authToken,
  })  : baseUrl = baseUrl ?? 'https://api.revoltmotors.com',
        _httpClient = httpClient ?? http.Client(),
        _authToken = authToken;

  /// Returns true if an authentication token is currently set.
  bool get isAuthenticated => _authToken != null && _authToken!.isNotEmpty;

  /// Sets the authentication token for remote API requests.
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Request OTP for mobile number authentication.
  Future<bool> requestOtp(String mobileNumber) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl/api/v1/auth/request-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': mobileNumber}),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('[RevoltRemoteRepository] requestOtp network error: $e');
      return false;
    }
  }

  /// Authenticate user via OTP, returning auth token.
  Future<String?> authenticateWithOtp(String mobileNumber, String otp) async {
    try {
      final response = await _httpClient.post(
        Uri.parse('$baseUrl/api/v1/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': mobileNumber,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final token = body['token'] as String? ?? body['authToken'] as String?;
        if (token != null) {
          _authToken = token;
          return token;
        }
      }
      return null;
    } catch (e) {
      debugPrint('[RevoltRemoteRepository] authenticateWithOtp error: $e');
      return null;
    }
  }

  /// Fetches live telematics vehicle state from Revolt Cloud REST API.
  ///
  /// Returns a [VehicleSnapshot] tagged with [TelemetrySource.cloud].
  Future<VehicleSnapshot?> fetchVehicleState({String? vehicleId}) async {
    try {
      final url = Uri.parse('$baseUrl/api/v1/vehicle/telematics/live${vehicleId != null ? "?vehicle_id=$vehicleId" : ""}');
      final headers = <String, String>{
        'Content-Type': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

      final response = await _httpClient.get(url, headers: headers).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
        final telematicsData = (json['data'] as Map<String, dynamic>?) ?? json;

        final snapshot = VehicleSnapshot(
          batteryPercent: (telematicsData['batteryPercent'] ?? telematicsData['soc'] ?? telematicsData['battery_percent']) as int?,
          batteryVoltage: (telematicsData['batteryVoltage'] ?? telematicsData['voltage'] ?? telematicsData['battery_voltage'])?.toDouble(),
          batteryCurrent: (telematicsData['batteryCurrent'] ?? telematicsData['current'])?.toDouble(),
          batteryTemp: (telematicsData['batteryTemp'] ?? telematicsData['battery_temp']) as int?,
          motorTemp: (telematicsData['motorTemp'] ?? telematicsData['motor_temp']) as int?,
          speed: (telematicsData['speed'])?.toDouble(),
          tripDistance: (telematicsData['tripDistance'] ?? telematicsData['trip'])?.toDouble(),
          odometer: (telematicsData['odometer'] ?? telematicsData['odo'])?.toDouble(),
          rideMode: telematicsData['rideMode'] as String? ?? telematicsData['mode'] as String?,
          range: (telematicsData['range'] ?? telematicsData['est_range'])?.toDouble(),
          power: (telematicsData['power'])?.toDouble(),
          batteryHealth: (telematicsData['batteryHealth'] ?? telematicsData['soh']) as int?,
          gpsCoords: telematicsData['gpsCoords'] as String? ?? telematicsData['location'] as String?,
          faultCodes: telematicsData['faultCodes'] != null
              ? List<String>.from(telematicsData['faultCodes'] as List)
              : const [],
          timestamp: telematicsData['timestamp'] != null
              ? DateTime.tryParse(telematicsData['timestamp'] as String) ?? DateTime.now()
              : DateTime.now(),
          source: TelemetrySource.cloud,
        );

        return snapshot;
      } else {
        debugPrint('[RevoltRemoteRepository] fetchVehicleState HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('[RevoltRemoteRepository] fetchVehicleState failed: $e');
      return null;
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
