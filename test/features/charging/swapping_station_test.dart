import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revolt_data/features/charging/data/swapping_station_repository.dart';
import 'package:revolt_data/features/charging/domain/swapping_station.dart';

void main() {
  group('SwappingStation Domain & Repository Tests', () {
    const sampleJson = '''{
      "stations": [
        {
          "station_name": "Patparganj",
          "station_id": "1401",
          "city": "Delhi",
          "latitude": 28.639115,
          "longitude": 77.312897,
          "address": "97, FIE, Patparganj industrial area, Delhi- 110092",
          "timing": "10 AM to 7 PM"
        },
        {
          "station_name": "Dwarka",
          "station_id": "1201",
          "city": "Delhi",
          "latitude": 28.602547,
          "longitude": 77.058288,
          "address": "K1, 6, Main Rajapuri Rd, Dwarka",
          "timing": "10 AM to 7 PM"
        }
      ]
    }''';

    test('SwappingStation.fromJson parses all fields properly', () {
      final jsonMap = json.decode(sampleJson)['stations'][0] as Map<String, dynamic>;
      final station = SwappingStation.fromJson(jsonMap);

      expect(station.stationId, '1401');
      expect(station.stationName, 'Patparganj');
      expect(station.city, 'Delhi');
      expect(station.latitude, 28.639115);
      expect(station.longitude, 77.312897);
      expect(station.address, contains('Patparganj'));
      expect(station.timing, '10 AM to 7 PM');
    });

    test('SwappingStationRepository fetches stations from S3 and caches to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final mockClient = MockClient((request) async {
        expect(request.url.toString(), SwappingStationRepository.stationsUrl);
        return http.Response(sampleJson, 200);
      });

      final repo = SwappingStationRepository(client: mockClient, prefs: prefs);
      final stations = await repo.getStations();

      expect(stations.length, 2);
      expect(stations.first.stationName, 'Patparganj');
      expect(stations.last.stationName, 'Dwarka');

      // Verify cached in prefs
      expect(prefs.getString(SwappingStationRepository.cacheKey), sampleJson);
    });

    test('SwappingStationRepository falls back to offline cache when HTTP fails', () async {
      SharedPreferences.setMockInitialValues({
        SwappingStationRepository.cacheKey: sampleJson,
      });
      final prefs = await SharedPreferences.getInstance();

      final mockClient = MockClient((request) async {
        return http.Response('Service Unavailable', 503);
      });

      final repo = SwappingStationRepository(client: mockClient, prefs: prefs);
      final stations = await repo.getStations(forceRefresh: true);

      expect(stations.length, 2);
      expect(stations.first.stationId, '1401');
    });
  });
}
