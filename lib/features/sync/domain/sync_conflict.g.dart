// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_conflict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncConflict _$SyncConflictFromJson(Map<String, dynamic> json) =>
    _SyncConflict(
      conflictId: json['conflictId'] as String,
      type: $enumDecode(_$ConflictTypeEnumMap, json['type']),
      existingRide: Ride.fromJson(json['existingRide'] as Map<String, dynamic>),
      newCandidate: MissedRideCandidate.fromJson(
        json['newCandidate'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SyncConflictToJson(_SyncConflict instance) =>
    <String, dynamic>{
      'conflictId': instance.conflictId,
      'type': _$ConflictTypeEnumMap[instance.type]!,
      'existingRide': instance.existingRide,
      'newCandidate': instance.newCandidate,
    };

const _$ConflictTypeEnumMap = {
  ConflictType.duplicateRide: 'duplicateRide',
  ConflictType.overlappingTime: 'overlappingTime',
  ConflictType.odometerMismatch: 'odometerMismatch',
};
