import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String title,
    required String body,
    DateTime? targetDate,
    double? targetOdometer,
    @Default(false) bool isCompleted,
    @Default(false) bool isNotified, // To prevent duplicate alerts
    String? type,
    String? note,
    @Default(true) bool isActive,
    int? bikeId,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) => _$ReminderFromJson(json);
}
