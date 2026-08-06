import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class TrackingNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const int kNotificationId = 999;
  static const String kChannelId = 'bg_gps_tracking_channel';
  static const String kChannelName = 'Background GPS Ride Tracking';

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(settings: settings);

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      const channel = AndroidNotificationChannel(
        kChannelId,
        kChannelName,
        description: 'Notifications while tracking ride via GPS in background',
        importance: Importance.low,
        playSound: false,
      );
      await androidPlugin.createNotificationChannel(channel);
    }
  }

  static Future<void> showOrUpdateNotification({
    required double distanceKm,
    required double speedKmh,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        kChannelId,
        kChannelName,
        channelDescription:
            'Notifications while tracking ride via GPS in background',
        importance: Importance.low,
        priority: Priority.low,
        ongoing: true,
        autoCancel: false,
        showWhen: true,
        actions: [
          AndroidNotificationAction(
            'STOP_TRACKING_ACTION',
            'Stop Tracking',
            showsUserInterface: true,
          ),
        ],
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: false,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notificationsPlugin.show(
        id: kNotificationId,
        title: 'Ride Tracking Active',
        body: 'Distance: ${distanceKm.toStringAsFixed(2)} km | Speed: ${speedKmh.toStringAsFixed(1)} km/h',
        notificationDetails: details,
        payload: '/dashboard',
      );
    } catch (e) {
      debugPrint('Error updating tracking notification: $e');
    }
  }

  static Future<void> cancelNotification() async {
    try {
      await _notificationsPlugin.cancel(id: kNotificationId);
    } catch (e) {
      debugPrint('Error cancelling tracking notification: $e');
    }
  }
}
