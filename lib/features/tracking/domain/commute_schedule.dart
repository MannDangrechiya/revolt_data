import 'package:timezone/timezone.dart' as tz;

/// Notification payload that tells the app to start a commute ride.
const String kCommutePayload = 'commute:start';

/// Route opened by the commute notification / banner; `autostart=1` makes the
/// cockpit begin GPS tracking.
const String kCommuteRoute = '/cockpit?autostart=1';

/// Fixed commute reminder time (local), Monday to Friday.
const int kCommuteReminderHour = 8;
const int kCommuteReminderMinute = 0;

/// Foreground-resume prompt window, inclusive (07:30 - 09:30 local).
const int _promptStartMinutes = 7 * 60 + 30;
const int _promptEndMinutes = 9 * 60 + 30;

bool isCommuteDay(DateTime date) =>
    date.weekday >= DateTime.monday && date.weekday <= DateTime.friday;

/// Whether [now] is on a commute day within the prompt window.
bool isInCommutePromptWindow(DateTime now) {
  if (!isCommuteDay(now)) return false;
  final minutes = now.hour * 60 + now.minute;
  return minutes >= _promptStartMinutes && minutes <= _promptEndMinutes;
}

/// Next reminder time strictly after [now] that falls on [weekday]
/// (`DateTime.monday`..`DateTime.friday`), in [now]'s time zone.
tz.TZDateTime nextCommuteReminder(tz.TZDateTime now, int weekday) {
  tz.TZDateTime at(int dayOffset) => tz.TZDateTime(
        now.location,
        now.year,
        now.month,
        now.day + dayOffset,
        kCommuteReminderHour,
        kCommuteReminderMinute,
      );
  var offset = 0;
  var candidate = at(offset);
  while (candidate.weekday != weekday || !candidate.isAfter(now)) {
    candidate = at(++offset);
  }
  return candidate;
}
