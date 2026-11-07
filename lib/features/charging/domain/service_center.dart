import 'dart:math' as math;

/// Represents an official Revolt Motors dealership hub and authorized service center
/// retrieved from Revolt DMS (`https://dmsi.revoltmotors.com/api/v1/common/getservicecenter`).
class ServiceCenter {
  final int hubId;
  final String hubName;
  final String dealerAddress;
  final String dealerNumber;
  final String dealerArea;
  final String dealerPincode;
  final String? dealerLink;
  final double latitude;
  final double longitude;
  final String officeTime;
  final int cityId;
  final int status;
  final double? distanceKm;

  const ServiceCenter({
    required this.hubId,
    required this.hubName,
    required this.dealerAddress,
    required this.dealerNumber,
    required this.dealerArea,
    required this.dealerPincode,
    this.dealerLink,
    required this.latitude,
    required this.longitude,
    required this.officeTime,
    required this.cityId,
    required this.status,
    this.distanceKm,
  });

  factory ServiceCenter.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is double) return v;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return ServiceCenter(
      hubId: parseInt(json['hub_id'] ?? json['hubId']),
      hubName: (json['hub_name'] ?? json['hubName'] ?? '').toString(),
      dealerAddress:
          (json['dealer_address'] ?? json['dealerAddress'] ?? '').toString(),
      dealerNumber:
          (json['dealer_number'] ?? json['dealerNumber'] ?? '').toString(),
      dealerArea: (json['dealer_area'] ?? '').toString(),
      dealerPincode:
          (json['dealer_pincode'] ?? json['dealerPincode'] ?? '').toString(),
      dealerLink: json['dealer_link']?.toString(),
      latitude: parseDouble(json['latitude']),
      longitude: parseDouble(json['longitude']),
      officeTime:
          (json['office_time'] ?? json['officeTime'] ?? '').toString(),
      cityId: parseInt(json['city_id'] ?? json['cityId']),
      status: parseInt(json['status']),
      distanceKm: json['distance'] != null ? parseDouble(json['distance']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'hub_id': hubId,
        'hub_name': hubName,
        'dealer_address': dealerAddress,
        'dealer_number': dealerNumber,
        'dealer_area': dealerArea,
        'dealer_pincode': dealerPincode,
        'dealer_link': dealerLink,
        'latitude': latitude,
        'longitude': longitude,
        'office_time': officeTime,
        'city_id': cityId,
        'status': status,
        if (distanceKm != null) 'distance': distanceKm,
      };

  /// Calculates the geodesic distance in kilometers to this service center using the Haversine formula.
  double distanceTo(double targetLat, double targetLon) {
    const double earthRadiusKm = 6371.0;
    final double dLat = _degreesToRadians(targetLat - latitude);
    final double dLon = _degreesToRadians(targetLon - longitude);

    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(latitude)) *
            math.cos(_degreesToRadians(targetLat)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  ServiceCenter copyWithDistance(double distKm) {
    return ServiceCenter(
      hubId: hubId,
      hubName: hubName,
      dealerAddress: dealerAddress,
      dealerNumber: dealerNumber,
      dealerArea: dealerArea,
      dealerPincode: dealerPincode,
      dealerLink: dealerLink,
      latitude: latitude,
      longitude: longitude,
      officeTime: officeTime,
      cityId: cityId,
      status: status,
      distanceKm: distKm,
    );
  }
}
