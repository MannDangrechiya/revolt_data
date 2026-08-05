import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../maintenance/data/maintenance_provider.dart';
import '../../maintenance/domain/maintenance_log.dart';
import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';
import '../../intelligence/data/service_intelligence_provider.dart';
import '../domain/coach_tip.dart';

part 'maintenance_coach_provider.g.dart';

@riverpod
Future<MaintenanceCoachTip> maintenanceCoach(Ref ref) async {
  final logs = await ref.watch(maintenanceLogsProvider.future);
  final rides = await ref.watch(ridesProvider.future);
  final servicePrediction =
      await ref.watch(serviceIntelligenceProvider.future);
  final now = DateTime.now();

  final isOverdue = servicePrediction.contains('overdue');
  int overdueDays = 0;
  if (isOverdue) {
    final match =
        RegExp(r'overdue by ~?(\d+) days').firstMatch(servicePrediction);
    if (match != null) {
      overdueDays = int.tryParse(match.group(1) ?? '0') ?? 0;
    } else {
      overdueDays = 7;
    }
  }

  int serviceDueKm = 9999;
  if (servicePrediction.contains('estimated in ~')) {
    final match =
        RegExp(r'estimated in ~(\d+) km').firstMatch(servicePrediction);
    if (match != null) {
      serviceDueKm = int.tryParse(match.group(1) ?? '9999') ?? 9999;
    }
  }

  // Calculate km since last brake check
  final brakeLogs = logs
      .where((l) => l.brakes || l.component == MaintenanceComponent.brakes)
      .toList();
  final lastBrakeLog = brakeLogs.isNotEmpty
      ? brakeLogs.reduce((a, b) => a.date.isAfter(b.date) ? a : b)
      : null;

  final currentOdo = rides.isNotEmpty
      ? rides.map((r) => r.endOdometer).reduce((a, b) => a > b ? a : b)
      : (logs.isNotEmpty ? logs.first.odometerReading : 0.0);

  final kmSinceLastBrakeCheck = lastBrakeLog != null
      ? (currentOdo - lastBrakeLog.odometerReading).clamp(0.0, double.infinity)
      : currentOdo;

  // Check ride efficiency dropping > 15% (recent 5 vs previous 5)
  final validRides =
      rides.where((r) => r.batteryConsumed > 0 && r.distance > 0).toList();
  double efficiencyDrop = 0.0;
  if (validRides.length >= 6) {
    final recent5 = validRides.take(5).toList();
    final prev5 = validRides.skip(5).take(5).toList();
    final avgRecentEff = recent5.fold<double>(
            0, (s, r) => s + r.distance / r.batteryConsumed) /
        recent5.length;
    final avgPrevEff =
        prev5.fold<double>(0, (s, r) => s + r.distance / r.batteryConsumed) /
            prev5.length;
    if (avgPrevEff > 0) {
      efficiencyDrop = ((avgPrevEff - avgRecentEff) / avgPrevEff) * 100.0;
    }
  }

  if (overdueDays > 0) {
    return MaintenanceCoachTip(
      tip: 'Service overdue by $overdueDays days. Schedule now.',
      severity: CoachSeverity.critical,
      confidence: 95.0,
      lastUpdated: now,
    );
  } else if (serviceDueKm < 300) {
    return MaintenanceCoachTip(
      tip: 'Service due in ~$serviceDueKm km based on your riding pattern.',
      severity: CoachSeverity.warning,
      confidence: 90.0,
      lastUpdated: now,
    );
  } else if (kmSinceLastBrakeCheck > 500) {
    final roundedKm = kmSinceLastBrakeCheck.round();
    return MaintenanceCoachTip(
      tip:
          'Brake pad check recommended — you\'ve ridden $roundedKm km since last inspection.',
      severity: CoachSeverity.warning,
      confidence: 85.0,
      lastUpdated: now,
    );
  } else if (efficiencyDrop > 15.0) {
    return MaintenanceCoachTip(
      tip:
          'Tire rotation suggested — uneven wear detected from ride efficiency drops.',
      severity: CoachSeverity.warning,
      confidence: 75.0,
      lastUpdated: now,
    );
  } else {
    return MaintenanceCoachTip(
      tip: 'All maintenance indicators are healthy.',
      severity: CoachSeverity.info,
      confidence: 90.0,
      lastUpdated: now,
    );
  }
}
