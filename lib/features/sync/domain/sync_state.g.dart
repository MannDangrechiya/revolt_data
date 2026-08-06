// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncState _$SyncStateFromJson(Map<String, dynamic> json) => _SyncState(
  lastSyncedOdometer: (json['lastSyncedOdometer'] as num).toDouble(),
  lastSyncedAt: DateTime.parse(json['lastSyncedAt'] as String),
  lastKnownBatteryPercent: (json['lastKnownBatteryPercent'] as num).toInt(),
);

Map<String, dynamic> _$SyncStateToJson(_SyncState instance) =>
    <String, dynamic>{
      'lastSyncedOdometer': instance.lastSyncedOdometer,
      'lastSyncedAt': instance.lastSyncedAt.toIso8601String(),
      'lastKnownBatteryPercent': instance.lastKnownBatteryPercent,
    };
