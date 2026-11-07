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
          (baseUrl.contains('apix.revoltmotors.com')
              ? '$baseUrl/api/v1/ecu/dataByEcuNo?ecu_no=${targetVehicleId ?? ""}'
              : '$baseUrl/api/v1/vehicle/telematics/live${targetVehicleId != null ? "?vehicle_id=$targetVehicleId" : ""}');
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
        final Map<String, dynamic> telematicsData;
        if (json['bikes'] is List && (json['bikes'] as List).isNotEmpty) {
          telematicsData = (json['bikes'] as List).first as Map<String, dynamic>;
        } else {
          telematicsData = (json['data'] as Map<String, dynamic>?) ?? json;
        }

        int? parseNumToInt(dynamic v) {
          if (v == null) return null;
          if (v is int) return v;
          if (v is num) return v.toInt();
          return int.tryParse(v.toString());
        }

        double? parseNumToDouble(dynamic v) {
          if (v == null) return null;
          if (v is double) return v;
          if (v is num) return v.toDouble();
          return double.tryParse(v.toString());
        }

        final batteryPercent = parseNumToInt(
          telematicsData['batteryPercent'] ??
              telematicsData['batteryPercentage'] ??
              telematicsData['soc'] ??
              telematicsData['battery_percent'],
        );

        final batteryVoltage = parseNumToDouble(
          telematicsData['batteryVoltage'] ??
              telematicsData['voltage'] ??
              telematicsData['battery_voltage'],
        );

        final batteryCurrent = parseNumToDouble(
          telematicsData['batteryCurrent'] ?? telematicsData['current'],
        );

        final batteryTemp = parseNumToInt(
          telematicsData['batteryTemp'] ?? telematicsData['battery_temp'],
        );

        final motorTemp = parseNumToInt(
          telematicsData['motorTemp'] ?? telematicsData['motor_temp'],
        );

        final speed = parseNumToDouble(telematicsData['speed']);

        final tripDistance = parseNumToDouble(
          telematicsData['tripDistance'] ??
              telematicsData['tripAValueKm'] ??
              telematicsData['trip'],
        );

        final odometer = parseNumToDouble(
          telematicsData['odometer'] ??
              telematicsData['odometerValueKm'] ??
              telematicsData['odo'],
        );

        final rawMode = telematicsData['rideMode'] ??
            telematicsData['currentMode'] ??
            telematicsData['mode'];
        final String? rideMode = switch (rawMode?.toString()) {
          '1' => 'Eco',
          '2' => 'Normal',
          '3' => 'Sport',
          '4' => 'Reverse',
          _ => rawMode?.toString(),
        };

        final range = parseNumToDouble(
          telematicsData['range'] ??
              telematicsData['estimateKms'] ??
              telematicsData['remainingMileage'] ??
              telematicsData['est_range'],
        );

        final power = parseNumToDouble(telematicsData['power']);

        final batteryHealth = parseNumToInt(
          telematicsData['batteryHealth'] ?? telematicsData['soh'],
        );

        String? gpsCoords;
        if (telematicsData['bikeLatitude'] != null &&
            telematicsData['bikeLongitude'] != null) {
          final lat = telematicsData['bikeLatitude'].toString().trim();
          final lon = telematicsData['bikeLongitude'].toString().trim();
          if (lat.isNotEmpty && lon.isNotEmpty) {
            gpsCoords = '$lat,$lon';
          }
        } else {
          gpsCoords = (telematicsData['gpsCoords'] ?? telematicsData['location'])
              ?.toString();
        }

        DateTime? timestamp;
        final rawTs = telematicsData['timestamp'] ?? telematicsData['syncTime'];
        if (rawTs != null) {
          timestamp = DateTime.tryParse(rawTs.toString().replaceFirst(' ', 'T'));
        }

        final snapshot = VehicleSnapshot(
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
          batteryHealth: batteryHealth,
          gpsCoords: gpsCoords,
          faultCodes: telematicsData['faultCodes'] != null
              ? List<String>.from(telematicsData['faultCodes'] as List)
              : const [],
          timestamp: timestamp ?? DateTime.now(),
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
