// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'efficiency_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(efficiencyStats)
final efficiencyStatsProvider = EfficiencyStatsProvider._();

final class EfficiencyStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EfficiencyStats>,
          EfficiencyStats,
          FutureOr<EfficiencyStats>
        >
    with $FutureModifier<EfficiencyStats>, $FutureProvider<EfficiencyStats> {
  EfficiencyStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'efficiencyStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$efficiencyStatsHash();

  @$internal
  @override
  $FutureProviderElement<EfficiencyStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EfficiencyStats> create(Ref ref) {
    return efficiencyStats(ref);
  }
}

String _$efficiencyStatsHash() => r'230d609cb67e1ced6cebb1ea0d539be883c49b2c';
