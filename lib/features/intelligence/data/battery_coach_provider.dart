import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../charging/data/battery_health_provider.dart';
import '../../charging/data/charging_provider.dart';
import '../../charging/domain/charge_log.dart';
import '../domain/coach_tip.dart';

part 'battery_coach_provider.g.dart';

@riverpod
Future<BatteryCoachTip> batteryCoach(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  final degradationRate =
      await ref.watch(batteryHealthDegradationRateProvider.future);

  final now = DateTime.now();
  final last30Days = now.subtract(const Duration(days: 30));
  final last7Days = now.subtract(const Duration(days: 7));

  final recent30Logs = logs.where((l) => l.date.isAfter(last30Days)).toList();
  final recent7Logs = logs.where((l) => l.date.isAfter(last7Days)).toList();

  // Rule 1: charging to 100% frequently (>50% of charges in last 30 days)
  final chargesTo100Count =
      recent30Logs.where((l) => l.endBattery >= 100).length;
  final isFrequently100 = recent30Logs.isNotEmpty &&
      (chargesTo100Count / recent30Logs.length) > 0.5;

  // Rule 2: fast charging count > 3 in last 7 days (> 1.5 kW)
  final fastChargingCount =
      recent7Logs.where((l) => l.chargingSpeedKw > 1.5).length;

  // Rule 3: monthly degradation rate > 1%
  final highDegradation = degradationRate > 1.0;

  if (isFrequently100) {
    return BatteryCoachTip(
      tip:
          'You charge to 100% too often. Keeping between 20-80% extends battery life.',
      severity: CoachSeverity.warning,
      confidence: 85.0,
      lastUpdated: now,
    );
  } else if (fastChargingCount > 3) {
    return BatteryCoachTip(
      tip:
          'Fast charging detected frequently. Consider slow charging for daily use.',
      severity: CoachSeverity.warning,
      confidence: 80.0,
      lastUpdated: now,
    );
  } else if (highDegradation) {
    final roundedDrop = degradationRate.toStringAsFixed(1);
    return BatteryCoachTip(
      tip:
          'Your battery health dropped $roundedDrop% this month. Review charging habits.',
      severity: CoachSeverity.critical,
      confidence: 90.0,
      lastUpdated: now,
    );
  } else {
    return BatteryCoachTip(
      tip: 'Your charging habits are healthy. Keep it up!',
      severity: CoachSeverity.info,
      confidence: 95.0,
      lastUpdated: now,
    );
  }
}
