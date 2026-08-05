// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battery_health_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BatteryHealthSnapshot _$BatteryHealthSnapshotFromJson(
  Map<String, dynamic> json,
) => _BatteryHealthSnapshot(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  healthPercent: (json['healthPercent'] as num).toDouble(),
  rangeAtFullCharge: (json['rangeAtFullCharge'] as num).toDouble(),
  bikeId: (json['bikeId'] as num?)?.toInt(),
);

Map<String, dynamic> _$BatteryHealthSnapshotToJson(
  _BatteryHealthSnapshot instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'healthPercent': instance.healthPercent,
  'rangeAtFullCharge': instance.rangeAtFullCharge,
  'bikeId': instance.bikeId,
};
