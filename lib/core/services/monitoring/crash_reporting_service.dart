import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../config/env_config.dart';

/// Central Crash Reporting, Analytics & Telemetry Monitoring Service
class CrashReportingService {
  static final CrashReportingService instance = CrashReportingService._internal();

  CrashReportingService._internal();

  bool _isFirebaseInitialized = false;
  bool _isSentryInitialized = false;

  final List<String> _localBreadcrumbs = [];
  @visibleForTesting
  List<String> get localBreadcrumbs => List.unmodifiable(_localBreadcrumbs);

  /// Initializes Sentry and Firebase monitoring if configured.
  Future<void> initialize() async {
    // 1. Initialize Firebase if config present
    if (EnvConfig.firebaseApiKey.isNotEmpty || !kIsWeb) {
      try {
        await Firebase.initializeApp();
        _isFirebaseInitialized = true;

        // Pass all uncaught Flutter framework errors to Crashlytics
        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };
        debugPrint('[CrashReportingService] Firebase initialized successfully');
      } catch (e) {
        debugPrint('[CrashReportingService] Firebase init skipped or failed: $e');
      }
    }

    // 2. Initialize Sentry if DSN is available
    if (EnvConfig.isSentryConfigured) {
      try {
        await SentryFlutter.init(
          (options) {
            options.dsn = EnvConfig.sentryDsn;
            options.environment = EnvConfig.environment;
            options.tracesSampleRate = 1.0;
          },
        );
        _isSentryInitialized = true;
        debugPrint('[CrashReportingService] Sentry initialized successfully');
      } catch (e) {
        debugPrint('[CrashReportingService] Sentry init skipped or failed: $e');
      }
    }

    // 3. Catch platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      recordError(error, stack, fatal: true, reason: 'Uncaught Platform Error');
      return true;
    };
  }

  /// Record an error or exception to monitoring services and local log.
  void recordError(
    Object exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) {
    debugPrint('[CrashReportingService Error] $reason: $exception');

    if (_isFirebaseInitialized) {
      try {
        FirebaseCrashlytics.instance.recordError(
          exception,
          stackTrace,
          reason: reason,
          fatal: fatal,
        );
      } catch (_) {}
    }

    if (_isSentryInitialized) {
      try {
        Sentry.captureException(
          exception,
          stackTrace: stackTrace,
          hint: Hint.withMap({'reason': reason ?? ''}),
        );
      } catch (_) {}
    }
  }

  /// Log a breadcrumb for event tracking during debugging/crash reports.
  void recordBreadcrumb(
    String message, {
    String? category,
    SentryLevel level = SentryLevel.info,
  }) {
    final formattedMessage = '[${category ?? 'App'}] $message';
    _localBreadcrumbs.add(formattedMessage);
    if (_localBreadcrumbs.length > 50) {
      _localBreadcrumbs.removeAt(0);
    }

    debugPrint('[Breadcrumb] $formattedMessage');

    if (_isSentryInitialized) {
      try {
        Sentry.addBreadcrumb(
          Breadcrumb(
            message: message,
            category: category,
            level: level,
          ),
        );
      } catch (_) {}
    }
  }

  /// Log an analytics event (e.g. ride completed, sync triggered).
  Future<void> logAnalyticsEvent(String name, {Map<String, Object>? parameters}) async {
    debugPrint('[Analytics Event] $name $parameters');

    if (_isFirebaseInitialized) {
      try {
        await FirebaseAnalytics.instance.logEvent(
          name: name,
          parameters: parameters,
        );
      } catch (_) {}
    }
  }

  /// Reset internal state (for unit testing)
  @visibleForTesting
  void resetForTest() {
    _isFirebaseInitialized = false;
    _isSentryInitialized = false;
    _localBreadcrumbs.clear();
  }
}
