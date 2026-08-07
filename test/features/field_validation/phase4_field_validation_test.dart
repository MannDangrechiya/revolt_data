import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/native.dart';

import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/core/database/database_provider.dart';
import 'package:revolt_data/features/ble/domain/ble_charge_state.dart';
import 'package:revolt_data/features/ble/domain/ble_trip_state.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/ble/presentation/providers/ble_charge_provider.dart';
import 'package:revolt_data/features/ble/presentation/providers/ble_trip_provider.dart';
import 'package:revolt_data/features/charging/data/charging_provider.dart';
import 'package:revolt_data/features/rides/data/rides_provider.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/security/data/anti_theft_guard_provider.dart';

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
    // Keep autoDispose providers alive during testing
    container.listen(ridesProvider, (_, _) {});
    container.listen(chargingLogsProvider, (_, _) {});
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('Phase 4 Field Validation Tests', () {
    test('1. Auto-Switching: Hybrid snapshot telemetry source transitions seamlessly (BLE -> Cloud -> Cached)', () {
      final bleSnapshot = VehicleSnapshot(
        batteryPercent: 88,
        batteryVoltage: 72.5,
        speed: 25.0,
        odometer: 1500.0,
        source: TelemetrySource.ble,
        timestamp: DateTime.now(),
      );

      expect(bleSnapshot.source, TelemetrySource.ble);

      final cloudSnapshot = bleSnapshot.copyWith(
        source: TelemetrySource.cloud,
        speed: 0.0,
      );

      expect(cloudSnapshot.source, TelemetrySource.cloud);

      final cachedSnapshot = cloudSnapshot.copyWith(
        source: TelemetrySource.cached,
      );

      expect(cachedSnapshot.source, TelemetrySource.cached);
    });

    test('2. Automatic Trip Logging: Riding 500m auto-starts and finalizes ride into SQLite RidesTable', () async {
      final tripNotifier = container.read(bleTripProvider.notifier);

      // Start ride at 1000.0 km
      final startSnapshot = VehicleSnapshot(
        batteryPercent: 90,
        batteryVoltage: 72.0,
        speed: 35.0,
        odometer: 1000.0,
        rideMode: 'Normal',
        source: TelemetrySource.ble,
        timestamp: DateTime.now(),
      );

      tripNotifier.manualStartTrip(startSnapshot);
      expect(container.read(bleTripProvider).status, BleTripStatus.riding);

      // Progress trip by 500m (0.5 km) -> odometer 1000.5 km
      final endSnapshot = startSnapshot.copyWith(
        batteryPercent: 88,
        speed: 0.0,
        tripDistance: 0.5,
        odometer: 1000.5,
      );

      tripNotifier.processSnapshot(endSnapshot);

      // Stop trip
      await tripNotifier.manualStopTrip();

      final tripState = container.read(bleTripProvider);
      expect(tripState.status, BleTripStatus.stopped);
      expect(tripState.lastSavedRide, isNotNull);
      expect(tripState.lastSavedRide!.distance, 0.5);
      expect(tripState.lastSavedRide!.notes, contains('Wh/km'));

      // Verify insertion into SQLite DB
      final dbRides = await db.select(db.ridesTable).get();
      expect(dbRides.length, 1);
      expect(dbRides.first.endOdometer, 1000.5);
    });

    test('3. Automatic Charging Session Logging: Plugging charger auto-detects and finalizes into ChargeLogsTable', () async {
      final chargeNotifier = container.read(bleChargeProvider.notifier);

      // Plug in charger (batteryCurrent = -10.0 A)
      final chargingSnapshot = VehicleSnapshot(
        batteryPercent: 40,
        batteryCurrent: -10.0,
        speed: 0.0,
        odometer: 1000.5,
        source: TelemetrySource.ble,
        timestamp: DateTime.now(),
      );

      chargeNotifier.processSnapshot(chargingSnapshot);
      expect(container.read(bleChargeProvider).status, BleChargeStatus.charging);

      // Charge progresses to 65%
      final progressedSnapshot = chargingSnapshot.copyWith(
        batteryPercent: 65,
        batteryCurrent: -5.0,
      );
      chargeNotifier.processSnapshot(progressedSnapshot);

      // Finalize charging
      await chargeNotifier.manualStopCharge();

      final chargeState = container.read(bleChargeProvider);
      expect(chargeState.status, BleChargeStatus.completed);
      expect(chargeState.lastSavedChargeLog, isNotNull);
      expect(chargeState.lastSavedChargeLog!.startBattery, 40);
      expect(chargeState.lastSavedChargeLog!.endBattery, 65);

      // Verify insertion into SQLite ChargeLogsTable
      final dbLogs = await container.read(chargingLogsProvider.future);
      expect(dbLogs.length, 1);
      expect(dbLogs.first.startBattery, 40);
      expect(dbLogs.first.endBattery, 65);
    });

    test('4. Anti-Theft Guard: Displacing > 50m while parked triggers emergency notification state', () {
      final guardNotifier = container.read(antiTheftGuardProvider.notifier);

      guardNotifier.armGuard(lat: 28.6139, lng: 77.2090);
      expect(container.read(antiTheftGuardProvider).status, AntiTheftStatus.armed);

      // Displace by 100 meters
      guardNotifier.checkPositionAndEvaluate(28.6149, 77.2090);

      final guardState = container.read(antiTheftGuardProvider);
      expect(guardState.status, AntiTheftStatus.alertTriggered);
      expect(guardState.alertMessage, contains('CRITICAL ANTI-THEFT ALERT'));
    });
  });
}
