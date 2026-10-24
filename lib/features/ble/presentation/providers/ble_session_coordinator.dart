import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../sync/presentation/providers/sync_engine_notifier.dart';
import '../../domain/ble_trip_state.dart';
import '../../domain/connection_state.dart';
import 'ble_connection_provider.dart';
import 'ble_trip_provider.dart';

/// How long to wait for the first fresh BLE snapshot after authentication
/// before giving up on the connect-time sync.
const Duration kSyncSnapshotTimeout = Duration(seconds: 30);

/// App-lifetime wiring between the BLE link and the features that react to it.
///
/// Watched once from the app root so that, regardless of which screen is open:
/// - [BleTripNotifier] exists and can auto-start trips, hand off to GPS on a
///   mid-ride disconnect, and finalize rides;
/// - the Smart Sync Engine runs each time the bike authenticates.
final bleSessionCoordinatorProvider = Provider<void>((ref) {
  // keepAlive notifiers are created lazily; build the trip notifier now.
  ref.read(bleTripProvider.notifier);
  // The sync notifier auto-disposes; hold it open so its state survives
  // between dashboard visits and updates never hit a disposed notifier.
  ref.listen(syncEngineNotifierProvider, (_, _) {});

  var syncInFlight = false;

  Future<void> syncOnConnect() async {
    if (syncInFlight) return;
    syncInFlight = true;
    try {
      final repo = ref.read(bleRepositoryProvider);
      final snapshot = await repo
          .getVehicleSnapshotStream()
          .first
          .timeout(kSyncSnapshotTimeout);
      await ref
          .read(syncEngineNotifierProvider.notifier)
          .onBleConnected(snapshot);
    } on TimeoutException {
      debugPrint('[BleSession] No telemetry within $kSyncSnapshotTimeout; skipping sync');
    } catch (e) {
      debugPrint('[BleSession] Sync on connect failed: $e');
    } finally {
      syncInFlight = false;
    }
  }

  ref.listen<AsyncValue<BleConnectionState>>(bleConnectionStateProvider,
      (prev, next) {
    final becameAuthenticated =
        next.value == BleConnectionState.authenticated &&
            prev?.value != BleConnectionState.authenticated;
    if (!becameAuthenticated) return;

    // A mid-ride reconnect is the same trip resuming, not a new session to
    // reconcile; the trip notifier owns that flow.
    final tripStatus = ref.read(bleTripProvider).status;
    if (tripStatus == BleTripStatus.riding ||
        tripStatus == BleTripStatus.gpsHandoff) {
      return;
    }
    unawaited(syncOnConnect());
  });
});
