// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missed_ride_candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissedRideCandidate _$MissedRideCandidateFromJson(Map<String, dynamic> json) =>
    _MissedRideCandidate(
      id: json['id'] as String,
      estimatedStartTime: DateTime.parse(json['estimatedStartTime'] as String),
      estimatedEndTime: DateTime.parse(json['estimatedEndTime'] as String),
      odometerDeltaKm: (json['odometerDeltaKm'] as num).toDouble(),
      gpsDistanceKm: (json['gpsDistanceKm'] as num?)?.toDouble(),
      gpsMaxSpeedKmh: (json['gpsMaxSpeedKmh'] as num?)?.toDouble(),
      gpsRoute: (json['gpsRoute'] as List<dynamic>?)
          ?.map((e) => GpsPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      confidence: json['confidence'] as String,
      dataSource: json['dataSource'] as String,
    );

Map<String, dynamic> _$MissedRideCandidateToJson(
  _MissedRideCandidate instance,
) => <String, dynamic>{
  'id': instance.id,
  'estimatedStartTime': instance.estimatedStartTime.toIso8601String(),
  'estimatedEndTime': instance.estimatedEndTime.toIso8601String(),
  'odometerDeltaKm': instance.odometerDeltaKm,
  'gpsDistanceKm': instance.gpsDistanceKm,
  'gpsMaxSpeedKmh': instance.gpsMaxSpeedKmh,
  'gpsRoute': instance.gpsRoute,
  'confidence': instance.confidence,
  'dataSource': instance.dataSource,
};
