import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../../database/database_provider.dart';

part 'notification_service.g.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  final AppDatabase? _db;

  NotificationService([this._db]);

  Future<void> showImmediateNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'revolt_alerts',
      'Revolt Alerts',
      channelDescription: 'Notifications for maintenance and reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );

    await _recordHistory(title: title, body: body, payload: payload);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'revolt_reminders',
      'Revolt Reminders',
      channelDescription: 'Scheduled reminders for bike maintenance and events',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);
    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) return;

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzScheduledDate,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
    );

    await _recordHistory(title: title, body: body, payload: payload);
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  Future<void> _recordHistory({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (_db != null) {
      try {
        await _db.into(_db.notificationHistoryTable).insert(
          NotificationHistoryTableCompanion.insert(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: title,
            body: body,
            firedAt: DateTime.now(),
            payload: Value(payload),
          ),
        );
      } catch (_) {}
    }
  }
}

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService(ref.watch(databaseProvider));
}
