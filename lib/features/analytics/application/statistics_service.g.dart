// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(statisticsService)
final statisticsServiceProvider = StatisticsServiceProvider._();

final class StatisticsServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<StatisticsData>,
          StatisticsData,
          FutureOr<StatisticsData>
        >
    with $FutureModifier<StatisticsData>, $FutureProvider<StatisticsData> {
  StatisticsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsServiceHash();

  @$internal
  @override
  $FutureProviderElement<StatisticsData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StatisticsData> create(Ref ref) {
    return statisticsService(ref);
  }
}

String _$statisticsServiceHash() => r'80fad61f67707fc7ae233ded077b94d9585e88bd';
