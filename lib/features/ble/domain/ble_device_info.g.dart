// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BleDeviceInfo _$BleDeviceInfoFromJson(Map<String, dynamic> json) =>
    _BleDeviceInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      rssi: (json['rssi'] as num).toInt(),
      isRevoltBike: json['isRevoltBike'] as bool? ?? true,
    );

Map<String, dynamic> _$BleDeviceInfoToJson(_BleDeviceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rssi': instance.rssi,
      'isRevoltBike': instance.isRevoltBike,
    };
