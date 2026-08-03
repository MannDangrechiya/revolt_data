import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/document.dart';

part 'documents_provider.g.dart';

@riverpod
class Documents extends _$Documents {
  @override
  Stream<List<Document>> build() {
    final db = ref.watch(databaseProvider);
    return db.select(db.documentsTable).watch().map((rows) {
      final documents = rows.map((row) => row.toDomain()).toList();
      documents.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));
      return documents;
    });
  }

  Future<void> addDocument(Document document) async {
    final db = ref.watch(databaseProvider);
    await db.into(db.documentsTable).insert(document.toCompanion());
  }

  Future<void> removeDocument(int id) async {
    final db = ref.watch(databaseProvider);
    await (db.delete(db.documentsTable)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Future<Document?> documentById(Ref ref, String id) async {
  final intId = int.tryParse(id);
  if (intId == null) return null;
  final db = ref.watch(databaseProvider);
  final row = await (db.select(db.documentsTable)..where((t) => t.id.equals(intId))).getSingleOrNull();
  return row?.toDomain();
}
