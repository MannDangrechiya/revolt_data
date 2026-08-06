import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App-wide Environment Configuration provider
class EnvConfig {
  static bool _isInitialized = false;

  /// Initializes the dotenv configuration safely.
  static Future<void> init({String fileName = '.env'}) async {
    try {
      await dotenv.load(fileName: fileName);
      _isInitialized = true;
      debugPrint('[EnvConfig] Successfully loaded environment configuration ($fileName)');
    } catch (e) {
      _isInitialized = false;
      debugPrint('[EnvConfig] Warning: Could not load $fileName file ($e). Using fallback configurations.');
    }
  }

  /// Whether dotenv loaded successfully
  static bool get isInitialized => _isInitialized && dotenv.isInitialized;

  static String _getValue(String key, {String fallback = ''}) {
    if (!dotenv.isInitialized) return fallback;
    return dotenv.maybeGet(key) ?? fallback;
  }

  /// Supabase Project URL
  static String get supabaseUrl => _getValue('SUPABASE_URL');

  /// Supabase Anon Public Key
  static String get supabaseAnonKey => _getValue('SUPABASE_ANON_KEY');

  /// Sentry DSN for error monitoring
  static String get sentryDsn => _getValue('SENTRY_DSN');

  /// Firebase API Key
  static String get firebaseApiKey => _getValue('FIREBASE_API_KEY');

  /// Firebase Project ID
  static String get firebaseProjectId => _getValue('FIREBASE_PROJECT_ID', fallback: 'revolt-platform-dev');

  /// Active deployment environment (development / staging / production)
  static String get environment => _getValue('ENVIRONMENT', fallback: 'development');

  /// Whether cloud services (Supabase) are configured
  static bool get isSupabaseConfigured => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  /// Whether Sentry monitoring is configured
  static bool get isSentryConfigured => sentryDsn.isNotEmpty;

  /// Reset initialization status (primarily for testing)
  @visibleForTesting
  static void reset() {
    _isInitialized = false;
    dotenv.clean();
  }
}
