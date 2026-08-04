import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';

part 'data_clear_service.g.dart';

@riverpod
Future<void> clearAllData(Ref ref) async {
  final db = ref.read(databaseProvider);

  // Delete all rows from data tables but preserve bikesTable
  await db.delete(db.ridesTable).go();
  await db.delete(db.chargeLogsTable).go();
  await db.delete(db.expensesTable).go();
  await db.delete(db.maintenanceLogsTable).go();
  await db.delete(db.remindersTable).go();
  await db.delete(db.documentsTable).go();
  await db.delete(db.batteryHealthSnapshotsTable).go();
}
