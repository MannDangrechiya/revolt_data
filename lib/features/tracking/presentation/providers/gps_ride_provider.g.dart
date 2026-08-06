// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_ride_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GpsRideNotifier)
final gpsRideProvider = GpsRideNotifierProvider._();

final class GpsRideNotifierProvider
    extends $NotifierProvider<GpsRideNotifier, GpsTrackingState> {
  GpsRideNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gpsRideProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gpsRideNotifierHash();

  @$internal
  @override
  GpsRideNotifier create() => GpsRideNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GpsTrackingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GpsTrackingState>(value),
    );
  }
}

String _$gpsRideNotifierHash() => r'dcc4b3e4769465f0f9b835104d69c4f120bd78d5';

abstract class _$GpsRideNotifier extends $Notifier<GpsTrackingState> {
  GpsTrackingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GpsTrackingState, GpsTrackingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GpsTrackingState, GpsTrackingState>,
              GpsTrackingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
