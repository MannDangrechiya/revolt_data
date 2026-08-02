import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/vehicle_snapshot.dart';
import 'ble_connection_provider.dart';

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
final vehicleSnapshotProvider = StreamProvider<VehicleSnapshot>((ref) {
  final repository = ref.watch(bleRepositoryProvider);
  return repository.getVehicleSnapshotStream();
});
