// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intelligence_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Health score (0-100): battery degradation rate 40%, days since last
/// service 30%, live fault status 30%.

@ProviderFor(healthScore)
final healthScoreProvider = HealthScoreProvider._();

/// Health score (0-100): battery degradation rate 40%, days since last
/// service 30%, live fault status 30%.

final class HealthScoreProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Health score (0-100): battery degradation rate 40%, days since last
  /// service 30%, live fault status 30%.
  HealthScoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthScoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthScoreHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return healthScore(ref);
  }
}

String _$healthScoreHash() => r'bb7453b4bde705a00c417ccbd3f7d3a4a76debf0';

/// Data-driven maintenance tips. Each rule only fires when there's enough
/// history to support it -- no random/static copy.

@ProviderFor(smartAlerts)
final smartAlertsProvider = SmartAlertsProvider._();

/// Data-driven maintenance tips. Each rule only fires when there's enough
/// history to support it -- no random/static copy.

final class SmartAlertsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Data-driven maintenance tips. Each rule only fires when there's enough
  /// history to support it -- no random/static copy.
  SmartAlertsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smartAlertsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smartAlertsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return smartAlerts(ref);
  }
}

String _$smartAlertsHash() => r'23e46ff1d6f44d42d8f42eafbc77b1599161aae4';
