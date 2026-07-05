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
      return rows.map((row) => row.toDomain()).toList();
    });
  }

  Future<void> addReminder(Reminder reminder) async {
    final db = ref.watch(databaseProvider);
    await db.into(db.remindersTable).insert(reminder.toCompanion());
  }

  Future<void> markCompleted(String id) async {
    final db = ref.watch(databaseProvider);
    final reminders = await db.select(db.remindersTable).get();
    final reminder = reminders.firstWhere((r) => r.id == id);
    final updated = reminder.copyWith(isCompleted: true);
    await db.update(db.remindersTable).replace(updated);
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
