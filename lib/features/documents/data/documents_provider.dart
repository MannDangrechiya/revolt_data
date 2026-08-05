import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/document.dart';
import '../../reminders/data/reminders_provider.dart';
import '../../reminders/domain/reminder.dart';

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
    final savedId = await db.into(db.documentsTable).insert(document.toCompanion());

    final reminderId = 'doc_reminder_$savedId';
    final isRenewalCat = document.category == 'Insurance' || document.category == 'Warranty';

    if (isRenewalCat && document.expiryDate != null) {
      final type = document.category == 'Insurance' ? 'Insurance Renewal' : 'Warranty Expiry';
      final title = 'Renew ${document.category == 'Insurance' ? 'Insurance' : 'Warranty'} for ${document.name}';
      final targetDate = document.expiryDate!.subtract(const Duration(days: 30));

      final reminder = Reminder(
        id: reminderId,
        title: title,
        body: 'Document ${document.name} expires on ${document.expiryDate!.year}-${document.expiryDate!.month.toString().padLeft(2, '0')}-${document.expiryDate!.day.toString().padLeft(2, '0')}',
        targetDate: targetDate,
        type: type,
        note: 'Auto-generated renewal reminder for document $savedId',
        bikeId: document.bikeId,
      );

      await ref.read(remindersProvider.notifier).addReminder(reminder);
    } else {
      await ref.read(remindersProvider.notifier).removeReminder(reminderId);
    }
  }

  Future<void> removeDocument(int id) async {
    final reminderId = 'doc_reminder_$id';
    await ref.read(remindersProvider.notifier).removeReminder(reminderId);

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
