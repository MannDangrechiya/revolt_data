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
