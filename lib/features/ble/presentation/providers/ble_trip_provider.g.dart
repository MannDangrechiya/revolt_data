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
        isAutoDispose: false,
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

String _$bleTripNotifierHash() => r'8b6da69b7de5ff37d50c2ca4e6e79c3da98b29f6';

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
