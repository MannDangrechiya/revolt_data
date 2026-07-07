import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/charging/domain/charge_log.dart';
import 'package:revolt_data/features/expenses/domain/expense.dart';
import 'package:revolt_data/features/maintenance/domain/maintenance_log.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('Database CRUD Operations', () {
    test('Can insert and retrieve a Bike', () async {
      final bikeData = BikesTableCompanion(
        name: const Value('My RV400'),
        brand: const Value('Revolt'),
        model: const Value('RV400'),
        color: const Value('Rebel Red'),
        registrationNumber: const Value('MH12AB1234'),
      );

      final bikeId = await database.into(database.bikesTable).insert(bikeData);
      final bikes = await database.select(database.bikesTable).get();

      expect(bikes.length, 1);
      expect(bikes.first.id, bikeId);
      expect(bikes.first.name, 'My RV400');
    });

    test('Can insert and retrieve a Ride', () async {
      final now = DateTime.now();
      
      final rideData = RidesTableCompanion(
        id: const Value('test_ride_1'),
        date: Value(now),
        startOdometer: const Value(100.0),
        endOdometer: const Value(120.0),
        batteryBefore: const Value(90),
        batteryAfter: const Value(70),
        rideMode: const Value(RideMode.eco),
        roadCondition: const Value(RoadCondition.smooth),
        notes: const Value('Test ride'),
        photoPaths: const Value([]),
      );

      await database.into(database.ridesTable).insert(rideData);

      final rides = await database.select(database.ridesTable).get();
      
      expect(rides.length, 1);
      expect(rides.first.id, 'test_ride_1');
      expect(rides.first.startOdometer, 100.0);
      expect(rides.first.rideMode, RideMode.eco);
    });

    test('Can insert and retrieve a ChargeLog', () async {
      final now = DateTime.now();
      
      final chargeData = ChargeLogsTableCompanion(
        id: const Value('charge_1'),
        date: Value(now),
        durationMinutes: const Value(120.0),
        kwhAdded: const Value(2.5),
        cost: const Value(50.0),
        paymentMethod: const Value(PaymentMethod.appWallet),
        locationType: const Value(LocationType.home),
        startBattery: const Value(20),
        endBattery: const Value(100),
      );

      await database.into(database.chargeLogsTable).insert(chargeData);
      final charges = await database.select(database.chargeLogsTable).get();

      expect(charges.length, 1);
      expect(charges.first.id, 'charge_1');
      expect(charges.first.cost, 50.0);
    });

    test('Can insert and retrieve an Expense', () async {
      final now = DateTime.now();
      
      final expenseData = ExpensesTableCompanion(
        id: const Value('exp_1'),
        date: Value(now),
        category: const Value(ExpenseCategory.insurance),
        amount: const Value(1500.0),
        description: const Value('Annual Premium'),
      );

      await database.into(database.expensesTable).insert(expenseData);
      final expenses = await database.select(database.expensesTable).get();

      expect(expenses.length, 1);
      expect(expenses.first.id, 'exp_1');
      expect(expenses.first.amount, 1500.0);
    });

    test('Cascade delete works (Bike -> Rides)', () async {
      // Create bike
      final bikeId = await database.into(database.bikesTable).insert(
        BikesTableCompanion(
          name: const Value('Test Bike'),
          brand: const Value('Revolt'),
          model: const Value('RV400'),
          color: const Value('Red'),
          registrationNumber: const Value('123'),
        ),
      );

      // Create ride for bike
      await database.into(database.ridesTable).insert(
        RidesTableCompanion(
          id: const Value('ride_1'),
          bikeId: Value(bikeId),
          date: Value(DateTime.now()),
          startOdometer: const Value(0),
          endOdometer: const Value(10),
          batteryBefore: const Value(100),
          batteryAfter: const Value(90),
          rideMode: const Value(RideMode.eco),
          roadCondition: const Value(RoadCondition.smooth),
        ),
      );

      var rides = await database.select(database.ridesTable).get();
      expect(rides.length, 1);

      // Delete bike
      await database.delete(database.bikesTable).delete(BikesTableCompanion(id: Value(bikeId)));

      // Verify ride is deleted via cascade
      rides = await database.select(database.ridesTable).get();
      expect(rides.length, 0); // Requires PRAGMA foreign_keys = ON which is set in beforeOpen
    });
  });
}
