import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/service_center.dart';

/// Repository for retrieving and caching official Revolt authorized dealerships and service centers.
class ServiceCenterRepository {
  static const String serviceCentersUrl =
      'https://dmsi.revoltmotors.com/api/v1/common/getservicecenter';
  static const String cacheKey = 'revolt_service_centers_cache';

  final http.Client _client;
  final SharedPreferences? _prefs;

  ServiceCenterRepository({http.Client? client, SharedPreferences? prefs})
      : _client = client ?? http.Client(),
        _prefs = prefs;

  /// Fetches the list of official Revolt service centers and hubs.
  /// Automatically caches to [SharedPreferences] and falls back to cache offline.
  Future<List<ServiceCenter>> getServiceCenters({bool forceRefresh = false}) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedJson = prefs.getString(cacheKey);
      if (cachedJson != null && cachedJson.isNotEmpty) {
        try {
          return _parseServiceCenters(cachedJson);
        } catch (_) {}
      }
    }

    try {
      final response = await _client.get(
        Uri.parse(serviceCentersUrl),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = response.body;
        final centers = _parseServiceCenters(body);
        if (centers.isNotEmpty) {
          await prefs.setString(cacheKey, body);
        }
        return centers;
      }
    } catch (_) {
      // Ignore network errors and fall back to cache below
    }

    // Fallback to offline cache on non-200 or network error
    final cachedJson = prefs.getString(cacheKey);
    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        return _parseServiceCenters(cachedJson);
      } catch (_) {}
    }

    return const [];
  }

  /// Returns service centers sorted by proximity to [userLat], [userLon],
  /// optionally filtered within [maxDistanceKm].
  Future<List<ServiceCenter>> getNearestServiceCenters(
    double userLat,
    double userLon, {
    double? maxDistanceKm,
  }) async {
    final centers = await getServiceCenters();
    final withDistances = centers.map((center) {
      final dist = center.distanceTo(userLat, userLon);
      return center.copyWithDistance(dist);
    }).toList();

    withDistances.sort((a, b) => (a.distanceKm ?? 0).compareTo(b.distanceKm ?? 0));

    if (maxDistanceKm != null) {
      return withDistances
          .where((c) => (c.distanceKm ?? 0) <= maxDistanceKm)
          .toList();
    }
    return withDistances;
  }

  /// Searches service centers by name, area, address or pincode.
  Future<List<ServiceCenter>> searchServiceCenters(String query) async {
    if (query.trim().isEmpty) return getServiceCenters();
    final q = query.trim().toLowerCase();
    final centers = await getServiceCenters();
    return centers.where((c) {
      return c.hubName.toLowerCase().contains(q) ||
          c.dealerArea.toLowerCase().contains(q) ||
          c.dealerAddress.toLowerCase().contains(q) ||
          c.dealerPincode.contains(q);
    }).toList();
  }

  List<ServiceCenter> _parseServiceCenters(String jsonString) {
    final dynamic decoded = json.decode(jsonString);
    final List<dynamic> list;
    if (decoded is Map<String, dynamic>) {
      list = (decoded['data'] ?? decoded['service_centers'] ?? decoded['hubs'] ?? []) as List<dynamic>;
    } else if (decoded is List) {
      list = decoded;
    } else {
      return const [];
    }

    return list
        .map((item) => ServiceCenter.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
