import 'package:freezed_annotation/freezed_annotation.dart';
import 'missed_ride_candidate.dart';
import 'sync_conflict.dart';

part 'sync_result.freezed.dart';

@freezed
abstract class SyncResult with _$SyncResult {
  const factory SyncResult.nothingToSync() = _NothingToSync;
  const factory SyncResult.syncedSuccessfully({
    required int ridesAdded,
    required int chargesAdded,
  }) = _SyncedSuccessfully;
  const factory SyncResult.conflictsDetected({
    required List<SyncConflict> conflicts,
  }) = _ConflictsDetected;
  const factory SyncResult.missedRidesDetected({
    required List<MissedRideCandidate> candidates,
  }) = _MissedRidesDetected;
}
