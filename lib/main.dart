import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tzl;

import 'app.dart';
import 'core/config/env_config.dart';
import 'core/router.dart' as router;
import 'core/services/monitoring/crash_reporting_service.dart';
import 'core/theme/theme_provider.dart';
import 'features/tracking/data/background_location_service.dart';
import 'features/tracking/data/commute_reminder_service.dart';
import 'features/tracking/domain/commute_schedule.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      // Load environment configuration
      await EnvConfig.init();

      // Initialize crash reporting and error monitoring
      await CrashReportingService.instance.initialize();
      CrashReportingService.instance.recordBreadcrumb(
        'App Bootstrapped',
        category: 'Lifecycle',
      );

      tz.initializeTimeZones();
      await _setLocalTimeZone();
      await preloadThemeMode();
      await BackgroundLocationService().initialize();

      // Request Notification permission
      await Permission.notification.request();

      // Initialize system orientation locker
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Set modern transparent system UI overlay
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      );

      // Initialize Local Notifications
      await _initializeNotifications();
      await _scheduleCommuteReminders();

      // Run the app
      runApp(const ProviderScope(child: AppWidget()));
      unawaited(_openCommuteIfLaunchedByReminder());
    } catch (e, stackTrace) {
      // Log failure gracefully to monitoring
      CrashReportingService.instance.recordError(
        e,
        stackTrace,
        reason: 'VoltLog initialization failed',
        fatal: true,
      );

      // Run app anyway with error state
      runApp(const ProviderScope(child: AppWidget()));
    }
  }, (error, stackTrace) {
    CrashReportingService.instance.recordError(
      error,
      stackTrace,
      reason: 'Uncaught Async Error in Zone',
      fatal: true,
    );
  });
}

Future<void> _initializeNotifications() async {
  try {
    final FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload == kCommutePayload) {
          router.routerDelegate.push(kCommuteRoute);
        } else if (payload != null && payload.isNotEmpty) {
          router.routerDelegate.push('/reminders/edit/$payload');
        }
      },
    );
    debugPrint('Local Notifications initialized successfully');
  } catch (e) {
    debugPrint('Notifications initialization failed: $e');
    rethrow;
  }
}
/// Without this `tz.local` stays UTC and scheduled notifications fire at the
/// wrong local time.
Future<void> _setLocalTimeZone() async {
  try {
    final info = await FlutterTimezone.getLocalTimezone();
    tzl.setLocalLocation(tzl.getLocation(info.identifier));
  } catch (e) {
    debugPrint('Could not resolve local time zone, using UTC: $e');
  }
}

Future<void> _scheduleCommuteReminders() async {
  try {
    await CommuteReminderService().scheduleWeekdayReminders();
  } catch (e) {
    debugPrint('Commute reminder scheduling failed: $e');
  }
}

/// A notification tap on a cold start does not invoke the response callback;
/// check the launch details so the commute reminder still opens the cockpit.
Future<void> _openCommuteIfLaunchedByReminder() async {
  try {
    final launch =
        await FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp == true &&
        launch?.notificationResponse?.payload == kCommutePayload) {
      router.routerDelegate.push(kCommuteRoute);
    }
  } catch (e) {
    debugPrint('Launch notification check failed: $e');
  }
}
