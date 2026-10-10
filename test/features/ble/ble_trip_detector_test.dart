import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/native.dart';

import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/core/database/database_provider.dart';
import 'package:revolt_data/features/ble/domain/ble_trip_state.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/ble/presentation/providers/ble_trip_provider.dart';
import 'package:revolt_data/features/rides/data/rides_provider.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );
    // Keep autoDispose ridesProvider alive during test
    container.listen(ridesProvider, (_, _) {});
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('Trip Detector: Initial state is idle', () {
    final state = container.read(bleTripProvider);
    expect(state.status, BleTripStatus.idle);
    expect(state.distance, 0.0);
  });

  test('Trip Detector: Starts trip on speed > 0 and odometer > 0', () {
    final notifier = container.read(bleTripProvider.notifier);

    const snapshot = VehicleSnapshot(
      batteryPercent: 90,
      batteryVoltage: 72.0,
      batteryCurrent: 10.0,
      batteryTemp: 30,
      motorTemp: 35,
      speed: 35.0,
      tripDistance: 5.0,
      odometer: 100.0,
      rideMode: 'Normal',
      range: 120.0,
      power: 0.72,
    );

    notifier.manualStartTrip(snapshot);

    final state = container.read(bleTripProvider);
    expect(state.status, BleTripStatus.riding);
    expect(state.startOdometer, 100.0);
    expect(state.startBattery, 90);
  });

  test('Trip Detector: Finalizes trip and auto-inserts Ride with source = "ble"', () async {
    final notifier = container.read(bleTripProvider.notifier);

    // 1. Start trip at 100.0 km
    const startSnapshot = VehicleSnapshot(
      batteryPercent: 95,
      batteryVoltage: 72.0,
      batteryCurrent: 10.0,
      batteryTemp: 30,
      motorTemp: 35,
      speed: 40.0,
      tripDistance: 0.0,
      odometer: 100.0,
      rideMode: 'Sport',
      range: 140.0,
      power: 0.72,
    );
    notifier.manualStartTrip(startSnapshot);

    // 2. Simulate progression to 105.5 km
    const endSnapshot = VehicleSnapshot(
      batteryPercent: 85,
      batteryVoltage: 70.0,
      batteryCurrent: 0.0,
      batteryTemp: 32,
      motorTemp: 38,
      speed: 0.0,
      tripDistance: 5.5,
      odometer: 105.5,
      rideMode: 'Sport',
      range: 130.0,
      power: 0.0,
    );
    notifier.processSnapshot(endSnapshot); // Update snapshot progression

    // 3. Force stop trip
    await notifier.manualStopTrip();

    final state = container.read(bleTripProvider);
    expect(state.status, BleTripStatus.stopped);
    expect(state.lastSavedRide, isNotNull);
    expect(state.lastSavedRide!.source, 'ble');
    expect(state.lastSavedRide!.distance, 5.5);

    // 4. Verify insertion into database
    final dbRides = await db.select(db.ridesTable).get();
    expect(dbRides.length, 1);
    expect(dbRides.first.source, 'ble');
    expect(dbRides.first.startOdometer, 100.0);
    expect(dbRides.first.endOdometer, 105.5);
  });

  test('Trip Detector: Ignores short trips < 0.1 km', () async {
    final notifier = container.read(bleTripProvider.notifier);

    const startSnapshot = VehicleSnapshot(
      batteryPercent: 95,
      batteryVoltage: 72.0,
      batteryCurrent: 5.0,
      batteryTemp: 30,
      motorTemp: 35,
      speed: 10.0,
      tripDistance: 0.0,
      odometer: 100.0,
      rideMode: 'Eco',
      range: 140.0,
      power: 0.36,
    );
    notifier.manualStartTrip(startSnapshot);

    // Stop at 100.05 km (distance = 0.05 km < 0.1 km)
    await notifier.manualStopTrip();

    final state = container.read(bleTripProvider);
    expect(state.status, BleTripStatus.idle);
    expect(state.lastSavedRide, isNull);

    final dbRides = await db.select(db.ridesTable).get();
    expect(dbRides.isEmpty, isTrue);
  });

  test('Trip Detector: Suppresses duplicate BLE rides within 2 minutes', () async {
    final notifier = container.read(bleTripProvider.notifier);

    final startTime = DateTime.now();

    // Insert pre-existing BLE ride
    final existingRide = Ride(
      id: 'existing-1',
      date: startTime,
      startOdometer: 100.0,
      endOdometer: 108.0,
      batteryBefore: 90,
      batteryAfter: 80,
      rideMode: RideMode.normal,
      roadCondition: RoadCondition.smooth,
      source: 'ble',
    );
    await container.read(ridesProvider.notifier).addRide(existingRide, source: 'ble');

    // Attempt to complete a new BLE trip at the exact same start time/odometer
    const startSnapshot = VehicleSnapshot(
      batteryPercent: 90,
      batteryVoltage: 72.0,
      batteryCurrent: 10.0,
      batteryTemp: 30,
      motorTemp: 35,
      speed: 30.0,
      tripDistance: 0.0,
      odometer: 100.0,
      rideMode: 'Normal',
      range: 120.0,
      power: 0.72,
    );
    notifier.manualStartTrip(startSnapshot);
    await notifier.manualStopTrip();

    // Verify only the 1 existing ride remains in DB
    final dbRides = await db.select(db.ridesTable).get();
    expect(dbRides.length, 1);
  });
}
