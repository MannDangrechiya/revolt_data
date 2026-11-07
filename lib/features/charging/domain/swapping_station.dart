/// Represents a Revolt Switch battery swapping station retrieved from the
/// public Revolt S3 station registry.
class SwappingStation {
  final String stationId;
  final String stationName;
  final String city;
  final double latitude;
  final double longitude;
  final String address;
  final String timing;

  const SwappingStation({
    required this.stationId,
    required this.stationName,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.timing,
  });

  factory SwappingStation.fromJson(Map<String, dynamic> json) {
    return SwappingStation(
      stationId: json['station_id']?.toString() ?? '',
      stationName: json['station_name']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      latitude: (json['latitude'] is num)
          ? (json['latitude'] as num).toDouble()
          : double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      longitude: (json['longitude'] is num)
          ? (json['longitude'] as num).toDouble()
          : double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,
      address: json['address']?.toString() ?? '',
      timing: json['timing']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'station_id': stationId,
        'station_name': stationName,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'timing': timing,
      };
}
