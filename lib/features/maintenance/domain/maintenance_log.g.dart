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
      serviceCenter: json['serviceCenter'] as String?,
      partsReplaced: json['partsReplaced'] as String?,
      labourCost: (json['labourCost'] as num?)?.toDouble(),
      warrantyClaim: json['warrantyClaim'] as bool? ?? false,
      technician: json['technician'] as String?,
      invoicePhotoPath: json['invoicePhotoPath'] as String?,
      notes: json['notes'] as String?,
      nextServiceDueOdometer: (json['nextServiceDueOdometer'] as num?)
          ?.toDouble(),
      nextServiceDueDate: json['nextServiceDueDate'] == null
          ? null
          : DateTime.parse(json['nextServiceDueDate'] as String),
      tyres: json['tyres'] as bool? ?? false,
      brakes: json['brakes'] as bool? ?? false,
      battery: json['battery'] as bool? ?? false,
      suspension: json['suspension'] as bool? ?? false,
      motor: json['motor'] as bool? ?? false,
      lights: json['lights'] as bool? ?? false,
      horn: json['horn'] as bool? ?? false,
      softwareUpdate: json['softwareUpdate'] as bool? ?? false,
      generalInspection: json['generalInspection'] as bool? ?? false,
      bikeId: (json['bikeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MaintenanceLogToJson(_MaintenanceLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'component': _$MaintenanceComponentEnumMap[instance.component]!,
      'description': instance.description,
      'odometerReading': instance.odometerReading,
      'cost': instance.cost,
      'serviceCenter': instance.serviceCenter,
      'partsReplaced': instance.partsReplaced,
      'labourCost': instance.labourCost,
      'warrantyClaim': instance.warrantyClaim,
      'technician': instance.technician,
      'invoicePhotoPath': instance.invoicePhotoPath,
      'notes': instance.notes,
      'nextServiceDueOdometer': instance.nextServiceDueOdometer,
      'nextServiceDueDate': instance.nextServiceDueDate?.toIso8601String(),
      'tyres': instance.tyres,
      'brakes': instance.brakes,
      'battery': instance.battery,
      'suspension': instance.suspension,
      'motor': instance.motor,
      'lights': instance.lights,
      'horn': instance.horn,
      'softwareUpdate': instance.softwareUpdate,
      'generalInspection': instance.generalInspection,
      'bikeId': instance.bikeId,
    };

const _$MaintenanceComponentEnumMap = {
  MaintenanceComponent.tires: 'tires',
  MaintenanceComponent.brakes: 'brakes',
  MaintenanceComponent.batteryPack: 'batteryPack',
  MaintenanceComponent.suspension: 'suspension',
  MaintenanceComponent.motorController: 'motorController',
  MaintenanceComponent.other: 'other',
};
