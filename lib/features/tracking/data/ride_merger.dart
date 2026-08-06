import 'dart:convert';
import 'dart:math';

import '../domain/gps_point.dart';

class BleTripData {
  final DateTime startTime;
  final DateTime endTime;
  final double startOdometer;
  final double endOdometer;
  final double odometerDelta;
  final double maxSpeed;
  final double averageSpeed;
  final int startBattery;
  final int endBattery;

  const BleTripData({
    required this.startTime,
    required this.endTime,
    required this.startOdometer,
    required this.endOdometer,
    required this.odometerDelta,
    required this.maxSpeed,
    required this.averageSpeed,
    required this.startBattery,
    required this.endBattery,
  });
}

class GpsTrackingData {
  final DateTime startTime;
  final DateTime endTime;
  final double gpsDistance;
  final double maxSpeed;
  final double averageSpeed;
  final List<GpsPoint> route;

  const GpsTrackingData({
    required this.startTime,
    required this.endTime,
    required this.gpsDistance,
    required this.maxSpeed,
    required this.averageSpeed,
    required this.route,
  });
}

class RideMergedResult {
  final DateTime startTime;
  final DateTime endTime;
  final double startOdometer;
  final double endOdometer;
  final double totalDistanceKm;
  final double maxSpeedKmh;
  final double averageSpeedKmh;
  final List<GpsPoint> routePolyline;
  final String source;
  final int batteryBefore;
  final int batteryAfter;

  const RideMergedResult({
    required this.startTime,
    required this.endTime,
    required this.startOdometer,
    required this.endOdometer,
    required this.totalDistanceKm,
    required this.maxSpeedKmh,
    required this.averageSpeedKmh,
    required this.routePolyline,
    required this.source,
    required this.batteryBefore,
    required this.batteryAfter,
  });
}

class RideMerger {
  /// Merges BLE trip data with GPS tracking data when reconnect happens mid-ride
  static RideMergedResult mergeBleAndGps({
    required BleTripData bleData,
    required GpsTrackingData gpsData,
  }) {
    final effectiveStartTime = bleData.startTime.isBefore(gpsData.startTime)
        ? bleData.startTime
        : gpsData.startTime;

    final effectiveEndTime = bleData.endTime.isAfter(gpsData.endTime)
        ? bleData.endTime
        : gpsData.endTime;

    final totalDistance = max(bleData.odometerDelta, gpsData.gpsDistance);
    final maxSpeed = max(bleData.maxSpeed, gpsData.maxSpeed);

    final durationHours =
        effectiveEndTime.difference(effectiveStartTime).inSeconds / 3600.0;
    final calculatedAvgSpeed = durationHours > 0
        ? (totalDistance / durationHours)
        : (bleData.averageSpeed > 0 ? bleData.averageSpeed : gpsData.averageSpeed);

    return RideMergedResult(
      startTime: effectiveStartTime,
      endTime: effectiveEndTime,
      startOdometer: bleData.startOdometer,
      endOdometer: bleData.endOdometer > bleData.startOdometer
          ? bleData.endOdometer
          : (bleData.startOdometer + totalDistance),
      totalDistanceKm: totalDistance,
      maxSpeedKmh: maxSpeed,
      averageSpeedKmh: calculatedAvgSpeed,
      routePolyline: gpsData.route,
      source: 'merged',
      batteryBefore: bleData.startBattery,
      batteryAfter: bleData.endBattery,
    );
  }

  /// Encodes list of GpsPoint into JSON string for storage
  static String encodeRoutePolyline(List<GpsPoint> route) {
    final listMap = route.map((p) => p.toJson()).toList();
    return jsonEncode(listMap);
  }

  /// Decodes JSON string into List of GpsPoint
  static List<GpsPoint> decodeRoutePolyline(String? polylineJson) {
    if (polylineJson == null || polylineJson.isEmpty) return [];
    try {
      final List parsed = jsonDecode(polylineJson);
      return parsed
          .map((e) => GpsPoint.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
