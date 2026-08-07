// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_snapshot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the single instance of [TelemetryRepository].

@ProviderFor(telemetryRepository)
final telemetryRepositoryProvider = TelemetryRepositoryProvider._();

/// Provider for the single instance of [TelemetryRepository].

final class TelemetryRepositoryProvider
    extends
        $FunctionalProvider<
          TelemetryRepository,
          TelemetryRepository,
          TelemetryRepository
        >
    with $Provider<TelemetryRepository> {
  /// Provider for the single instance of [TelemetryRepository].
  TelemetryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryRepositoryHash();

  @$internal
  @override
  $ProviderElement<TelemetryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelemetryRepository create(Ref ref) {
    return telemetryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryRepository>(value),
    );
  }
}

String _$telemetryRepositoryHash() =>
    r'b368a841e0f14d374362e325ac37c2436989ae7d';

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the hybrid dual-engine stream.

@ProviderFor(vehicleSnapshot)
final vehicleSnapshotProvider = VehicleSnapshotProvider._();

/// StreamProvider exposing live [VehicleSnapshot] telemetry from the hybrid dual-engine stream.

final class VehicleSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<VehicleSnapshot>,
          VehicleSnapshot,
          Stream<VehicleSnapshot>
        >
    with $FutureModifier<VehicleSnapshot>, $StreamProvider<VehicleSnapshot> {
  /// StreamProvider exposing live [VehicleSnapshot] telemetry from the hybrid dual-engine stream.
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

String _$vehicleSnapshotHash() => r'fa8fedb6b7551aac4e32e56ca8d2f90cfe1511cf';

/// Notifier exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.

@ProviderFor(LastKnownVehicleSnapshot)
final lastKnownVehicleSnapshotProvider = LastKnownVehicleSnapshotProvider._();

/// Notifier exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.
final class LastKnownVehicleSnapshotProvider
    extends $NotifierProvider<LastKnownVehicleSnapshot, VehicleSnapshot?> {
  /// Notifier exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.
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
  LastKnownVehicleSnapshot create() => LastKnownVehicleSnapshot();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleSnapshot? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleSnapshot?>(value),
    );
  }
}

String _$lastKnownVehicleSnapshotHash() =>
    r'eed00b3dc17777f128b3eeaa18206ea73f8bfd4c';

/// Notifier exposing the latest available [VehicleSnapshot], combining live stream with cached memory snapshot.

abstract class _$LastKnownVehicleSnapshot extends $Notifier<VehicleSnapshot?> {
  VehicleSnapshot? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<VehicleSnapshot?, VehicleSnapshot?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VehicleSnapshot?, VehicleSnapshot?>,
              VehicleSnapshot?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for the persisted-on-disk snapshot for screens showing last known data,
/// tagged explicitly as [TelemetrySource.cached].

@ProviderFor(PersistedVehicleSnapshot)
final persistedVehicleSnapshotProvider = PersistedVehicleSnapshotProvider._();

/// Notifier for the persisted-on-disk snapshot for screens showing last known data,
/// tagged explicitly as [TelemetrySource.cached].
final class PersistedVehicleSnapshotProvider
    extends $AsyncNotifierProvider<PersistedVehicleSnapshot, VehicleSnapshot?> {
  /// Notifier for the persisted-on-disk snapshot for screens showing last known data,
  /// tagged explicitly as [TelemetrySource.cached].
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
  PersistedVehicleSnapshot create() => PersistedVehicleSnapshot();
}

String _$persistedVehicleSnapshotHash() =>
    r'9522c6a1c348e5aec1b15cc6a6ba636dfab1ce46';

/// Notifier for the persisted-on-disk snapshot for screens showing last known data,
/// tagged explicitly as [TelemetrySource.cached].

abstract class _$PersistedVehicleSnapshot
    extends $AsyncNotifier<VehicleSnapshot?> {
  FutureOr<VehicleSnapshot?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<VehicleSnapshot?>, VehicleSnapshot?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VehicleSnapshot?>, VehicleSnapshot?>,
              AsyncValue<VehicleSnapshot?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
