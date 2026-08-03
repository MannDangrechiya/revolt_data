import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/vehicle_snapshot.dart';
import 'ble_connection_provider.dart';

part 'vehicle_snapshot_provider.g.dart';

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
@riverpod
Stream<VehicleSnapshot> vehicleSnapshot(Ref ref) {
  final repository = ref.watch(bleRepositoryProvider);
  return repository.getVehicleSnapshotStream();
}
