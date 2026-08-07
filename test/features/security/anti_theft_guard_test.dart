import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_data/features/security/data/anti_theft_guard_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('AntiTheftGuard Unit Tests', () {
    test('Initial state is unarmed', () {
      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.unarmed);
    });

    test('Arming stores parked location coordinates', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      notifier.armGuard(lat: 28.6139, lng: 77.2090);

      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.armed);
      expect(state.parkedLatitude, 28.6139);
      expect(state.parkedLongitude, 77.2090);
    });

    test('Movement under 50m does not trigger alert', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      notifier.armGuard(lat: 28.6139, lng: 77.2090);

      // Move by ~10 meters (lat shift of 0.0001 deg is ~11m)
      notifier.checkPositionAndEvaluate(28.6140, 77.2090);

      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.armed);
      expect(state.distanceMovedMeters, lessThan(50.0));
    });

    test('Movement exceeding 50m triggers AntiTheftStatus.alertTriggered', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      notifier.armGuard(lat: 28.6139, lng: 77.2090);

      // Move by ~110 meters (lat shift of 0.001 deg is ~111m)
      notifier.checkPositionAndEvaluate(28.6150, 77.2090);

      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.alertTriggered);
      expect(state.distanceMovedMeters, greaterThan(50.0));
      expect(state.alertMessage, contains('CRITICAL ANTI-THEFT ALERT'));
    });

    test('Disarming resets guard state', () {
      final notifier = container.read(antiTheftGuardProvider.notifier);
      notifier.armGuard(lat: 28.6139, lng: 77.2090);
      notifier.disarmGuard();

      final state = container.read(antiTheftGuardProvider);
      expect(state.status, AntiTheftStatus.unarmed);
    });
  });
}
