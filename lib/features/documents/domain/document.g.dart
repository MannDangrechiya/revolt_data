// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Document _$DocumentFromJson(Map<String, dynamic> json) => _Document(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  category: json['category'] as String,
  filePath: json['filePath'] as String,
  uploadDate: DateTime.parse(json['uploadDate'] as String),
  notes: json['notes'] as String?,
  bikeId: (json['bikeId'] as num?)?.toInt(),
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
);

Map<String, dynamic> _$DocumentToJson(_Document instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'filePath': instance.filePath,
  'uploadDate': instance.uploadDate.toIso8601String(),
  'notes': instance.notes,
  'bikeId': instance.bikeId,
  'expiryDate': instance.expiryDate?.toIso8601String(),
};
