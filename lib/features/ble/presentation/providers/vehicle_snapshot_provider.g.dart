// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_snapshot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.

@ProviderFor(vehicleSnapshot)
final vehicleSnapshotProvider = VehicleSnapshotProvider._();

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.

final class VehicleSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<VehicleSnapshot>,
          VehicleSnapshot,
          Stream<VehicleSnapshot>
        >
    with $FutureModifier<VehicleSnapshot>, $StreamProvider<VehicleSnapshot> {
  /// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
  VehicleSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleSnapshotHash();

  @$internal
  @override
  $StreamProviderElement<VehicleSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<VehicleSnapshot> create(Ref ref) {
    return vehicleSnapshot(ref);
  }
}

String _$vehicleSnapshotHash() => r'dd918359b1657e19bf4f616f92c1c14c3cad8454';
