import '../../../core/database/app_database.dart';
import '../../../core/database/database_mappers.dart';
import '../../ble/data/revolt_ble_repository.dart';
import '../../ble/domain/vehicle_snapshot.dart';
import '../../rides/domain/ride.dart';
import '../../tracking/data/background_location_service.dart';
import '../../tracking/data/ride_merger.dart';
import '../../tracking/domain/gps_tracking_state.dart';
import '../domain/missed_ride_candidate.dart';
import '../domain/sync_result.dart';
import 'cloud_sync_service.dart';
import 'confidence_scorer.dart';
import 'duplicate_detector.dart';
import 'offline_queue.dart';
import 'sync_history_log.dart';
import 'sync_state_service.dart';

class SyncEngine {
  final SyncStateService _syncState;
  final AppDatabase _db;
  final OfflineQueue _offlineQueue;
  final SyncHistoryLogService _syncHistoryLog;
  final CloudSyncService _cloudSyncService;

  CloudSyncService get cloudSyncService => _cloudSyncService;

  SyncEngine({
    required SyncStateService syncState,
    RevoltBleRepository? bleRepo,
    required AppDatabase db,
    required OfflineQueue offlineQueue,
    required SyncHistoryLogService syncHistoryLog,
    CloudSyncService? cloudSyncService,
  })  : _syncState = syncState,
        _db = db,
        _offlineQueue = offlineQueue,
        _syncHistoryLog = syncHistoryLog,
        _cloudSyncService = cloudSyncService ?? CloudSyncService();

