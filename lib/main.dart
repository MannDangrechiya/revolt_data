import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  try {
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

    // Drift is initialized lazily



    // Initialize Local Notifications
    await _initializeNotifications();

    // Run the app
    runApp(const ProviderScope(child: AppWidget()));
  } catch (e, stackTrace) {
    // Log failure gracefully
    debugPrint('VoltLog initialization failed: $e');
    debugPrintStack(stackTrace: stackTrace);

    // Run app anyway with error state
    runApp(const ProviderScope(child: AppWidget()));
  }
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
      onDidReceiveNotificationResponse: (details) {},
    );
    debugPrint('Local Notifications initialized successfully');
  } catch (e) {
    debugPrint('Notifications initialization failed: $e');
    rethrow;
  }
}

// Local Notifications placeholder
// The database is handled by Riverpod.