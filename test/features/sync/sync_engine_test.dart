import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/core/database/database_mappers.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/sync/data/offline_queue.dart';
import 'package:revolt_data/features/sync/data/sync_engine.dart';
import 'package:revolt_data/features/sync/data/sync_history_log.dart';
import 'package:revolt_data/features/sync/data/sync_state_service.dart';
import 'package:revolt_data/features/sync/domain/sync_result.dart';

void main() {
  late AppDatabase db;
  late SyncStateService syncStateService;
  late OfflineQueue offlineQueue;
  late SyncHistoryLogService syncLogService;
  late SyncEngine syncEngine;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    db = AppDatabase.forTesting(NativeDatabase.memory());
    syncStateService = SyncStateService(prefs);
    offlineQueue = OfflineQueue(db);
    syncLogService = SyncHistoryLogService(db);

    syncEngine = SyncEngine(
      syncState: syncStateService,
      db: db,
      offlineQueue: offlineQueue,
      syncHistoryLog: syncLogService,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('SyncEngine Unit & Integration Tests', () {
    final now = DateTime(2026, 8, 6, 15, 0);

    const snapshotInitial = VehicleSnapshot(
      batteryPercent: 90,
      batteryVoltage: 72.0,
      batteryCurrent: 0.0,
      batteryTemp: 30,
      motorTemp: 32,
      speed: 0.0,
      tripDistance: 0.0,
      odometer: 1000.0,
      rideMode: 'Eco',
      range: 120.0,
      power: 0.0,
    );

    test('performSync returns nothingToSync when no gaps and no pending data', () async {
      await syncStateService.saveSyncState(odometer: 1000.0, batteryPercent: 90);

      final result = await syncEngine.performSync(
        currentSnapshot: snapshotInitial,
        connectedAt: now,
      );

      expect(result, equals(const SyncResult.nothingToSync()));
    });

    test('performSync detects odometer gap and returns missedRidesDetected', () async {
      await syncStateService.saveSyncState(odometer: 1000.0, batteryPercent: 90);

      final snapshotWithGap = snapshotInitial.copyWith(odometer: 1015.0);

      final result = await syncEngine.performSync(
        currentSnapshot: snapshotWithGap,
        connectedAt: now,
      );

      result.maybeWhen(
        missedRidesDetected: (candidates) {
          expect(candidates.length, equals(1));
          expect(candidates.first.odometerDeltaKm, equals(15.0));
        },
        orElse: () => fail('Expected missedRidesDetected but got $result'),
      );
    });

    test('performSync auto-accepts high confidence candidates', () async {
      await syncStateService.saveSyncState(odometer: 1000.0, batteryPercent: 90);

      final snapshotWithGap = snapshotInitial.copyWith(odometer: 1010.0);

      final result = await syncEngine.performSync(
        currentSnapshot: snapshotWithGap,
        connectedAt: now,
      );

      expect(result, isA<SyncResult>());
    });

    test('performSync detects duplicate and returns conflict', () async {
      final syncStateBefore = DateTime.now();
      await syncStateService.saveSyncState(odometer: 1000.0, batteryPercent: 90);

      final existingRide = Ride(
        id: 'dup_ride_1',
        date: syncStateBefore,
        startOdometer: 1000.0,
        endOdometer: 1010.0,
        batteryBefore: 90,
        batteryAfter: 80,
        rideMode: RideMode.normal,
        roadCondition: RoadCondition.smooth,
        startTime: syncStateBefore,
        endTime: syncStateBefore.add(const Duration(minutes: 20)),
        durationMinutes: 20,
      );
      await db.into(db.ridesTable).insert(existingRide.toCompanion());

      final snapshotWithGap = snapshotInitial.copyWith(odometer: 1010.0);

      final result = await syncEngine.performSync(
        currentSnapshot: snapshotWithGap,
        connectedAt: syncStateBefore.add(const Duration(minutes: 20)),
      );

      result.maybeWhen(
        conflictsDetected: (conflicts) {
          expect(conflicts.length, equals(1));
          expect(conflicts.first.existingRide.id, equals('dup_ride_1'));
        },
        orElse: () => fail('Expected conflictsDetected but got $result'),
      );
    });

    test('performSync processes offline queue on connect', () async {
      await syncStateService.saveSyncState(odometer: 1000.0, batteryPercent: 90);

      final offlineRide = Ride(
        id: 'offline_queue_ride',
        date: now.subtract(const Duration(hours: 2)),
        startOdometer: 2000.0,
        endOdometer: 2010.0,
        batteryBefore: 100,
        batteryAfter: 90,
        rideMode: RideMode.eco,
        roadCondition: RoadCondition.smooth,
      );
      await offlineQueue.addPendingRide(offlineRide);

      final result = await syncEngine.performSync(
        currentSnapshot: snapshotInitial,
        connectedAt: now,
      );

      result.maybeWhen(
        syncedSuccessfully: (ridesAdded, chargesAdded) {
          expect(ridesAdded, equals(1));
        },
        orElse: () => fail('Expected syncedSuccessfully but got $result'),
      );

      final pendingAfter = await offlineQueue.getPendingRides();
      expect(pendingAfter, isEmpty);
    });
  });
}
