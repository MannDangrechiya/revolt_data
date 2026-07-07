// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  targetDate: json['targetDate'] == null
      ? null
      : DateTime.parse(json['targetDate'] as String),
  targetOdometer: (json['targetOdometer'] as num?)?.toDouble(),
  isCompleted: json['isCompleted'] as bool? ?? false,
  isNotified: json['isNotified'] as bool? ?? false,
  type: json['type'] as String?,
  note: json['note'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  bikeId: (json['bikeId'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'targetDate': instance.targetDate?.toIso8601String(),
  'targetOdometer': instance.targetOdometer,
  'isCompleted': instance.isCompleted,
  'isNotified': instance.isNotified,
  'type': instance.type,
  'note': instance.note,
  'isActive': instance.isActive,
  'bikeId': instance.bikeId,
};
