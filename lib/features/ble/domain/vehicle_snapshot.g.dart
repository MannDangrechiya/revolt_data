// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleSnapshot _$VehicleSnapshotFromJson(Map<String, dynamic> json) =>
    _VehicleSnapshot(
      battery: (json['battery'] as num).toInt(),
      voltage: (json['voltage'] as num).toDouble(),
      current: (json['current'] as num).toDouble(),
      temp: (json['temp'] as num).toInt(),
      speed: (json['speed'] as num).toDouble(),
      odo: (json['odo'] as num).toDouble(),
      range: (json['range'] as num).toDouble(),
      mode: json['mode'] as String,
      faults:
          (json['faults'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$VehicleSnapshotToJson(_VehicleSnapshot instance) =>
    <String, dynamic>{
      'battery': instance.battery,
      'voltage': instance.voltage,
      'current': instance.current,
      'temp': instance.temp,
      'speed': instance.speed,
      'odo': instance.odo,
      'range': instance.range,
      'mode': instance.mode,
      'faults': instance.faults,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
