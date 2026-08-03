// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_trip_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BleTripNotifier)
final bleTripProvider = BleTripNotifierProvider._();

final class BleTripNotifierProvider
    extends $NotifierProvider<BleTripNotifier, BleTripState> {
  BleTripNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bleTripProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bleTripNotifierHash();

  @$internal
  @override
  BleTripNotifier create() => BleTripNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BleTripState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BleTripState>(value),
    );
  }
}

String _$bleTripNotifierHash() => r'7620ecb4da8ddda18b5c5f855e9090179a1f0979';

abstract class _$BleTripNotifier extends $Notifier<BleTripState> {
  BleTripState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BleTripState, BleTripState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BleTripState, BleTripState>,
              BleTripState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
