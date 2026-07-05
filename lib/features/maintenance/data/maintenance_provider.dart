import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/maintenance_log.dart';

part 'maintenance_provider.g.dart';

@riverpod
class MaintenanceLogs extends _$MaintenanceLogs {
  @override
  Stream<List<MaintenanceLog>> build() {
    final db = ref.watch(databaseProvider);
    return db.select(db.maintenanceLogsTable).watch().map((rows) {
      final logs = rows.map((row) => row.toDomain()).toList();
      logs.sort((a, b) => b.date.compareTo(a.date));
      return logs;
    });
  }

  Future<void> addLog(MaintenanceLog log) async {
    final db = ref.watch(databaseProvider);
    await db.into(db.maintenanceLogsTable).insert(log.toCompanion());
  }
  
  Future<void> removeLog(String id) async {
    final db = ref.watch(databaseProvider);
    await (db.delete(db.maintenanceLogsTable)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Future<Map<MaintenanceComponent, List<MaintenanceLog>>> maintenanceByComponent(Ref ref) async {
  final logs = await ref.watch(maintenanceLogsProvider.future);
  final map = <MaintenanceComponent, List<MaintenanceLog>>{};
  
  for (final log in logs) {
    map.putIfAbsent(log.component, () => []).add(log);
  }
  return map;
}
