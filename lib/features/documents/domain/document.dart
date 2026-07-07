import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

@freezed
abstract class Document with _$Document {
  const factory Document({
    int? id,
    required String name,
    required String category,
    required String filePath,
    required DateTime uploadDate,
    String? notes,
    int? bikeId,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);
}
