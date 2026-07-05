// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BatteryState _$BatteryStateFromJson(Map<String, dynamic> json) =>
    _BatteryState(
      percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      estimatedRange: (json['estimatedRange'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$BatteryStateToJson(_BatteryState instance) =>
    <String, dynamic>{
      'percentage': instance.percentage,
      'estimatedRange': instance.estimatedRange,
    };

_DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) =>
    _DashboardSummary(
      currentOdometer: (json['currentOdometer'] as num).toDouble(),
      todayDistance: (json['todayDistance'] as num?)?.toDouble() ?? 0,
      weeklyDistance: (json['weeklyDistance'] as num?)?.toDouble() ?? 0,
      monthlyDistance: (json['monthlyDistance'] as num?)?.toDouble() ?? 0,
      battery: BatteryState.fromJson(json['battery'] as Map<String, dynamic>),
      upcomingReminderTitle: json['upcomingReminderTitle'] as String?,
      upcomingReminderDate: json['upcomingReminderDate'] == null
          ? null
          : DateTime.parse(json['upcomingReminderDate'] as String),
      recentActivities: (json['recentActivities'] as List<dynamic>)
          .map((e) => DashboardActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardSummaryToJson(_DashboardSummary instance) =>
    <String, dynamic>{
      'currentOdometer': instance.currentOdometer,
      'todayDistance': instance.todayDistance,
      'weeklyDistance': instance.weeklyDistance,
      'monthlyDistance': instance.monthlyDistance,
      'battery': instance.battery,
      'upcomingReminderTitle': instance.upcomingReminderTitle,
      'upcomingReminderDate': instance.upcomingReminderDate?.toIso8601String(),
      'recentActivities': instance.recentActivities,
    };

_DashboardActivity _$DashboardActivityFromJson(Map<String, dynamic> json) =>
    _DashboardActivity(
      id: json['id'] as String,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      valueUnit: json['valueUnit'] as String?,
    );

Map<String, dynamic> _$DashboardActivityToJson(_DashboardActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'subtitle': instance.subtitle,
      'value': instance.value,
      'valueUnit': instance.valueUnit,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.ride: 'ride',
  ActivityType.charge: 'charge',
  ActivityType.expense: 'expense',
  ActivityType.maintenance: 'maintenance',
};
