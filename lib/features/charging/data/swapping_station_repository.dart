import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/swapping_station.dart';

/// Repository for retrieving and caching official Revolt Switch battery swapping stations.
class SwappingStationRepository {
  static const String stationsUrl =
      'https://revolt1app1config.s3.ap-south-1.amazonaws.com/station/stations.json';
  static const String cacheKey = 'revolt_swapping_stations_cache';

  final http.Client _client;
  final SharedPreferences? _prefs;

  SwappingStationRepository({http.Client? client, SharedPreferences? prefs})
      : _client = client ?? http.Client(),
        _prefs = prefs;

  /// Fetches the latest Revolt Switch battery swapping stations.
  /// Automatically caches to [SharedPreferences] and falls back to cache offline.
  Future<List<SwappingStation>> getStations({bool forceRefresh = false}) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();

    if (!forceRefresh) {
      final cachedJson = prefs.getString(cacheKey);
      if (cachedJson != null && cachedJson.isNotEmpty) {
        try {
          return _parseStations(cachedJson);
        } catch (_) {}
      }
    }

    try {
      final response = await _client.get(
        Uri.parse(stationsUrl),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = response.body;
        final stations = _parseStations(body);
        if (stations.isNotEmpty) {
          await prefs.setString(cacheKey, body);
        }
        return stations;
      }
    } catch (_) {
      // Ignore network errors and fall back to cache below
    }

    // Fallback to offline cache on non-200 or network error
    final cachedJson = prefs.getString(cacheKey);
    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        return _parseStations(cachedJson);
      } catch (_) {}
    }

    return const [];
  }

  List<SwappingStation> _parseStations(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    final list = data['stations'] as List<dynamic>?;
    if (list == null) return const [];
    return list
        .map((item) => SwappingStation.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
