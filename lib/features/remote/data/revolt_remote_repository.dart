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
  String? _configuredVehicleId;
  String? _customTelematicsUrl;
  bool _isDemoModeEnabled = false;

  RevoltRemoteRepository({
    String? baseUrl,
    http.Client? httpClient,
    String? authToken,
    String? configuredVehicleId,
    String? customTelematicsUrl,
    bool isDemoModeEnabled = false,
  })  : baseUrl = baseUrl ?? 'https://api.revoltmotors.com',
        _httpClient = httpClient ?? http.Client(),
        _authToken = authToken,
        _configuredVehicleId = configuredVehicleId,
        _customTelematicsUrl = customTelematicsUrl,
        _isDemoModeEnabled = isDemoModeEnabled;

  /// Returns true if an authentication token is currently set.
  bool get isAuthenticated => _authToken != null && _authToken!.isNotEmpty;

  /// Gets the currently configured vehicle identifier.
  String? get configuredVehicleId => _configuredVehicleId;

  /// Sets the vehicle identifier for zero-login direct queries.
  void setConfiguredVehicleId(String? vehicleId) {
    _configuredVehicleId = vehicleId;
  }

  /// Gets the custom telematics URL, if configured.
  String? get customTelematicsUrl => _customTelematicsUrl;

  /// Sets a custom webhook or REST endpoint for bike telematics.
  void setCustomTelematicsUrl(String? url) {
    _customTelematicsUrl = url;
  }

  /// Whether demo/simulation telematics mode is active.
  bool get isDemoModeEnabled => _isDemoModeEnabled;

  /// Enables or disables simulation telematics for testing without physical bike.
  void setDemoMode(bool enabled) {
    _isDemoModeEnabled = enabled;
  }

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

  /// Fetches live telematics vehicle state from Revolt Cloud REST API or custom webhook.
  ///
  /// Returns a [VehicleSnapshot] tagged with [TelemetrySource.cloud].
  Future<VehicleSnapshot?> fetchVehicleState({String? vehicleId}) async {
    final targetVehicleId = vehicleId ?? _configuredVehicleId;

    if (_isDemoModeEnabled) {
      return _generateDemoSnapshot(targetVehicleId);
    }

    try {
      final endpoint = _customTelematicsUrl ??
          '$baseUrl/api/v1/vehicle/telematics/live${targetVehicleId != null ? "?vehicle_id=$targetVehicleId" : ""}';
      final url = Uri.parse(endpoint);
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

  /// Generates a realistic simulated Revolt RV400 telematics snapshot for demo testing.
  VehicleSnapshot _generateDemoSnapshot(String? vehicleId) {
    return VehicleSnapshot(
      batteryPercent: 88,
      batteryVoltage: 72.4,
      batteryCurrent: 0.0,
      batteryTemp: 32,
      motorTemp: 38,
      speed: 0.0,
      tripDistance: 14.2,
      odometer: 1420.5,
      rideMode: 'Normal',
      range: 75.0,
      power: 0.0,
      batteryHealth: 97,
      gpsCoords: '18.5204,73.8567',
      faultCodes: const [],
      timestamp: DateTime.now(),
      source: TelemetrySource.cloud,
    );
  }

  void dispose() {
    _httpClient.close();
  }
}
