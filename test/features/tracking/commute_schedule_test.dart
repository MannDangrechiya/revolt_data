import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/tracking/domain/commute_schedule.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tzdata.initializeTimeZones();

  group('isInCommutePromptWindow', () {
    // 2026-10-26 is a Monday, 2026-10-24 a Saturday.
    test('true on weekday inside 07:30-09:30', () {
      expect(isInCommutePromptWindow(DateTime(2026, 10, 26, 7, 30)), isTrue);
      expect(isInCommutePromptWindow(DateTime(2026, 10, 26, 9, 30)), isTrue);
    });

    test('false outside the window', () {
      expect(isInCommutePromptWindow(DateTime(2026, 10, 26, 7, 29)), isFalse);
      expect(isInCommutePromptWindow(DateTime(2026, 10, 26, 9, 31)), isFalse);
    });

    test('false on weekends', () {
      expect(isInCommutePromptWindow(DateTime(2026, 10, 24, 8)), isFalse);
    });
  });

  group('nextCommuteReminder', () {
    final kolkata = tz.getLocation('Asia/Kolkata');

    test('later today when 08:00 has not passed', () {
      final now = tz.TZDateTime(kolkata, 2026, 10, 26, 6); // Monday
      expect(nextCommuteReminder(now, DateTime.monday),
          tz.TZDateTime(kolkata, 2026, 10, 26, 8));
    });

    test('next week when 08:00 already passed', () {
      final now = tz.TZDateTime(kolkata, 2026, 10, 26, 9); // Monday
      expect(nextCommuteReminder(now, DateTime.monday),
          tz.TZDateTime(kolkata, 2026, 11, 2, 8));
    });

    test('lands on the requested weekday', () {
      final now = tz.TZDateTime(kolkata, 2026, 10, 24, 12); // Saturday
      final next = nextCommuteReminder(now, DateTime.wednesday);
      expect(next.weekday, DateTime.wednesday);
      expect(next, tz.TZDateTime(kolkata, 2026, 10, 28, 8));
    });
  });
}
