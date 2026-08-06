import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/sync/data/offline_queue.dart';

void main() {
  late AppDatabase db;
  late OfflineQueue offlineQueue;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    offlineQueue = OfflineQueue(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('OfflineQueue Unit Tests', () {
    final now = DateTime(2026, 8, 6, 14, 0);
    final sampleRide = Ride(
      id: 'offline_1',
      date: now,
      startOdometer: 50.0,
      endOdometer: 62.0,
      batteryBefore: 90,
      batteryAfter: 78,
      rideMode: RideMode.eco,
      roadCondition: RoadCondition.smooth,
      startTime: now,
      endTime: now.add(const Duration(minutes: 25)),
      durationMinutes: 25,
      source: 'manual',
    );

    test('addPendingRide stores ride in pending table', () async {
      await offlineQueue.addPendingRide(sampleRide);
      final pending = await offlineQueue.getPendingRides();

      expect(pending.length, equals(1));
      expect(pending.first.id, equals('offline_1'));
      expect(pending.first.startOdometer, equals(50.0));
    });

    test('processPendingQueue syncs valid ride and ignores duplicate', () async {
      await offlineQueue.addPendingRide(sampleRide);

      final existingRides = <Ride>[
        Ride(
          id: 'existing_dup',
          date: now,
          startOdometer: 50.1, // overlap within 0.5 km
          endOdometer: 62.1,
          batteryBefore: 90,
          batteryAfter: 78,
          rideMode: RideMode.eco,
          roadCondition: RoadCondition.smooth,
        ),
      ];

      List<Ride> insertedRides = [];
      final syncedCount = await offlineQueue.processPendingQueue(
        existingRides: existingRides,
        insertRide: (ride) async {
          insertedRides.add(ride);
        },
      );

      expect(syncedCount, equals(0)); // Skipped because it's a duplicate
      expect(insertedRides, isEmpty);

      final pendingAfter = await offlineQueue.getPendingRides();
      expect(pendingAfter, isEmpty); // Marked as syncPending = false
    });

    test('processPendingQueue processes non-duplicate offline ride', () async {
      await offlineQueue.addPendingRide(sampleRide);

      List<Ride> insertedRides = [];
      final syncedCount = await offlineQueue.processPendingQueue(
        existingRides: [],
        insertRide: (ride) async {
          insertedRides.add(ride);
        },
      );

      expect(syncedCount, equals(1));
      expect(insertedRides.length, equals(1));
      expect(insertedRides.first.id, equals('offline_1'));
    });
  });
}
