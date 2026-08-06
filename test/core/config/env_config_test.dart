import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/core/config/env_config.dart';

void main() {
  group('EnvConfig Unit Tests', () {
    tearDown(() {
      EnvConfig.reset();
    });

    test('EnvConfig init handles missing .env gracefully without throwing', () async {
      await EnvConfig.init(fileName: '.env.nonexistent');
      expect(EnvConfig.supabaseUrl, isEmpty);
      expect(EnvConfig.supabaseAnonKey, isEmpty);
      expect(EnvConfig.sentryDsn, isEmpty);
      expect(EnvConfig.environment, equals('development'));
    });

    test('EnvConfig isSupabaseConfigured returns false when keys are empty', () {
      expect(EnvConfig.isSupabaseConfigured, isFalse);
    });

    test('EnvConfig isSentryConfigured returns false when DSN is empty', () {
      expect(EnvConfig.isSentryConfigured, isFalse);
    });
  });
}
