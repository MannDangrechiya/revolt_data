import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/native.dart';

import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/core/database/database_provider.dart';
import 'package:revolt_data/features/ble/domain/ble_charge_state.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/ble/presentation/providers/ble_charge_provider.dart';
import 'package:revolt_data/features/charging/data/charging_provider.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );
    // Keep autoDispose chargingLogsProvider alive during test
    container.listen(chargingLogsProvider, (_, _) {});
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  VehicleSnapshot createSnapshot({
    int battery = 50,
    double speed = 0.0,
    int batteryTemp = 30,
    double power = 2.5,
  }) {
    return VehicleSnapshot(
      speed: speed,
      odometer: 1000.0,
      batteryPercent: battery,
      range: 75.0,
      batteryTemp: batteryTemp,
      motorTemp: 35,
      power: power,
      batteryCurrent: 10.0,
      batteryVoltage: 72.0,
      rideMode: 'ECO',
      tripDistance: 10.0,
      timestamp: DateTime.now(),
    );
  }

  group('BleChargeNotifier Unit Tests', () {
    test('Initial state is idle', () {
      final state = container.read(bleChargeProvider);
      expect(state.status, BleChargeStatus.idle);
      expect(state.batteryGained, 0);
      expect(state.kwhAdded, 0.0);
    });

    test('Detects charge start on speed = 0 and battery increase', () async {
      final notifier = container.read(bleChargeProvider.notifier);

      // Baseline snapshot
      notifier.processSnapshot(createSnapshot(battery: 50, speed: 0.0));
      expect(container.read(bleChargeProvider).status, BleChargeStatus.idle);

      // Battery begins increasing -> triggers charge start
      notifier.processSnapshot(createSnapshot(battery: 52, speed: 0.0));

      final state = container.read(bleChargeProvider);
      expect(state.status, BleChargeStatus.charging);
      expect(state.startBattery, 52);
      expect(state.currentBattery, 52);
    });

    test('Tracks live metrics during active charging', () async {
      final notifier = container.read(bleChargeProvider.notifier);

      // Start charge session
      notifier.processSnapshot(createSnapshot(battery: 50, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 52, speed: 0.0));

      // Charge progresses to 70%
      notifier.processSnapshot(createSnapshot(battery: 70, speed: 0.0, batteryTemp: 42));

      final state = container.read(bleChargeProvider);
      expect(state.status, BleChargeStatus.charging);
      expect(state.batteryGained, 18); // 70 - 52
      expect(state.kwhAdded, closeTo(3.24 * (18 / 100.0), 0.01)); // ~0.58 kWh
      expect(state.peakBatteryTemp, 42);
    });

    test('Finalizes charge and auto-inserts ChargeLog with source = "ble"', () async {
      final notifier = container.read(bleChargeProvider.notifier);

      // Start and progress charge
      notifier.processSnapshot(createSnapshot(battery: 40, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 45, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 80, speed: 0.0));

      // Force finalize charge session
      await notifier.manualStopCharge();

      final state = container.read(bleChargeProvider);
      expect(state.status, BleChargeStatus.completed);
      expect(state.lastSavedChargeLog, isNotNull);
      expect(state.lastSavedChargeLog!.source, 'ble');
      expect(state.lastSavedChargeLog!.startBattery, 45);
      expect(state.lastSavedChargeLog!.endBattery, 80);

      // Verify ChargeLog exists in database
      final logs = await container.read(chargingLogsProvider.future);
      expect(logs.length, 1);
      expect(logs.first.source, 'ble');
      expect(logs.first.startBattery, 45);
      expect(logs.first.endBattery, 80);
    });

    test('Ignores charge sessions with battery gain < 2%', () async {
      final notifier = container.read(bleChargeProvider.notifier);

      // Start charge
      notifier.processSnapshot(createSnapshot(battery: 50, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 51, speed: 0.0)); // 1% gain

      await notifier.manualStopCharge();

      final state = container.read(bleChargeProvider);
      expect(state.status, BleChargeStatus.idle);
      expect(state.lastSavedChargeLog, isNull);

      final logs = await container.read(chargingLogsProvider.future);
      expect(logs.isEmpty, isTrue);
    });

    test('Suppresses duplicate BLE charge logs within 5 minutes', () async {
      final notifier = container.read(bleChargeProvider.notifier);

      // Session 1
      notifier.processSnapshot(createSnapshot(battery: 30, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 35, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 70, speed: 0.0));
      await notifier.manualStopCharge();

      var logs = await container.read(chargingLogsProvider.future);
      expect(logs.length, 1);

      // Attempt Session 2 immediately with same parameters (duplicate)
      notifier.processSnapshot(createSnapshot(battery: 35, speed: 0.0));
      notifier.processSnapshot(createSnapshot(battery: 70, speed: 0.0));
      await notifier.manualStopCharge();

      logs = await container.read(chargingLogsProvider.future);
      expect(logs.length, 1); // No new log added
    });
  });
}
