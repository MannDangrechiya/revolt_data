import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/database/database_provider.dart';
import '../../../ble/domain/vehicle_snapshot.dart';
import '../../data/offline_queue.dart';
import '../../data/sync_engine.dart';
import '../../data/sync_history_log.dart';
import '../../data/sync_state_service.dart';
import '../../domain/missed_ride_candidate.dart';
import '../../domain/sync_conflict.dart';
import '../../domain/sync_result.dart';

part 'sync_engine_notifier.freezed.dart';
part 'sync_engine_notifier.g.dart';

final syncEngineNotifierProvider = syncEngineProvider;

@freezed
abstract class SyncEngineState with _$SyncEngineState {
  const factory SyncEngineState.idle() = _Idle;
  const factory SyncEngineState.syncing() = _Syncing;
  const factory SyncEngineState.success({
    required int ridesAdded,
    required int chargesAdded,
  }) = _Success;
  const factory SyncEngineState.needsConflictResolution(
    List<SyncConflict> conflicts,
  ) = _NeedsConflictResolution;
  const factory SyncEngineState.needsReview(
    List<MissedRideCandidate> candidates,
  ) = _NeedsReview;
}

@riverpod
class SyncEngineNotifier extends _$SyncEngineNotifier {
  @override
  SyncEngineState build() => const SyncEngineState.idle();

  Future<void> onBleConnected(VehicleSnapshot snapshot) async {
    state = const SyncEngineState.syncing();

    final syncStateService = await ref.read(syncStateServiceProvider.future);
    final db = ref.read(databaseProvider);
    final offlineQueueService = ref.read(offlineQueueProvider);
    final syncLogService = ref.read(syncHistoryLogServiceProvider);

    final syncEngine = SyncEngine(
      syncState: syncStateService,
      db: db,
      offlineQueue: offlineQueueService,
      syncHistoryLog: syncLogService,
    );

    final result = await syncEngine.performSync(
      currentSnapshot: snapshot,
      connectedAt: DateTime.now(),
    );

    result.when(
      nothingToSync: () => state = const SyncEngineState.idle(),
      syncedSuccessfully: (rides, charges) =>
          state = SyncEngineState.success(ridesAdded: rides, chargesAdded: charges),
      conflictsDetected: (conflicts) =>
          state = SyncEngineState.needsConflictResolution(conflicts),
      missedRidesDetected: (candidates) =>
          state = SyncEngineState.needsReview(candidates),
    );
  }

  void resetState() {
    state = const SyncEngineState.idle();
  }
}
