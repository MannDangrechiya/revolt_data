import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'sync_history_log.g.dart';

class SyncHistoryLogService {
  final AppDatabase _db;

  SyncHistoryLogService(this._db);

  /// Logs a sync attempt result to the database.
  Future<int> logSync({
    required String result, // 'success' | 'conflict' | 'missed_rides' | 'nothing'
    int ridesAdded = 0,
    int chargesAdded = 0,
    int conflictsResolved = 0,
    String? detailsJson,
  }) async {
    final companion = SyncLogsTableCompanion.insert(
      syncedAt: DateTime.now(),
      result: result,
      ridesAdded: Value(ridesAdded),
      chargesAdded: Value(chargesAdded),
      conflictsResolved: Value(conflictsResolved),
      detailsJson: Value(detailsJson),
    );

    final id = await _db.into(_db.syncLogsTable).insert(companion);
    await cleanupOldLogs();
    return id;
  }

  /// Gets the timestamp of the last successful or completed sync attempt.
  Future<DateTime?> getLastSyncTime() async {
    final query = _db.select(_db.syncLogsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
      ..limit(1);
    final log = await query.getSingleOrNull();
    return log?.syncedAt;
  }

  /// Retrieves recent sync logs up to [limit].
  Future<List<SyncLog>> getSyncHistory({int limit = 50}) async {
    final query = _db.select(_db.syncLogsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.syncedAt)])
      ..limit(limit);
    return await query.get();
  }

  /// Deletes sync logs older than 30 days.
  Future<int> cleanupOldLogs() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    return await (_db.delete(_db.syncLogsTable)
          ..where((t) => t.syncedAt.isSmallerThanValue(cutoff)))
        .go();
  }
}

@riverpod
SyncHistoryLogService syncHistoryLogService(Ref ref) {
  final db = ref.watch(databaseProvider);
  return SyncHistoryLogService(db);
}
