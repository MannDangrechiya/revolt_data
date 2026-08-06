import '../domain/missed_ride_candidate.dart';

class ConfidenceScorer {
  /// Calculates confidence ('high' | 'medium' | 'low') for a missed ride candidate.
  static String calculateConfidence(MissedRideCandidate candidate) {
    final hasGps = candidate.gpsRoute != null &&
        candidate.gpsRoute!.isNotEmpty &&
        candidate.gpsDistanceKm != null &&
        candidate.gpsDistanceKm! > 0;

    final hasOdo = candidate.odometerDeltaKm > 0;

    if (hasGps && hasOdo) {
      final deviation = (candidate.gpsDistanceKm! - candidate.odometerDeltaKm).abs() /
          candidate.odometerDeltaKm;
      if (deviation < 0.10) {
        return 'high';
      }
      return 'medium';
    }

    if (hasGps) {
      return 'medium';
    }

    if (hasOdo) {
      final gapHours = candidate.estimatedEndTime
          .difference(candidate.estimatedStartTime)
          .inHours
          .abs();
      if (gapHours >= 6) {
        return 'low';
      }
      return 'medium';
    }

    return 'low';
  }
}
