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

String _$bikeRepositoryHash() => r'5249179bb6c8d6fcdd274b77ea0a3d3908c3410b';

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

@ProviderFor(bikeById)
final bikeByIdProvider = BikeByIdFamily._();

final class BikeByIdProvider
    extends $FunctionalProvider<AsyncValue<Bike?>, Bike?, FutureOr<Bike?>>
    with $FutureModifier<Bike?>, $FutureProvider<Bike?> {
  BikeByIdProvider._({
    required BikeByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'bikeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bikeByIdHash();

  @override
  String toString() {
    return r'bikeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Bike?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Bike?> create(Ref ref) {
    final argument = this.argument as int;
    return bikeById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BikeByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bikeByIdHash() => r'1fe652b13affb98227ee11e995afd269ea5b542b';

final class BikeByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Bike?>, int> {
  BikeByIdFamily._()
    : super(
        retry: null,
        name: r'bikeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BikeByIdProvider call(int id) => BikeByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'bikeByIdProvider';
}
