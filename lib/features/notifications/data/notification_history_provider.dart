import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/notification_history.dart';

part 'notification_history_provider.g.dart';

@riverpod
class NotificationHistoryNotifier extends _$NotificationHistoryNotifier {
  @override
  Stream<List<NotificationHistory>> build() {
    final db = ref.watch(databaseProvider);
    return db.select(db.notificationHistoryTable).watch().map((rows) {
      final history = rows.map((row) => row.toDomain()).toList();
      history.sort((a, b) => b.firedAt.compareTo(a.firedAt));
      return history;
    });
  }

  Future<void> clearHistory() async {
    final db = ref.watch(databaseProvider);
    await db.delete(db.notificationHistoryTable).go();
  }
}