  /// Main entry point — called on every successful BLE connection
  Future<SyncResult> performSync({
    required VehicleSnapshot currentSnapshot,
    required DateTime connectedAt,
  }) async {
    // Step 1: Read last sync state
    final lastState = await _syncState.getLastSyncState();

    // Step 2: Fetch existing rides for duplicate checking
    final rideRows = await _db.select(_db.ridesTable).get();
    final existingRides = rideRows.map((r) => r.toDomain()).toList();

    // Step 3: Process offline queue first
    final offlineAddedCount = await _offlineQueue.processPendingQueue(
      existingRides: existingRides,
      insertRide: (ride) async {
        await _db.into(_db.ridesTable).insert(ride.toCompanion());
      },
    );

    // If no prior sync state, save initial snapshot state and return
    if (lastState == null) {
      await _syncState.saveSyncState(
        odometer: currentSnapshot.odometer,
        batteryPercent: currentSnapshot.batteryPercent,
      );
      await _syncHistoryLog.logSync(
        result: offlineAddedCount > 0 ? 'success' : 'nothing',
        ridesAdded: offlineAddedCount,
      );
      if (offlineAddedCount > 0) {
        return SyncResult.syncedSuccessfully(
          ridesAdded: offlineAddedCount,
          chargesAdded: 0,
        );
      }
      return const SyncResult.nothingToSync();
    }

    // Step 4: Check background GPS tracking state
    final trackingService = BackgroundLocationService();
    final gpsState = trackingService.state;

    double? gpsDistanceKm;
    double? gpsMaxSpeedKmh;
    var gpsRoute = gpsState is GpsTrackingStateCompleted ? gpsState.route : null;

    if (gpsState is GpsTrackingStateCompleted) {
      gpsDistanceKm = gpsState.totalDistanceKm;
      gpsMaxSpeedKmh = gpsState.maxSpeedKmh;
    }

    // Step 5: Detect odometer gap
    final currentOdo = currentSnapshot.odometer ?? lastState.lastSyncedOdometer;
    final currentBattery = currentSnapshot.batteryPercent ?? lastState.lastKnownBatteryPercent;
    final odoDelta = currentOdo - lastState.lastSyncedOdometer;

    if (odoDelta <= 0.1 && (gpsRoute == null || gpsRoute.isEmpty)) {
      await _syncState.saveSyncState(
        odometer: currentSnapshot.odometer,
        batteryPercent: currentSnapshot.batteryPercent,
      );
      await _syncHistoryLog.logSync(
        result: offlineAddedCount > 0 ? 'success' : 'nothing',
        ridesAdded: offlineAddedCount,
      );
      if (offlineAddedCount > 0) {
        return SyncResult.syncedSuccessfully(
          ridesAdded: offlineAddedCount,
          chargesAdded: 0,
        );
      }
      return const SyncResult.nothingToSync();
    }

    // Step 6: Construct candidate missed ride
    final candidateId = 'cand_${DateTime.now().microsecondsSinceEpoch}';
    final hasGps = gpsRoute != null && gpsRoute.isNotEmpty;
    final dataSource = (hasGps && odoDelta > 0.1)
        ? 'merged'
        : (hasGps ? 'gps_only' : 'odometer_only');

    final candidate = MissedRideCandidate(
      id: candidateId,
      estimatedStartTime: lastState.lastSyncedAt,
      estimatedEndTime: connectedAt,
      odometerDeltaKm: odoDelta > 0 ? odoDelta : (gpsDistanceKm ?? 0.0),
      gpsDistanceKm: gpsDistanceKm,
      gpsMaxSpeedKmh: gpsMaxSpeedKmh,
      gpsRoute: gpsRoute,
      confidence: 'low',
      dataSource: dataSource,
    );

    final confidence = ConfidenceScorer.calculateConfidence(candidate);
    final scoredCandidate = candidate.copyWith(confidence: confidence);

    // Step 7: Check for duplicate / conflict with existing rides
    final conflict = DuplicateDetector.findConflict(
      candidate: scoredCandidate,
      existingRides: existingRides,
    );

    if (conflict != null) {
      await _syncState.saveSyncState(
        odometer: currentSnapshot.odometer,
        batteryPercent: currentSnapshot.batteryPercent,
      );
      await _syncHistoryLog.logSync(
        result: 'conflict',
        ridesAdded: offlineAddedCount,
        detailsJson: 'Conflict detected: ${conflict.type.name}',
      );
      return SyncResult.conflictsDetected(conflicts: [conflict]);
    }

    // Step 8: Handle auto-accept for high confidence vs review for medium/low
    if (scoredCandidate.confidence == 'high') {
      final durationMins = connectedAt
          .difference(lastState.lastSyncedAt)
          .inMinutes
          .clamp(1, 1440);

      final autoRide = Ride(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: lastState.lastSyncedAt,
        startOdometer: lastState.lastSyncedOdometer,
        endOdometer: currentOdo,
        batteryBefore: lastState.lastKnownBatteryPercent,
        batteryAfter: currentBattery,
        rideMode: RideMode.normal,
        roadCondition: RoadCondition.smooth,
        startTime: lastState.lastSyncedAt,
        endTime: connectedAt,
        durationMinutes: durationMins,
        maxSpeed: scoredCandidate.gpsMaxSpeedKmh ?? 40.0,
        notes: 'Auto-synced ride via Smart Sync Engine',
        source: scoredCandidate.dataSource,
        routePolyline: (scoredCandidate.gpsRoute != null && scoredCandidate.gpsRoute!.isNotEmpty)
            ? RideMerger.encodeRoutePolyline(scoredCandidate.gpsRoute!)
            : null,
      );

      await _db.into(_db.ridesTable).insert(autoRide.toCompanion());
      await _syncState.saveSyncState(
        odometer: currentOdo,
        batteryPercent: currentBattery,
      );
      await _syncHistoryLog.logSync(
        result: 'success',
        ridesAdded: 1 + offlineAddedCount,
      );
      return SyncResult.syncedSuccessfully(
        ridesAdded: 1 + offlineAddedCount,
        chargesAdded: 0,
      );
    }

    // Medium or Low confidence candidates -> return for user review
    await _syncState.saveSyncState(
      odometer: currentOdo,
      batteryPercent: currentBattery,
    );
    await _syncHistoryLog.logSync(
      result: 'missed_rides',
      ridesAdded: offlineAddedCount,
      detailsJson: 'Missed ride candidates detected: 1',
    );
    return SyncResult.missedRidesDetected(candidates: [scoredCandidate]);
  }
}
