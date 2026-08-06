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

String _$rangePredictionHash() => r'ed4f585f56a0132dae57b37d0b598d401ae88f71';
