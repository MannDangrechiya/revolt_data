// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_coach_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chargingCoach)
final chargingCoachProvider = ChargingCoachProvider._();

final class ChargingCoachProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChargingCoachTip>,
          ChargingCoachTip,
          FutureOr<ChargingCoachTip>
        >
    with $FutureModifier<ChargingCoachTip>, $FutureProvider<ChargingCoachTip> {
  ChargingCoachProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chargingCoachProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chargingCoachHash();

  @$internal
  @override
  $FutureProviderElement<ChargingCoachTip> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChargingCoachTip> create(Ref ref) {
    return chargingCoach(ref);
  }
}

String _$chargingCoachHash() => r'33e32cefb02b1467d4d8bbc8772c321d9b561b80';
