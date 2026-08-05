import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_history.freezed.dart';
part 'notification_history.g.dart';

@freezed
abstract class NotificationHistory with _$NotificationHistory {
  const factory NotificationHistory({
    required String id,
    required String title,
    required String body,
    required DateTime firedAt,
    String? payload,
  }) = _NotificationHistory;

  factory NotificationHistory.fromJson(Map<String, dynamic> json) => _$NotificationHistoryFromJson(json);
}
