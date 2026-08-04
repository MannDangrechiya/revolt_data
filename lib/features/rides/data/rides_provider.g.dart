// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rides_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideFilterState)
final rideFilterStateProvider = RideFilterStateProvider._();

final class RideFilterStateProvider
    extends $NotifierProvider<RideFilterState, RideFilter> {
  RideFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideFilterStateHash();

  @$internal
  @override
  RideFilterState create() => RideFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideFilter>(value),
    );
  }
}

String _$rideFilterStateHash() => r'094c61b0ace419243d66f129bf201a32f8f25c66';

abstract class _$RideFilterState extends $Notifier<RideFilter> {
  RideFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RideFilter, RideFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RideFilter, RideFilter>,
              RideFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Rides)
final ridesProvider = RidesProvider._();

final class RidesProvider extends $StreamNotifierProvider<Rides, List<Ride>> {
  RidesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ridesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ridesHash();

  @$internal
  @override
  Rides create() => Rides();
}

String _$ridesHash() => r'59a73d4b2f946271eae156e7ef32be63c48ad436';

abstract class _$Rides extends $StreamNotifier<List<Ride>> {
  Stream<List<Ride>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Ride>>, List<Ride>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Ride>>, List<Ride>>,
              AsyncValue<List<Ride>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredRides)
final filteredRidesProvider = FilteredRidesProvider._();

final class FilteredRidesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ride>>,
          List<Ride>,
          FutureOr<List<Ride>>
        >
    with $FutureModifier<List<Ride>>, $FutureProvider<List<Ride>> {
  FilteredRidesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredRidesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredRidesHash();

  @$internal
  @override
  $FutureProviderElement<List<Ride>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Ride>> create(Ref ref) {
    return filteredRides(ref);
  }
}

String _$filteredRidesHash() => r'b73ce5279305b1c4eb48853dea9e7eb3cfa8ac1d';

@ProviderFor(rideById)
final rideByIdProvider = RideByIdFamily._();

final class RideByIdProvider
    extends $FunctionalProvider<AsyncValue<Ride?>, Ride?, FutureOr<Ride?>>
    with $FutureModifier<Ride?>, $FutureProvider<Ride?> {
  RideByIdProvider._({
    required RideByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'rideByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rideByIdHash();

  @override
  String toString() {
    return r'rideByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Ride?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Ride?> create(Ref ref) {
    final argument = this.argument as String;
    return rideById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RideByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rideByIdHash() => r'7c43ff616062e8ebec41db8867e3fb27907a8d4f';

final class RideByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Ride?>, String> {
  RideByIdFamily._()
    : super(
        retry: null,
        name: r'rideByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RideByIdProvider call(String id) =>
      RideByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'rideByIdProvider';
}
