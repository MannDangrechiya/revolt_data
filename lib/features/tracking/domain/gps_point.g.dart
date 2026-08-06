// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GpsPoint _$GpsPointFromJson(Map<String, dynamic> json) => _GpsPoint(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  speedKmh: (json['speedKmh'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  accuracy: (json['accuracy'] as num).toDouble(),
);

Map<String, dynamic> _$GpsPointToJson(_GpsPoint instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'speedKmh': instance.speedKmh,
  'timestamp': instance.timestamp.toIso8601String(),
  'accuracy': instance.accuracy,
};
