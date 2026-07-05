import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service.g.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> showImmediateNotification({
    required int id,
    required String title,
    required String body,
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
    );
  }

  // NOTE: In a real app with exact time scheduling, we'd use timezone package and 
  // plugin.zonedSchedule. For simplicity in this demo without heavy timezone setup,
  // we'll rely on our reactive odometer trigger engine or simple periodic checks.
}

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService();
}
