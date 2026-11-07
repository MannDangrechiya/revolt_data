import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revolt_data/features/charging/data/service_center_repository.dart';
import 'package:revolt_data/features/charging/domain/service_center.dart';

void main() {
  group('ServiceCenter Model Tests', () {
    test('fromJson parses official DMS service center format correctly', () {
      final json = {
        'hub_id': 12,
        'hub_name': 'Revolt Hub Naraina',
        'dealer_address': 'A-12, Naraina Industrial Area Phase 1',
        'dealer_number': '+91-9876543210',
        'dealer_area': 'Naraina',
        'dealer_pincode': '110028',
        'dealer_link': 'https://maps.google.com/?q=28.6289,77.1384',
        'latitude': '28.6289',
        'longitude': '77.1384',
        'office_time': '10:00 AM - 07:00 PM',
        'city_id': 1,
        'status': 1,
      };

      final center = ServiceCenter.fromJson(json);

      expect(center.hubId, 12);
      expect(center.hubName, 'Revolt Hub Naraina');
      expect(center.dealerAddress, 'A-12, Naraina Industrial Area Phase 1');
      expect(center.dealerNumber, '+91-9876543210');
      expect(center.dealerPincode, '110028');
      expect(center.latitude, 28.6289);
      expect(center.longitude, 77.1384);
      expect(center.officeTime, '10:00 AM - 07:00 PM');
      expect(center.cityId, 1);
      expect(center.status, 1);
    });

    test('distanceTo calculates geodesic proximity accurately', () {
      final center = const ServiceCenter(
        hubId: 1,
        hubName: 'Delhi Hub',
        dealerAddress: 'Connaught Place',
        dealerNumber: '011-12345678',
        dealerArea: 'CP',
        dealerPincode: '110001',
        latitude: 28.6315,
        longitude: 77.2167,
        officeTime: '10 AM - 7 PM',
        cityId: 1,
        status: 1,
      );

      // Distance from India Gate (28.6129, 77.2295) to CP (~2.4 km)
      final dist = center.distanceTo(28.6129, 77.2295);
      expect(dist, greaterThan(2.0));
      expect(dist, lessThan(3.0));
    });
  });

  group('ServiceCenterRepository Tests', () {
    final mockResponseData = {
      'status': true,
      'data': [
        {
          'hub_id': 101,
          'hub_name': 'Revolt Hub Guindy',
          'dealer_address': 'Guindy Industrial Estate',
          'dealer_number': '+91-9988776655',
          'dealer_area': 'Guindy',
          'dealer_pincode': '600032',
          'latitude': '13.0067',
          'longitude': '80.2024',
          'office_time': '09:30 AM - 06:30 PM',
          'city_id': 4,
          'status': 1,
        },
        {
          'hub_id': 102,
          'hub_name': 'Revolt Hub Anna Nagar',
          'dealer_address': '2nd Avenue, Anna Nagar',
          'dealer_number': '+91-9988776656',
          'dealer_area': 'Anna Nagar',
          'dealer_pincode': '600040',
          'latitude': '13.0850',
          'longitude': '80.2101',
          'office_time': '10:00 AM - 07:00 PM',
          'city_id': 4,
          'status': 1,
        }
      ]
    };

    test('getServiceCenters fetches successfully and caches to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final client = MockClient((request) async {
        expect(request.url.toString(), ServiceCenterRepository.serviceCentersUrl);
        return http.Response(jsonEncode(mockResponseData), 200);
      });

      final repo = ServiceCenterRepository(client: client, prefs: prefs);
      final centers = await repo.getServiceCenters();

      expect(centers.length, 2);
      expect(centers.first.hubName, 'Revolt Hub Guindy');
      expect(prefs.getString(ServiceCenterRepository.cacheKey), isNotNull);
    });

    test('getServiceCenters falls back to offline cache when server returns 503', () async {
      SharedPreferences.setMockInitialValues({
        ServiceCenterRepository.cacheKey: jsonEncode(mockResponseData),
      });
      final prefs = await SharedPreferences.getInstance();

      final client = MockClient((request) async {
        return http.Response('Service Unavailable', 503);
      });

      final repo = ServiceCenterRepository(client: client, prefs: prefs);
      final centers = await repo.getServiceCenters(forceRefresh: true);

      expect(centers.length, 2);
      expect(centers[1].hubName, 'Revolt Hub Anna Nagar');
    });

    test('getNearestServiceCenters sorts centers by proximity to coordinate', () async {
      SharedPreferences.setMockInitialValues({
        ServiceCenterRepository.cacheKey: jsonEncode(mockResponseData),
      });
      final prefs = await SharedPreferences.getInstance();
      final repo = ServiceCenterRepository(client: http.Client(), prefs: prefs);

      // User near Guindy (13.0070, 80.2020)
      final nearest = await repo.getNearestServiceCenters(13.0070, 80.2020);

      expect(nearest.first.hubName, 'Revolt Hub Guindy');
      expect(nearest.first.distanceKm, lessThan(1.0));
      expect(nearest[1].hubName, 'Revolt Hub Anna Nagar');
      expect(nearest[1].distanceKm, greaterThan(nearest.first.distanceKm!));
    });

    test('searchServiceCenters filters by name, area, or pincode', () async {
      SharedPreferences.setMockInitialValues({
        ServiceCenterRepository.cacheKey: jsonEncode(mockResponseData),
      });
      final prefs = await SharedPreferences.getInstance();
      final repo = ServiceCenterRepository(client: http.Client(), prefs: prefs);

      final searchArea = await repo.searchServiceCenters('Anna Nagar');
      expect(searchArea.length, 1);
      expect(searchArea.first.hubId, 102);

      final searchPin = await repo.searchServiceCenters('600032');
      expect(searchPin.length, 1);
      expect(searchPin.first.hubId, 101);
    });
  });
}
