import 'package:freezed_annotation/freezed_annotation.dart';
import '../../rides/domain/ride.dart';
import 'missed_ride_candidate.dart';

part 'sync_conflict.freezed.dart';
part 'sync_conflict.g.dart';

enum ConflictType {
  duplicateRide,
  overlappingTime,
  odometerMismatch,
}

@freezed
abstract class SyncConflict with _$SyncConflict {
  const factory SyncConflict({
    required String conflictId,
    required ConflictType type,
    required Ride existingRide,
    required MissedRideCandidate newCandidate,
  }) = _SyncConflict;

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);
}
