// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'range_prediction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rangePrediction)
final rangePredictionProvider = RangePredictionProvider._();

final class RangePredictionProvider
    extends
        $FunctionalProvider<
          AsyncValue<RangePrediction>,
          RangePrediction,
          FutureOr<RangePrediction>
        >
    with $FutureModifier<RangePrediction>, $FutureProvider<RangePrediction> {
  RangePredictionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rangePredictionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rangePredictionHash();

  @$internal
  @override
  $FutureProviderElement<RangePrediction> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RangePrediction> create(Ref ref) {
    return rangePrediction(ref);
  }
}

String _$rangePredictionHash() => r'ec83579bd46a7df436d2611dec168d3f655ed771';
