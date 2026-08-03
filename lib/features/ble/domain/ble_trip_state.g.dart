// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_trip_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BleTripState _$BleTripStateFromJson(Map<String, dynamic> json) =>
    _BleTripState(
      status:
          $enumDecodeNullable(_$BleTripStatusEnumMap, json['status']) ??
          BleTripStatus.idle,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      startOdometer: (json['startOdometer'] as num?)?.toDouble() ?? 0.0,
      currentOdometer: (json['currentOdometer'] as num?)?.toDouble() ?? 0.0,
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      currentSpeed: (json['currentSpeed'] as num?)?.toDouble() ?? 0.0,
      averageSpeed: (json['averageSpeed'] as num?)?.toDouble() ?? 0.0,
      maxSpeed: (json['maxSpeed'] as num?)?.toDouble() ?? 0.0,
      startBattery: (json['startBattery'] as num?)?.toInt() ?? 0,
      currentBattery: (json['currentBattery'] as num?)?.toInt() ?? 0,
      currentRideMode: json['currentRideMode'] as String? ?? 'Eco',
      lastSavedRide: json['lastSavedRide'] == null
          ? null
          : Ride.fromJson(json['lastSavedRide'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BleTripStateToJson(_BleTripState instance) =>
    <String, dynamic>{
      'status': _$BleTripStatusEnumMap[instance.status]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'startOdometer': instance.startOdometer,
      'currentOdometer': instance.currentOdometer,
      'distance': instance.distance,
      'durationSeconds': instance.durationSeconds,
      'currentSpeed': instance.currentSpeed,
      'averageSpeed': instance.averageSpeed,
      'maxSpeed': instance.maxSpeed,
      'startBattery': instance.startBattery,
      'currentBattery': instance.currentBattery,
      'currentRideMode': instance.currentRideMode,
      'lastSavedRide': instance.lastSavedRide,
    };

const _$BleTripStatusEnumMap = {
  BleTripStatus.idle: 'idle',
  BleTripStatus.riding: 'riding',
  BleTripStatus.stopped: 'stopped',
};
