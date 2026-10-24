import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../domain/commute_schedule.dart';

/// Schedules the weekday morning "commute ready" notification.
///
/// One repeating notification per weekday (Mon-Fri, 08:00 local). Scheduling
/// reuses fixed ids, so calling this on every launch replaces rather than
/// duplicates them.
class CommuteReminderService {
  static const int _baseId = 9100;
  static const String _channelId = 'revolt_commute';

  final FlutterLocalNotificationsPlugin _plugin;

  CommuteReminderService([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  Future<void> scheduleWeekdayReminders() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        'Commute',
        channelDescription: 'Weekday morning commute reminder',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    final now = tz.TZDateTime.now(tz.local);
    for (var weekday = DateTime.monday;
        weekday <= DateTime.friday;
        weekday++) {
      await _plugin.zonedSchedule(
        id: _baseId + weekday,
        title: 'Morning Commute Ready',
        body: 'Tap to start GPS tracking and open the cockpit.',
        scheduledDate: nextCommuteReminder(now, weekday),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: kCommutePayload,
      );
    }
    debugPrint('[Commute] Scheduled weekday reminders');
  }
}
