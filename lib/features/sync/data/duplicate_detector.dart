import '../../rides/domain/ride.dart';
import '../domain/missed_ride_candidate.dart';
import '../domain/sync_conflict.dart';

class DuplicateDetector {
  /// Returns true if candidate is likely a duplicate of an existing ride
  static bool isDuplicate({
    required MissedRideCandidate candidate,
    required List<Ride> existingRides,
  }) {
    return findConflict(candidate: candidate, existingRides: existingRides) != null;
  }

  /// Returns SyncConflict if a conflict/duplicate is found with an existing ride
  static SyncConflict? findConflict({
    required MissedRideCandidate candidate,
    required List<Ride> existingRides,
  }) {
    for (final ride in existingRides) {
      final rideStart = ride.startTime ?? ride.date;
      final timeDiffMinutes =
          candidate.estimatedStartTime.difference(rideStart).inMinutes.abs();
      final rideDistance = (ride.endOdometer - ride.startOdometer).abs();
      final odoDiff = (candidate.odometerDeltaKm - rideDistance).abs();

      // Duplicate match criteria: within 10 min and 0.5 km
      if (timeDiffMinutes < 10 && odoDiff < 0.5) {
        return SyncConflict(
          conflictId: 'conflict_${ride.id}_${candidate.id}',
          type: ConflictType.duplicateRide,
          existingRide: ride,
          newCandidate: candidate,
        );
      }

      // Overlapping time criteria
      final rideEnd = ride.endTime ?? rideStart.add(Duration(minutes: ride.durationMinutes ?? 15));
      if (candidate.estimatedStartTime.isBefore(rideEnd) &&
          candidate.estimatedEndTime.isAfter(rideStart)) {
        return SyncConflict(
          conflictId: 'conflict_overlap_${ride.id}_${candidate.id}',
          type: ConflictType.overlappingTime,
          existingRide: ride,
          newCandidate: candidate,
        );
      }
    }
    return null;
  }
}
