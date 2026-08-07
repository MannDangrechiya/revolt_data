import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../sync/data/sync_state_service.dart';
import '../../domain/vehicle_snapshot.dart';
import 'ble_connection_provider.dart';

part 'vehicle_snapshot_provider.g.dart';

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
///
/// Every snapshot is persisted to disk (fire-and-forget) so the last-known
/// state survives an app restart, not just an in-memory reconnect — the bike
/// has no channel to push data to us without an active BLE connection, so
/// "last synced at X" from disk is the honest equivalent of the official
/// app's cloud-backed sync.
@riverpod
Stream<VehicleSnapshot> vehicleSnapshot(Ref ref) {
  final repository = ref.watch(bleRepositoryProvider);
  return repository.getVehicleSnapshotStream().map((snapshot) {
    ref.read(syncStateServiceProvider.future).then((s) => s.saveLastSnapshot(snapshot));
    return snapshot;
  });
}

/// Provider exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.
@riverpod
VehicleSnapshot? lastKnownVehicleSnapshot(Ref ref) {
  final snapshotAsync = ref.watch(vehicleSnapshotProvider);
  final repository = ref.watch(bleRepositoryProvider);
  return snapshotAsync.value ?? repository.lastCachedSnapshot;
}

/// The persisted-on-disk snapshot, for screens that want to show "last
/// synced at X" even before any BLE connection this app session (survives
/// app restart — [lastKnownVehicleSnapshotProvider] above does not).
@riverpod
Future<VehicleSnapshot?> persistedVehicleSnapshot(Ref ref) async {
  final service = await ref.watch(syncStateServiceProvider.future);
  return service.getLastSnapshot();
}
