// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_coach_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideCoach)
final rideCoachProvider = RideCoachProvider._();

final class RideCoachProvider
    extends
        $FunctionalProvider<
          AsyncValue<RideCoachTip>,
          RideCoachTip,
          FutureOr<RideCoachTip>
        >
    with $FutureModifier<RideCoachTip>, $FutureProvider<RideCoachTip> {
  RideCoachProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideCoachProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideCoachHash();

  @$internal
  @override
  $FutureProviderElement<RideCoachTip> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RideCoachTip> create(Ref ref) {
    return rideCoach(ref);
  }
}

String _$rideCoachHash() => r'ddab21ae8c4628699ef368250521bd9fa4b25bed';
