import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../maintenance/data/maintenance_provider.dart';
import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';

part 'service_intelligence_provider.g.dart';

/// Predicts the next service using whatever the last MaintenanceLog actually
/// recorded (nextServiceDueOdometer / nextServiceDueDate), falling back to a
/// generic interval only when the log didn't set one. Ride frequency
/// converts a km target into an estimated day count for the overdue case.
@riverpod
Future<String> serviceIntelligence(Ref ref) async {
  final logs = await ref.watch(maintenanceLogsProvider.future);
  if (logs.isEmpty) {
    return 'No service history yet — log your first maintenance to get predictions.';
  }

  final rides = await ref.watch(ridesProvider.future);
  final lastService = logs.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

  final currentOdometer = rides.isEmpty
      ? lastService.odometerReading
      : rides.map((r) => r.endOdometer).reduce((a, b) => a > b ? a : b);

  // km/day over the last 30 days, to turn a km target into a day estimate.
  final cutoff = DateTime.now().subtract(const Duration(days: 30));
  final recentDistance = rides
      .where((r) => r.date.isAfter(cutoff))
      .fold<double>(0, (sum, r) => sum + r.distance);
  final kmPerDay = recentDistance / 30.0;

  if (lastService.nextServiceDueDate != null &&
      lastService.nextServiceDueDate!.isBefore(DateTime.now())) {
    final daysOverdue =
        DateTime.now().difference(lastService.nextServiceDueDate!).inDays;
    return 'Service overdue by $daysOverdue days';
  }

  // ponytail: 3000km is a generic EV service interval used only when the
  // log itself didn't record a due target; revisit if bike-specific
  // intervals get added.
  const fallbackIntervalKm = 3000.0;
  final dueOdometer = lastService.nextServiceDueOdometer ??
      (lastService.odometerReading + fallbackIntervalKm);
  final kmRemaining = dueOdometer - currentOdometer;

  if (kmRemaining <= 0) {
    if (kmPerDay > 0) {
      final daysOverdue = (-kmRemaining / kmPerDay).round();
      return 'Service overdue by ~$daysOverdue days';
    }
    return 'Service overdue by ${(-kmRemaining).round()} km';
  }

  return 'Next service estimated in ~${kmRemaining.round()} km';
}
