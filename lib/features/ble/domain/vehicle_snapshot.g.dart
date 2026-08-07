// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleSnapshot _$VehicleSnapshotFromJson(Map<String, dynamic> json) =>
    _VehicleSnapshot(
      batteryPercent: (json['batteryPercent'] as num?)?.toInt(),
      batteryVoltage: (json['batteryVoltage'] as num?)?.toDouble(),
      batteryCurrent: (json['batteryCurrent'] as num?)?.toDouble(),
      batteryTemp: (json['batteryTemp'] as num?)?.toInt(),
      motorTemp: (json['motorTemp'] as num?)?.toInt(),
      speed: (json['speed'] as num?)?.toDouble(),
      tripDistance: (json['tripDistance'] as num?)?.toDouble(),
      odometer: (json['odometer'] as num?)?.toDouble(),
      rideMode: json['rideMode'] as String?,
      range: (json['range'] as num?)?.toDouble(),
      power: (json['power'] as num?)?.toDouble(),
      faultCodes:
          (json['faultCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      batteryHealth: (json['batteryHealth'] as num?)?.toInt(),
      gpsCoords: json['gpsCoords'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$VehicleSnapshotToJson(_VehicleSnapshot instance) =>
    <String, dynamic>{
      'batteryPercent': instance.batteryPercent,
      'batteryVoltage': instance.batteryVoltage,
      'batteryCurrent': instance.batteryCurrent,
      'batteryTemp': instance.batteryTemp,
      'motorTemp': instance.motorTemp,
      'speed': instance.speed,
      'tripDistance': instance.tripDistance,
      'odometer': instance.odometer,
      'rideMode': instance.rideMode,
      'range': instance.range,
      'power': instance.power,
      'faultCodes': instance.faultCodes,
      'batteryHealth': instance.batteryHealth,
      'gpsCoords': instance.gpsCoords,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
