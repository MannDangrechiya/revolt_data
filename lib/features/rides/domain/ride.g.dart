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
      photoPaths: (json['photoPaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
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
