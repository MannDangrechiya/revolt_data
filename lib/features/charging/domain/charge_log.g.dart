// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChargeLog _$ChargeLogFromJson(Map<String, dynamic> json) => _ChargeLog(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  durationMinutes: (json['durationMinutes'] as num).toDouble(),
  kwhAdded: (json['kwhAdded'] as num).toDouble(),
  cost: (json['cost'] as num).toDouble(),
  paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
  locationType: $enumDecode(_$LocationTypeEnumMap, json['locationType']),
  startBattery: (json['startBattery'] as num).toInt(),
  endBattery: (json['endBattery'] as num).toInt(),
  locationName: json['locationName'] as String?,
  notes: json['notes'] as String?,
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  chargerType: json['chargerType'] as String?,
  chargingMethod: json['chargingMethod'] as String?,
  electricityPrice: (json['electricityPrice'] as num?)?.toDouble(),
  providerName: json['providerName'] as String?,
  maxChargingPowerKw: (json['maxChargingPowerKw'] as num?)?.toDouble(),
  photoPaths:
      (json['photoPaths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  bikeId: (json['bikeId'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChargeLogToJson(_ChargeLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'kwhAdded': instance.kwhAdded,
      'cost': instance.cost,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'locationType': _$LocationTypeEnumMap[instance.locationType]!,
      'startBattery': instance.startBattery,
      'endBattery': instance.endBattery,
      'locationName': instance.locationName,
      'notes': instance.notes,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'chargerType': instance.chargerType,
      'chargingMethod': instance.chargingMethod,
      'electricityPrice': instance.electricityPrice,
      'providerName': instance.providerName,
      'maxChargingPowerKw': instance.maxChargingPowerKw,
      'photoPaths': instance.photoPaths,
      'bikeId': instance.bikeId,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.creditCard: 'creditCard',
  PaymentMethod.rfidCard: 'rfidCard',
  PaymentMethod.appWallet: 'appWallet',
  PaymentMethod.cash: 'cash',
  PaymentMethod.free: 'free',
};

const _$LocationTypeEnumMap = {
  LocationType.home: 'home',
  LocationType.public: 'public',
  LocationType.work: 'work',
};
