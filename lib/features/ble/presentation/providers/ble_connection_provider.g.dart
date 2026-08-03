// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider exposing the single instance of [BleVehicleRepository].

@ProviderFor(bleRepository)
final bleRepositoryProvider = BleRepositoryProvider._();

/// Provider exposing the single instance of [BleVehicleRepository].

final class BleRepositoryProvider
    extends
        $FunctionalProvider<
          BleVehicleRepository,
          BleVehicleRepository,
          BleVehicleRepository
        >
    with $Provider<BleVehicleRepository> {
  /// Provider exposing the single instance of [BleVehicleRepository].
  BleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bleRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bleRepositoryHash();

  @$internal
  @override
  $ProviderElement<BleVehicleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BleVehicleRepository create(Ref ref) {
    return bleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BleVehicleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BleVehicleRepository>(value),
    );
  }
}

String _$bleRepositoryHash() => r'0e4522b73a6c689025bcee82d5ed74b1e1d12315';

/// StreamProvider exposing real-time connection state updates.

@ProviderFor(bleConnectionState)
final bleConnectionStateProvider = BleConnectionStateProvider._();

/// StreamProvider exposing real-time connection state updates.

final class BleConnectionStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<BleConnectionState>,
          BleConnectionState,
          Stream<BleConnectionState>
        >
    with
        $FutureModifier<BleConnectionState>,
        $StreamProvider<BleConnectionState> {
  /// StreamProvider exposing real-time connection state updates.
  BleConnectionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bleConnectionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bleConnectionStateHash();

  @$internal
  @override
  $StreamProviderElement<BleConnectionState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<BleConnectionState> create(Ref ref) {
    return bleConnectionState(ref);
  }
}

String _$bleConnectionStateHash() =>
    r'be44aef4bb2745a56a3f948591fb6276cd8ed0ec';
