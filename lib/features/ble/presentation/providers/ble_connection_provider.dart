import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/ble_vehicle_repository.dart';
import '../../data/revolt_ble_repository.dart';
import '../../domain/connection_state.dart';

/// Provider for the single instance of [BleVehicleRepository].
final bleRepositoryProvider = Provider<BleVehicleRepository>((ref) {
  final repository = RevoltBleRepository();
  ref.onDispose(() {
    (repository).dispose();
  });
  return repository;
});

/// StreamProvider exposing real-time connection state updates.
final bleConnectionStateProvider = StreamProvider<BleConnectionState>((ref) {
  final repository = ref.watch(bleRepositoryProvider);
  return repository.connectionStateStream;
});
