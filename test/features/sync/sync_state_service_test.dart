import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revolt_data/features/sync/data/sync_state_service.dart';
import 'package:revolt_data/features/sync/domain/sync_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SyncState Model Tests', () {
    test('isFirstConnectOfDay returns true for yesterday timestamp', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final state = SyncState(
        lastSyncedOdometer: 1250.5,
        lastSyncedAt: yesterday,
        lastKnownBatteryPercent: 85,
      );

      expect(state.isFirstConnectOfDay, isTrue);
    });

    test('isFirstConnectOfDay returns false for today timestamp', () {
      final now = DateTime.now();
      final state = SyncState(
        lastSyncedOdometer: 1250.5,
        lastSyncedAt: now,
        lastKnownBatteryPercent: 85,
      );

      expect(state.isFirstConnectOfDay, isFalse);
    });
  });

  group('SyncStateService Integration Tests', () {
    late SyncStateService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      service = SyncStateService(prefs);
    });

    test('getLastSyncState returns null when empty', () async {
      final state = await service.getLastSyncState();
      expect(state, isNull);
    });

    test('isFirstConnectToday returns true when no state exists', () async {
      final isFirst = await service.isFirstConnectToday();
      expect(isFirst, isTrue);
    });

    test('saveSyncState persists data accurately', () async {
      await service.saveSyncState(odometer: 1450.0, batteryPercent: 90);

      final state = await service.getLastSyncState();
      expect(state, isNotNull);
      expect(state!.lastSyncedOdometer, equals(1450.0));
      expect(state.lastKnownBatteryPercent, equals(90));
      expect(
        DateTime.now().difference(state.lastSyncedAt).inSeconds,
        lessThan(5),
      );
    });

    test('isFirstConnectToday returns false right after saveSyncState', () async {
      await service.saveSyncState(odometer: 1450.0, batteryPercent: 90);

      final isFirst = await service.isFirstConnectToday();
      expect(isFirst, isFalse);
    });

    test('clearSyncState removes all stored values', () async {
      await service.saveSyncState(odometer: 1450.0, batteryPercent: 90);
      expect(await service.getLastSyncState(), isNotNull);

      await service.clearSyncState();

      expect(await service.getLastSyncState(), isNull);
      expect(await service.isFirstConnectToday(), isTrue);
    });
  });
}
