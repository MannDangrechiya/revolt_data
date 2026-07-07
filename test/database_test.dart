import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('Database can insert and retrieve a Ride', () async {
    final now = DateTime.now();
    
    // Insert
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

    // Retrieve
    final rides = await database.select(database.ridesTable).get();
    
    expect(rides.length, 1);
    expect(rides.first.id, 'test_ride_1');
    expect(rides.first.startOdometer, 100.0);
    expect(rides.first.rideMode, RideMode.eco);
  });
}
