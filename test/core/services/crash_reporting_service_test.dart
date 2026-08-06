import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/core/services/monitoring/crash_reporting_service.dart';

void main() {
  group('CrashReportingService Unit Tests', () {
    late CrashReportingService service;

    setUp(() {
      service = CrashReportingService.instance;
      service.resetForTest();
    });

    test('recordBreadcrumb adds formatted breadcrumb to local log buffer', () {
      service.recordBreadcrumb('User tapped sync button', category: 'UI');

      expect(service.localBreadcrumbs.length, equals(1));
      expect(service.localBreadcrumbs.first, equals('[UI] User tapped sync button'));
    });

    test('recordBreadcrumb caps buffer at 50 items', () {
      for (int i = 0; i < 60; i++) {
        service.recordBreadcrumb('Event $i', category: 'Test');
      }

      expect(service.localBreadcrumbs.length, equals(50));
      expect(service.localBreadcrumbs.last, equals('[Test] Event 59'));
    });

    test('recordError captures exception safely without throwing when uninitialized', () {
      expect(() {
        service.recordError(
          Exception('Test error'),
          StackTrace.current,
          reason: 'Unit Test Exception',
          fatal: false,
        );
      }, returnsNormally);
    });

    test('logAnalyticsEvent records event parameters safely', () async {
      expect(() async {
        await service.logAnalyticsEvent('ride_completed', parameters: {
          'distance_km': 14.5,
          'mode': 'Sport',
        });
      }, returnsNormally);
    });
  });
}
