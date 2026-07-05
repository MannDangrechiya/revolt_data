import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_summary.freezed.dart';
part 'dashboard_summary.g.dart';

@freezed
abstract class BatteryState with _$BatteryState {
  const factory BatteryState({
    @Default(0) int percentage,
    @Default(0) double estimatedRange,
  }) = _BatteryState;

  factory BatteryState.fromJson(Map<String, dynamic> json) => _$BatteryStateFromJson(json);
}

@freezed
abstract class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    // Current bike status
    required double currentOdometer,

    // Mileage statistics
    @Default(0) double todayDistance,
    @Default(0) double weeklyDistance,
    @Default(0) double monthlyDistance,

    // Battery status
    required BatteryState battery,

    // Upcoming reminder
    String? upcomingReminderTitle,
    DateTime? upcomingReminderDate,

    // Recent activities
    required List<DashboardActivity> recentActivities,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) => _$DashboardSummaryFromJson(json);
}

@freezed
abstract class DashboardActivity with _$DashboardActivity {
  const factory DashboardActivity({
    required String id,
    required ActivityType type,
    required DateTime date,
    required String title,
    String? subtitle,
    double? value,
    String? valueUnit,
  }) = _DashboardActivity;

  factory DashboardActivity.fromJson(Map<String, dynamic> json) => _$DashboardActivityFromJson(json);
}

enum ActivityType { ride, charge, expense, maintenance }
