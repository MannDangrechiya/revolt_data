import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../remote/data/revolt_remote_repository_provider.dart';
import '../../../sync/data/sync_state_service.dart';
import '../../data/telemetry_repository.dart';
import '../../domain/vehicle_snapshot.dart';
import 'ble_connection_provider.dart';

part 'vehicle_snapshot_provider.g.dart';

/// Provider for the single instance of [TelemetryRepository].
@Riverpod(keepAlive: true)
TelemetryRepository telemetryRepository(Ref ref) {
  final bleRepo = ref.watch(bleRepositoryProvider);
  final remoteRepo = ref.watch(revoltRemoteRepositoryProvider);

  final repo = TelemetryRepository(
    bleRepository: bleRepo,
    remoteRepository: remoteRepo,
  );

  ref.onDispose(() => repo.dispose());
  return repo;
}

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the hybrid dual-engine stream.
@riverpod
Stream<VehicleSnapshot> vehicleSnapshot(Ref ref) {
  final repository = ref.watch(telemetryRepositoryProvider);
  return repository.telemetryStream.map((snapshot) {
    ref.read(syncStateServiceProvider.future).then((s) => s.saveLastSnapshot(snapshot));
    return snapshot;
  });
}

/// Notifier exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.
@riverpod
class LastKnownVehicleSnapshot extends _$LastKnownVehicleSnapshot {
  @override
  VehicleSnapshot? build() {
    final snapshotAsync = ref.watch(vehicleSnapshotProvider);
    final telemetryRepo = ref.watch(telemetryRepositoryProvider);
    final bleRepo = ref.watch(bleRepositoryProvider);
    return snapshotAsync.value ?? telemetryRepo.lastSnapshot ?? bleRepo.lastCachedSnapshot;
  }
}

/// Notifier for the persisted-on-disk snapshot for screens showing last known data,
/// tagged explicitly as [TelemetrySource.cached].
@riverpod
class PersistedVehicleSnapshot extends _$PersistedVehicleSnapshot {
  @override
  FutureOr<VehicleSnapshot?> build() async {
    final service = await ref.watch(syncStateServiceProvider.future);
    final snapshot = service.getLastSnapshot();
    return snapshot?.copyWith(source: TelemetrySource.cached);
  }
}
