import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/notifications/notification_service.dart';
import '../../rides/data/rides_provider.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/reminder.dart';

part 'reminders_provider.g.dart';

@riverpod
class Reminders extends _$Reminders {
  @override
  Stream<List<Reminder>> build() {
    // Proactive Reminders Engine: Listen to rides to evaluate odometer-based targets
    ref.listen(ridesProvider, (previous, next) {
      if (next.hasValue && next.value != null && next.value!.isNotEmpty) {
        final latestRide = next.value!.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
        final currentOdo = latestRide.endOdometer;
        _evaluateOdometerTargets(currentOdo);
      }
    });

    final db = ref.watch(databaseProvider);
    return db.select(db.remindersTable).watch().map((rows) {
      final reminders = rows.map((row) => row.toDomain()).toList();
      reminders.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        }
        if (a.targetDate != null && b.targetDate != null) {
          return a.targetDate!.compareTo(b.targetDate!);
        }
        if (a.targetOdometer != null && b.targetOdometer != null) {
          return a.targetOdometer!.compareTo(b.targetOdometer!);
        }
        return 0;
      });
      _syncScheduledNotifications(reminders);
      return reminders;
    });
  }

  Future<void> addReminder(Reminder reminder) async {
    final db = ref.watch(databaseProvider);
    await db.into(db.remindersTable).insert(reminder.toCompanion());
  }

  Future<void> updateReminder(Reminder reminder) async {
    final db = ref.watch(databaseProvider);
    await db.update(db.remindersTable).replace(reminder.toCompanion());
  }

  Future<void> removeReminder(String id) async {
    final notificationService = ref.read(notificationServiceProvider);
    await notificationService.cancelNotification(id.hashCode);
    final db = ref.watch(databaseProvider);
    await (db.delete(db.remindersTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> markCompleted(String id) async {
    final db = ref.watch(databaseProvider);
    final reminders = await db.select(db.remindersTable).get();
    final reminder = reminders.firstWhere((r) => r.id == id);
    final updated = reminder.copyWith(isCompleted: true);
    await db.update(db.remindersTable).replace(updated);
  }

  void _syncScheduledNotifications(List<Reminder> reminders) {
    final notificationService = ref.read(notificationServiceProvider);
    for (final reminder in reminders) {
      final notificationId = reminder.id.hashCode;
      if (reminder.targetDate != null && reminder.isActive && !reminder.isCompleted) {
        if (reminder.targetDate!.isAfter(DateTime.now())) {
          notificationService.scheduleNotification(
            id: notificationId,
            title: reminder.title,
            body: reminder.body,
            scheduledDate: reminder.targetDate!,
            payload: reminder.id,
          );
        }
      } else {
        notificationService.cancelNotification(notificationId);
      }
    }
  }

  Future<void> _evaluateOdometerTargets(double currentOdometer) async {
    final notificationService = ref.read(notificationServiceProvider);
    final db = ref.read(databaseProvider);
    
    // Evaluate if current odometer is within 50km of target
    final proximityThreshold = 50.0;
    
    final currentReminders = await db.select(db.remindersTable).get();

    for (final reminder in currentReminders) {
      if (!reminder.isCompleted && !reminder.isNotified && reminder.targetOdometer != null) {
        final diff = reminder.targetOdometer! - currentOdometer;
        
        if (diff <= proximityThreshold && diff >= 0) {
          // Fire alert
          notificationService.showImmediateNotification(
            id: reminder.id.hashCode,
            title: reminder.title,
            body: '${reminder.body}. Current Odo: $currentOdometer km (Target: ${reminder.targetOdometer} km)',
          );
          
          final updated = reminder.copyWith(isNotified: true);
          await db.update(db.remindersTable).replace(updated);
        }
      }
    }
  }
}

@riverpod
Future<Reminder?> reminderById(Ref ref, String id) async {
  final db = ref.watch(databaseProvider);
  final row = await (db.select(db.remindersTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  return row?.toDomain();
}
