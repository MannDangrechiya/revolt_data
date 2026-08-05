// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationHistory _$NotificationHistoryFromJson(Map<String, dynamic> json) =>
    _NotificationHistory(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      firedAt: DateTime.parse(json['firedAt'] as String),
      payload: json['payload'] as String?,
    );

Map<String, dynamic> _$NotificationHistoryToJson(
  _NotificationHistory instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'firedAt': instance.firedAt.toIso8601String(),
  'payload': instance.payload,
};
