// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bike _$BikeFromJson(Map<String, dynamic> json) => _Bike(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  brand: json['brand'] as String,
  model: json['model'] as String,
  variant: json['variant'] as String?,
  color: json['color'] as String,
  registrationNumber: json['registrationNumber'] as String,
  vin: json['vin'] as String?,
  motorNumber: json['motorNumber'] as String?,
  purchaseDate: json['purchaseDate'] == null
      ? null
      : DateTime.parse(json['purchaseDate'] as String),
  purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
  dealer: json['dealer'] as String?,
  insurance: json['insurance'] as String?,
  warranty: json['warranty'] as String?,
  batteryWarranty: json['batteryWarranty'] as String?,
  batteryCapacity: (json['batteryCapacity'] as num?)?.toDouble(),
  motorPower: (json['motorPower'] as num?)?.toDouble(),
  claimedRange: (json['claimedRange'] as num?)?.toDouble(),
  topSpeed: (json['topSpeed'] as num?)?.toDouble(),
  tyreInfo: json['tyreInfo'] as String?,
  customNotes: json['customNotes'] as String?,
  photoPath: json['photoPath'] as String?,
);

Map<String, dynamic> _$BikeToJson(_Bike instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'model': instance.model,
  'variant': instance.variant,
  'color': instance.color,
  'registrationNumber': instance.registrationNumber,
  'vin': instance.vin,
  'motorNumber': instance.motorNumber,
  'purchaseDate': instance.purchaseDate?.toIso8601String(),
  'purchasePrice': instance.purchasePrice,
  'dealer': instance.dealer,
  'insurance': instance.insurance,
  'warranty': instance.warranty,
  'batteryWarranty': instance.batteryWarranty,
  'batteryCapacity': instance.batteryCapacity,
  'motorPower': instance.motorPower,
  'claimedRange': instance.claimedRange,
  'topSpeed': instance.topSpeed,
  'tyreInfo': instance.tyreInfo,
  'customNotes': instance.customNotes,
  'photoPath': instance.photoPath,
};
