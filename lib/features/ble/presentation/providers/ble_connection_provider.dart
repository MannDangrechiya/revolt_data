import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/ble_vehicle_repository.dart';
import '../../data/revolt_ble_repository.dart';
import '../../domain/connection_state.dart';

part 'ble_connection_provider.g.dart';

/// Provider exposing the single instance of [BleVehicleRepository].
@riverpod
BleVehicleRepository bleRepository(Ref ref) {
  final repository = RevoltBleRepository();
  ref.onDispose(() {
    repository.dispose();
  });
  return repository;
}

/// StreamProvider exposing real-time connection state updates.
@riverpod
Stream<BleConnectionState> bleConnectionState(Ref ref) {
  final repository = ref.watch(bleRepositoryProvider);
  return repository.connectionStateStream;
}
