import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/charging/domain/charge_log.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory(setup: (db) {
      db.execute('PRAGMA foreign_keys = ON;');
    }));
  });

  tearDown(() async {
    await database.close();
  });

  group('Drift Stress Testing & Performance Audit', () {
    test('10,000 Ride Inserts - Batch execution and performance benchmark', () async {
      final stopwatch = Stopwatch()..start();
      final baseDate = DateTime(2026, 1, 1);

      await database.batch((batch) {
        for (int i = 0; i < 10000; i++) {
          batch.insert(
            database.ridesTable,
            RidesTableCompanion.insert(
              id: 'stress_ride_$i',
              date: baseDate.add(Duration(minutes: i)),
              startOdometer: 1000.0 + (i * 5.0),
              endOdometer: 1005.0 + (i * 5.0),
              batteryBefore: 90,
              batteryAfter: 75,
              rideMode: RideMode.eco,
              roadCondition: RoadCondition.smooth,
              source: Value(i % 2 == 0 ? 'manual' : 'ble'),
              notes: Value('Stress test ride #$i'),
            ),
          );
        }
      });

      stopwatch.stop();
      final insertMs = stopwatch.elapsedMilliseconds;
      expect(insertMs, lessThan(10000)); // Should insert 10,000 in <10 seconds

      // Verify count
      final rideCountQuery = database.ridesTable.id.count();
      final count = await (database.selectOnly(database.ridesTable)..addColumns([rideCountQuery]))
          .map((row) => row.read(rideCountQuery))
          .getSingle();

      expect(count, equals(10000));

      // Query performance benchmark
      final queryStopwatch = Stopwatch()..start();
      final rides = await (database.select(database.ridesTable)
            ..where((t) => t.source.equals('ble'))
            ..limit(100))
          .get();
      queryStopwatch.stop();

      expect(rides.length, equals(100));
      expect(queryStopwatch.elapsedMilliseconds, lessThan(500));
    });

    test('10,000 Charge Log Inserts - Batch execution and query stability', () async {
      final stopwatch = Stopwatch()..start();
      final baseDate = DateTime(2026, 1, 1);

      await database.batch((batch) {
        for (int i = 0; i < 10000; i++) {
          batch.insert(
            database.chargeLogsTable,
            ChargeLogsTableCompanion.insert(
              id: 'stress_charge_$i',
              date: baseDate.add(Duration(hours: i)),
              durationMinutes: 120.0,
              kwhAdded: 3.2,
              cost: 45.0,
              paymentMethod: PaymentMethod.appWallet,
              locationType: LocationType.home,
              startBattery: 15,
              endBattery: 100,
              source: Value(i % 5 == 0 ? 'ble' : 'manual'),
            ),
          );
        }
      });

      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, lessThan(10000));

      final chargeCountQuery = database.chargeLogsTable.id.count();
      final count = await (database.selectOnly(database.chargeLogsTable)..addColumns([chargeCountQuery]))
          .map((row) => row.read(chargeCountQuery))
          .getSingle();

      expect(count, equals(10000));
    });

    test('Mixed Manual/BLE Entries, Updates, and Bulk Deletes', () async {
      // Insert 500 BLE rides and 500 Manual rides
      await database.batch((batch) {
        for (int i = 0; i < 1000; i++) {
          batch.insert(
            database.ridesTable,
            RidesTableCompanion.insert(
              id: 'mixed_ride_$i',
              date: DateTime.now(),
              startOdometer: 100.0 + i,
              endOdometer: 110.0 + i,
              batteryBefore: 80,
              batteryAfter: 60,
              rideMode: RideMode.normal,
              roadCondition: RoadCondition.average,
              source: Value(i % 2 == 0 ? 'ble' : 'manual'),
            ),
          );
        }
      });

      // Update BLE rides notes
      await (database.update(database.ridesTable)..where((t) => t.source.equals('ble')))
          .write(const RidesTableCompanion(notes: Value('Validated BLE Telemetry')));

      final updatedBleRides = await (database.select(database.ridesTable)
            ..where((t) => t.source.equals('ble')))
          .get();

      expect(updatedBleRides.length, 500);
      expect(updatedBleRides.first.notes, 'Validated BLE Telemetry');

      // Delete manual rides
      final deletedCount = await (database.delete(database.ridesTable)
            ..where((t) => t.source.equals('manual')))
          .go();

      expect(deletedCount, 500);

      final remainingRides = await database.select(database.ridesTable).get();
      expect(remainingRides.length, 500);
    });

    test('Database Schema Version & Table Integrity', () async {
      expect(database.schemaVersion, equals(5));

      final bikeId = await database.into(database.bikesTable).insert(
            const BikesTableCompanion(
              name: Value('Revolt RV400 QA'),
              brand: Value('Revolt'),
              model: Value('RV400'),
              color: Value('Cosmic Black'),
              registrationNumber: Value('MH14XY9999'),
            ),
          );

      expect(bikeId, greaterThan(0));

      final bike = await (database.select(database.bikesTable)
            ..where((t) => t.id.equals(bikeId)))
          .getSingle();

      expect(bike.name, 'Revolt RV400 QA');
      expect(bike.model, 'RV400');
    });
  });
}
