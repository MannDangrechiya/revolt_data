// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_snapshot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
///
/// Every snapshot is persisted to disk (fire-and-forget) so the last-known
/// state survives an app restart, not just an in-memory reconnect — the bike
/// has no channel to push data to us without an active BLE connection, so
/// "last synced at X" from disk is the honest equivalent of the official
/// app's cloud-backed sync.

@ProviderFor(vehicleSnapshot)
final vehicleSnapshotProvider = VehicleSnapshotProvider._();

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
///
/// Every snapshot is persisted to disk (fire-and-forget) so the last-known
/// state survives an app restart, not just an in-memory reconnect — the bike
/// has no channel to push data to us without an active BLE connection, so
/// "last synced at X" from disk is the honest equivalent of the official
/// app's cloud-backed sync.

final class VehicleSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<VehicleSnapshot>,
          VehicleSnapshot,
          Stream<VehicleSnapshot>
        >
    with $FutureModifier<VehicleSnapshot>, $StreamProvider<VehicleSnapshot> {
  /// StreamProvider exposing live [VehicleSnapshot] telemetry from the connected RV400.
  ///
  /// Every snapshot is persisted to disk (fire-and-forget) so the last-known
  /// state survives an app restart, not just an in-memory reconnect — the bike
  /// has no channel to push data to us without an active BLE connection, so
  /// "last synced at X" from disk is the honest equivalent of the official
  /// app's cloud-backed sync.
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

String _$vehicleSnapshotHash() => r'0d1b248914560d4f4a9afb11622c8d88444ae450';

/// Provider exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.

@ProviderFor(lastKnownVehicleSnapshot)
final lastKnownVehicleSnapshotProvider = LastKnownVehicleSnapshotProvider._();

/// Provider exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.

final class LastKnownVehicleSnapshotProvider
    extends
        $FunctionalProvider<
          VehicleSnapshot?,
          VehicleSnapshot?,
          VehicleSnapshot?
        >
    with $Provider<VehicleSnapshot?> {
  /// Provider exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.
  LastKnownVehicleSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastKnownVehicleSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastKnownVehicleSnapshotHash();

  @$internal
  @override
  $ProviderElement<VehicleSnapshot?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VehicleSnapshot? create(Ref ref) {
    return lastKnownVehicleSnapshot(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleSnapshot? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleSnapshot?>(value),
    );
  }
}

String _$lastKnownVehicleSnapshotHash() =>
    r'0b2e7acf001189cf8e0c37b2edbfee5a06dc53d3';

/// The persisted-on-disk snapshot, for screens that want to show "last
/// synced at X" even before any BLE connection this app session (survives
/// app restart — [lastKnownVehicleSnapshotProvider] above does not).

@ProviderFor(persistedVehicleSnapshot)
final persistedVehicleSnapshotProvider = PersistedVehicleSnapshotProvider._();

/// The persisted-on-disk snapshot, for screens that want to show "last
/// synced at X" even before any BLE connection this app session (survives
/// app restart — [lastKnownVehicleSnapshotProvider] above does not).

final class PersistedVehicleSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<VehicleSnapshot?>,
          VehicleSnapshot?,
          FutureOr<VehicleSnapshot?>
        >
    with $FutureModifier<VehicleSnapshot?>, $FutureProvider<VehicleSnapshot?> {
  /// The persisted-on-disk snapshot, for screens that want to show "last
  /// synced at X" even before any BLE connection this app session (survives
  /// app restart — [lastKnownVehicleSnapshotProvider] above does not).
  PersistedVehicleSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistedVehicleSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistedVehicleSnapshotHash();

  @$internal
  @override
  $FutureProviderElement<VehicleSnapshot?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VehicleSnapshot?> create(Ref ref) {
    return persistedVehicleSnapshot(ref);
  }
}

String _$persistedVehicleSnapshotHash() =>
    r'19dcc698da1b30fd621a88dd4a13748b4ca643f5';
