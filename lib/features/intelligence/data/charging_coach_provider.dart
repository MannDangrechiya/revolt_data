import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../charging/data/charging_provider.dart';
import '../../charging/domain/charge_log.dart';
import '../domain/coach_tip.dart';

part 'charging_coach_provider.g.dart';

@riverpod
Future<ChargingCoachTip> chargingCoach(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  final now = DateTime.now();

  if (logs.isEmpty) {
    return ChargingCoachTip(
      tip: 'Your charging pattern is efficient.',
      severity: CoachSeverity.info,
      confidence: 70.0,
      lastUpdated: now,
    );
  }

  // Home night charging calculation (10 PM - 6 AM)
  final homeLogs =
      logs.where((l) => l.locationType == LocationType.home).toList();
  final awayLogs =
      logs.where((l) => l.locationType != LocationType.home).toList();

  final homeNightLogs = homeLogs.where((l) {
    final hour = (l.startTime ?? l.date).hour;
    return hour >= 22 || hour < 6;
  }).toList();

  final homeNightChargingPct = homeLogs.isNotEmpty
      ? (homeNightLogs.length / homeLogs.length) * 100.0
      : 100.0;

  final homeNightCost = homeNightLogs.isNotEmpty
      ? homeNightLogs.fold<double>(
              0, (s, l) => s + (l.kwhAdded > 0 ? l.cost / l.kwhAdded : l.cost)) /
          homeNightLogs.length
      : 5.0;

  final awayCost = awayLogs.isNotEmpty
      ? awayLogs.fold<double>(
              0, (s, l) => s + (l.kwhAdded > 0 ? l.cost / l.kwhAdded : l.cost)) /
          awayLogs.length
      : 12.0;

  // Charger location count and speed comparison
  final locationsMap = <String, List<ChargeLog>>{};
  for (final l in logs) {
    final name = l.locationName ?? l.locationType.name;
    locationsMap.putIfAbsent(name, () => []).add(l);
  }

  final chargerLocationCount = locationsMap.keys.length;

  // Charge frequency per week
  final last7Days = now.subtract(const Duration(days: 7));
  final chargeFrequencyWeek =
      logs.where((l) => l.date.isAfter(last7Days)).length;

  if (homeNightChargingPct < 50.0 && homeNightCost < awayCost) {
    final savingsPct =
        (((awayCost - homeNightCost) / awayCost) * 100).round();
    final clampedSavings = savingsPct.clamp(10, 60);
    return ChargingCoachTip(
      tip:
          'Charging at home between 10 PM - 6 AM is $clampedSavings% cheaper based on your history.',
      severity: CoachSeverity.warning,
      confidence: 85.0,
      lastUpdated: now,
    );
  } else if (chargerLocationCount > 1) {
    final sortedLocations = locationsMap.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));
    final locA = sortedLocations[0];
    final locB = sortedLocations[1];
    final avgSpeedA =
        locA.value.fold<double>(0, (s, l) => s + l.chargingSpeedKw) /
            locA.value.length;
    final avgSpeedB =
        locB.value.fold<double>(0, (s, l) => s + l.chargingSpeedKw) /
            locB.value.length;

    final nameB = locB.key;
    final speedAStr = avgSpeedA.toStringAsFixed(1);
    final speedBStr = avgSpeedB.toStringAsFixed(1);
    final ratioStr =
        avgSpeedA > 0 ? (avgSpeedB / avgSpeedA).toStringAsFixed(1) : '1.5';

    return ChargingCoachTip(
      tip:
          'Your frequent charger averages $speedAStr kW. The charger at $nameB averages $speedBStr kW — ${ratioStr}x faster.',
      severity: CoachSeverity.info,
      confidence: 80.0,
      lastUpdated: now,
    );
  } else if (chargeFrequencyWeek > 10) {
    return ChargingCoachTip(
      tip:
          'You charged $chargeFrequencyWeek times this week. Consider fewer, deeper charges.',
      severity: CoachSeverity.warning,
      confidence: 85.0,
      lastUpdated: now,
    );
  } else {
    return ChargingCoachTip(
      tip: 'Your charging pattern is efficient.',
      severity: CoachSeverity.info,
      confidence: 90.0,
      lastUpdated: now,
    );
  }
}
