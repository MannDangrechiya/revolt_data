// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_charge_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BleChargeState _$BleChargeStateFromJson(Map<String, dynamic> json) =>
    _BleChargeState(
      status:
          $enumDecodeNullable(_$BleChargeStatusEnumMap, json['status']) ??
          BleChargeStatus.idle,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      startBattery: (json['startBattery'] as num?)?.toInt() ?? 0,
      currentBattery: (json['currentBattery'] as num?)?.toInt() ?? 0,
      batteryGained: (json['batteryGained'] as num?)?.toInt() ?? 0,
      kwhAdded: (json['kwhAdded'] as num?)?.toDouble() ?? 0.0,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      peakBatteryTemp: (json['peakBatteryTemp'] as num?)?.toInt() ?? 0,
      peakPowerKw: (json['peakPowerKw'] as num?)?.toDouble() ?? 0.0,
      lastSavedChargeLog: json['lastSavedChargeLog'] == null
          ? null
          : ChargeLog.fromJson(
              json['lastSavedChargeLog'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$BleChargeStateToJson(_BleChargeState instance) =>
    <String, dynamic>{
      'status': _$BleChargeStatusEnumMap[instance.status]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'startBattery': instance.startBattery,
      'currentBattery': instance.currentBattery,
      'batteryGained': instance.batteryGained,
      'kwhAdded': instance.kwhAdded,
      'durationSeconds': instance.durationSeconds,
      'peakBatteryTemp': instance.peakBatteryTemp,
      'peakPowerKw': instance.peakPowerKw,
      'lastSavedChargeLog': instance.lastSavedChargeLog,
    };

const _$BleChargeStatusEnumMap = {
  BleChargeStatus.idle: 'idle',
  BleChargeStatus.charging: 'charging',
  BleChargeStatus.completed: 'completed',
};
