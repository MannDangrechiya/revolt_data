// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battery_health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(totalChargeCycles)
final totalChargeCyclesProvider = TotalChargeCyclesProvider._();

final class TotalChargeCyclesProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  TotalChargeCyclesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalChargeCyclesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalChargeCyclesHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return totalChargeCycles(ref);
  }
}

String _$totalChargeCyclesHash() => r'82482b25382cb637691b20f5457527bb88d349ce';

@ProviderFor(powerEfficiency)
final powerEfficiencyProvider = PowerEfficiencyProvider._();

final class PowerEfficiencyProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  PowerEfficiencyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'powerEfficiencyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$powerEfficiencyHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return powerEfficiency(ref);
  }
}

String _$powerEfficiencyHash() => r'df961f3c5a50edc3b6aec29461c4f00a7ee5e606';

@ProviderFor(batteryHealthEstimate)
final batteryHealthEstimateProvider = BatteryHealthEstimateProvider._();

final class BatteryHealthEstimateProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  BatteryHealthEstimateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'batteryHealthEstimateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$batteryHealthEstimateHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return batteryHealthEstimate(ref);
  }
}

String _$batteryHealthEstimateHash() =>
    r'432a05a81f8ad42b0dc402b1d3049f55dcf37649';
