// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$chargingLogsHash() => r'94b9714e9d486adaaca2ab12e2a6c46cd83be461';

abstract class _$ChargingLogs extends $StreamNotifier<List<ChargeLog>> {
  Stream<List<ChargeLog>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ChargeLog>>, List<ChargeLog>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ChargeLog>>, List<ChargeLog>>,
        AsyncValue<List<ChargeLog>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

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

final class ChargingLocationDistributionProvider extends $FunctionalProvider<
        AsyncValue<Map<LocationType, int>>,
        Map<LocationType, int>,
        FutureOr<Map<LocationType, int>>>
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
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

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
