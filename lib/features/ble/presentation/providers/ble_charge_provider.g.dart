// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_charge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BleChargeNotifier)
final bleChargeProvider = BleChargeNotifierProvider._();

final class BleChargeNotifierProvider
    extends $NotifierProvider<BleChargeNotifier, BleChargeState> {
  BleChargeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bleChargeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bleChargeNotifierHash();

  @$internal
  @override
  BleChargeNotifier create() => BleChargeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BleChargeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BleChargeState>(value),
    );
  }
}

String _$bleChargeNotifierHash() => r'd07b34d3f19b3086d70ac96836db7aef3a674e24';

abstract class _$BleChargeNotifier extends $Notifier<BleChargeState> {
  BleChargeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BleChargeState, BleChargeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BleChargeState, BleChargeState>,
              BleChargeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
