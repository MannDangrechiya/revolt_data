import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';
import 'package:revolt_data/features/ble/data/ble_vehicle_repository.dart';
import 'package:revolt_data/features/ble/data/revolt_ble_repository.dart';
import 'package:revolt_data/features/ble/domain/ble_device_info.dart';
import 'package:revolt_data/features/ble/domain/connection_state.dart';
import 'package:revolt_data/features/ble/domain/vehicle_snapshot.dart';
import 'package:revolt_data/features/ble/presentation/providers/ble_connection_provider.dart';
import 'package:revolt_data/features/security/data/anti_theft_guard_provider.dart';

class FakeConnectedBleVehicleRepository implements BleVehicleRepository {
  final List<String> sentCommands = [];

  @override
  BleConnectionState get currentConnectionState => BleConnectionState.connected;

  @override
  Stream<BleConnectionState> get connectionStateStream =>
      Stream.value(BleConnectionState.connected);

  @override
  Future<void> sendCommand(String command) async {
    sentCommands.add(command);
  }

  @override
  Future<void> clearSnapshotCache() async {}

  @override
  Future<void> connect(String deviceId) async {}

  @override
  Future<void> disconnect() async {}

  @override
  Stream<VehicleSnapshot> getVehicleSnapshotStream() => const Stream.empty();

  @override
  VehicleSnapshot? get lastCachedSnapshot => null;

  @override
  Future<bool> pair(String token) async => true;

  @override
  Stream<RawPacket> get rawPacketStream => const Stream.empty();

  @override
  Future<List<BleDeviceInfo>> scan({Duration timeout = const Duration(seconds: 10)}) async => [];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        bleRepositoryProvider.overrideWithValue(RevoltBleRepository()),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('Security & Geofence Extended Feature Tests', () {
    test('Configuring geofence radius updates state properly', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      expect(container.read(antiTheftGuardProvider).geofenceRadiusMeters, 50.0);

      notifier.setGeofenceRadius(250.0);
      expect(container.read(antiTheftGuardProvider).geofenceRadiusMeters, 250.0);

      notifier.setGeofenceRadius(1000.0);
      expect(container.read(antiTheftGuardProvider).geofenceRadiusMeters, 1000.0);
    });

    test('Displacement under custom geofence radius does not trigger alert', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      notifier.setGeofenceRadius(200.0);
      notifier.armGuard(lat: 28.6139, lng: 77.2090);

      // Move by ~110m (lat 28.6149 is ~111m away)
      notifier.checkPositionAndEvaluate(28.6149, 77.2090);

      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.armed);
      expect(state.distanceMovedMeters, lessThan(200.0));
    });

    test('Displacement exceeding custom geofence radius triggers alert', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      notifier.setGeofenceRadius(100.0);
      notifier.armGuard(lat: 28.6139, lng: 77.2090);

      // Move by ~220m (lat 28.6159 is ~222m away)
      notifier.checkPositionAndEvaluate(28.6159, 77.2090);

      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.alertTriggered);
      expect(state.distanceMovedMeters, greaterThan(100.0));
      expect(state.alertMessage, contains('CRITICAL ANTI-THEFT ALERT'));
    });

    test('triggerLocateBike and remoteLockEngine dispatch commands to BLE repository', () async {
      final fakeBle = FakeConnectedBleVehicleRepository();
      final customContainer = ProviderContainer(
        overrides: [
          bleRepositoryProvider.overrideWithValue(fakeBle),
        ],
      );

      final notifier = customContainer.read(antiTheftGuardProvider.notifier);

      final locateResult = await notifier.triggerLocateBike();
      expect(locateResult, isTrue);
      expect(fakeBle.sentCommands, contains('LOCATE#'));

      final lockResult = await notifier.remoteLockEngine();
      expect(lockResult, isTrue);
      expect(fakeBle.sentCommands, contains('LOCK#'));

      customContainer.dispose();
    });
  });
}
