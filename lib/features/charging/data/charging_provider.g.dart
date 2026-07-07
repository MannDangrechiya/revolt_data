// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChargeFilterState)
final chargeFilterStateProvider = ChargeFilterStateProvider._();

final class ChargeFilterStateProvider
    extends $NotifierProvider<ChargeFilterState, ChargeFilter> {
  ChargeFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chargeFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chargeFilterStateHash();

  @$internal
  @override
  ChargeFilterState create() => ChargeFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChargeFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChargeFilter>(value),
    );
  }
}

String _$chargeFilterStateHash() => r'db8b198813da07c9c78042feea0c2fb33d801b68';

abstract class _$ChargeFilterState extends $Notifier<ChargeFilter> {
  ChargeFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ChargeFilter, ChargeFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChargeFilter, ChargeFilter>,
              ChargeFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ChargingLogs)
final chargingLogsProvider = ChargingLogsProvider._();

final class ChargingLogsProvider
    extends $StreamNotifierProvider<ChargingLogs, List<ChargeLog>> {
  ChargingLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chargingLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chargingLogsHash();

  @$internal
  @override
  ChargingLogs create() => ChargingLogs();
}

String _$chargingLogsHash() => r'aaad73c14046820e6eb0a7bd4995a01255311f6a';

abstract class _$ChargingLogs extends $StreamNotifier<List<ChargeLog>> {
  Stream<List<ChargeLog>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ChargeLog>>, List<ChargeLog>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChargeLog>>, List<ChargeLog>>,
              AsyncValue<List<ChargeLog>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredChargeLogs)
final filteredChargeLogsProvider = FilteredChargeLogsProvider._();

final class FilteredChargeLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChargeLog>>,
          List<ChargeLog>,
          FutureOr<List<ChargeLog>>
        >
    with $FutureModifier<List<ChargeLog>>, $FutureProvider<List<ChargeLog>> {
  FilteredChargeLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredChargeLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredChargeLogsHash();

  @$internal
  @override
  $FutureProviderElement<List<ChargeLog>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ChargeLog>> create(Ref ref) {
    return filteredChargeLogs(ref);
  }
}

String _$filteredChargeLogsHash() =>
    r'79ee6ebbd6706d8e71f6e65df54240496e6869a2';

@ProviderFor(totalChargingCost)
final totalChargingCostProvider = TotalChargingCostProvider._();

final class TotalChargingCostProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  TotalChargingCostProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalChargingCostProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalChargingCostHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return totalChargingCost(ref);
  }
}

String _$totalChargingCostHash() => r'51495fc15f761c1ab538a61d4d7eab20ffcd42bd';

@ProviderFor(chargingLocationDistribution)
final chargingLocationDistributionProvider =
    ChargingLocationDistributionProvider._();

final class ChargingLocationDistributionProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<LocationType, int>>,
          Map<LocationType, int>,
          FutureOr<Map<LocationType, int>>
        >
    with
        $FutureModifier<Map<LocationType, int>>,
        $FutureProvider<Map<LocationType, int>> {
  ChargingLocationDistributionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chargingLocationDistributionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chargingLocationDistributionHash();

  @$internal
  @override
  $FutureProviderElement<Map<LocationType, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<LocationType, int>> create(Ref ref) {
    return chargingLocationDistribution(ref);
  }
}

String _$chargingLocationDistributionHash() =>
    r'd101405f6bd6d8c9e907654dd95f8f875d52c419';

@ProviderFor(averageChargingSpeed)
final averageChargingSpeedProvider = AverageChargingSpeedProvider._();

final class AverageChargingSpeedProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  AverageChargingSpeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'averageChargingSpeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$averageChargingSpeedHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return averageChargingSpeed(ref);
  }
}

String _$averageChargingSpeedHash() =>
    r'754f37ffb4409bba447dfa3211ce590e5e116856';
