// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ride _$RideFromJson(Map<String, dynamic> json) => _Ride(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  startOdometer: (json['startOdometer'] as num).toDouble(),
  endOdometer: (json['endOdometer'] as num).toDouble(),
  batteryBefore: (json['batteryBefore'] as num).toInt(),
  batteryAfter: (json['batteryAfter'] as num).toInt(),
  rideMode: $enumDecode(_$RideModeEnumMap, json['rideMode']),
  roadCondition: $enumDecode(_$RoadConditionEnumMap, json['roadCondition']),
  notes: json['notes'] as String?,
  photoPaths:
      (json['photoPaths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  estimatedRemainingRange: (json['estimatedRemainingRange'] as num?)
      ?.toDouble(),
  averageSpeed: (json['averageSpeed'] as num?)?.toDouble(),
  maxSpeed: (json['maxSpeed'] as num?)?.toDouble(),
  weather: json['weather'] as String?,
  roadType: json['roadType'] as String?,
  passengerCount: (json['passengerCount'] as num?)?.toInt(),
  ridePurpose: json['ridePurpose'] as String?,
  startLocation: json['startLocation'] as String?,
  endLocation: json['endLocation'] as String?,
  routeNotes: json['routeNotes'] as String?,
  customTags:
      (json['customTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isFavorite: json['isFavorite'] as bool? ?? false,
  bikeId: (json['bikeId'] as num?)?.toInt(),
  source: json['source'] as String? ?? 'manual',
  routePolyline: json['routePolyline'] as String?,
);

Map<String, dynamic> _$RideToJson(_Ride instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'startOdometer': instance.startOdometer,
  'endOdometer': instance.endOdometer,
  'batteryBefore': instance.batteryBefore,
  'batteryAfter': instance.batteryAfter,
  'rideMode': _$RideModeEnumMap[instance.rideMode]!,
  'roadCondition': _$RoadConditionEnumMap[instance.roadCondition]!,
  'notes': instance.notes,
  'photoPaths': instance.photoPaths,
  'startTime': instance.startTime?.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'estimatedRemainingRange': instance.estimatedRemainingRange,
  'averageSpeed': instance.averageSpeed,
  'maxSpeed': instance.maxSpeed,
  'weather': instance.weather,
  'roadType': instance.roadType,
  'passengerCount': instance.passengerCount,
  'ridePurpose': instance.ridePurpose,
  'startLocation': instance.startLocation,
  'endLocation': instance.endLocation,
  'routeNotes': instance.routeNotes,
  'customTags': instance.customTags,
  'isFavorite': instance.isFavorite,
  'bikeId': instance.bikeId,
  'source': instance.source,
  'routePolyline': instance.routePolyline,
};

const _$RideModeEnumMap = {
  RideMode.eco: 'eco',
  RideMode.normal: 'normal',
  RideMode.sport: 'sport',
};

const _$RoadConditionEnumMap = {
  RoadCondition.smooth: 'smooth',
  RoadCondition.average: 'average',
  RoadCondition.bad: 'bad',
};
