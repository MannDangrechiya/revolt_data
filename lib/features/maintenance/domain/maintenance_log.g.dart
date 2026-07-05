// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaintenanceLog _$MaintenanceLogFromJson(Map<String, dynamic> json) =>
    _MaintenanceLog(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      component: $enumDecode(_$MaintenanceComponentEnumMap, json['component']),
      description: json['description'] as String,
      odometerReading: (json['odometerReading'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$MaintenanceLogToJson(_MaintenanceLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'component': _$MaintenanceComponentEnumMap[instance.component]!,
      'description': instance.description,
      'odometerReading': instance.odometerReading,
      'cost': instance.cost,
    };

const _$MaintenanceComponentEnumMap = {
  MaintenanceComponent.tires: 'tires',
  MaintenanceComponent.brakes: 'brakes',
  MaintenanceComponent.batteryPack: 'batteryPack',
  MaintenanceComponent.suspension: 'suspension',
  MaintenanceComponent.motorController: 'motorController',
  MaintenanceComponent.other: 'other',
};
