// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bikeRepository)
final bikeRepositoryProvider = BikeRepositoryProvider._();

final class BikeRepositoryProvider
    extends $FunctionalProvider<BikeRepository, BikeRepository, BikeRepository>
    with $Provider<BikeRepository> {
  BikeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bikeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bikeRepositoryHash();

  @$internal
  @override
  $ProviderElement<BikeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BikeRepository create(Ref ref) {
    return bikeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BikeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BikeRepository>(value),
    );
  }
}

String _$bikeRepositoryHash() => r'5cbaf0898e24723dd701240c726d804704e011ec';

@ProviderFor(CurrentBike)
final currentBikeProvider = CurrentBikeProvider._();

final class CurrentBikeProvider
    extends $AsyncNotifierProvider<CurrentBike, Bike?> {
  CurrentBikeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBikeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBikeHash();

  @$internal
  @override
  CurrentBike create() => CurrentBike();
}

String _$currentBikeHash() => r'3ae98e93d4242e0ddce86250527a3854860ffdf6';

abstract class _$CurrentBike extends $AsyncNotifier<Bike?> {
  FutureOr<Bike?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Bike?>, Bike?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Bike?>, Bike?>,
              AsyncValue<Bike?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
