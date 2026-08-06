import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'app.dart';
import 'core/config/env_config.dart';
import 'core/router.dart' as router;
import 'core/services/monitoring/crash_reporting_service.dart';
import 'core/theme/theme_provider.dart';
import 'features/tracking/data/background_location_service.dart';

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

      // Run the app
      runApp(const ProviderScope(child: AppWidget()));
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
        if (payload != null && payload.isNotEmpty) {
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