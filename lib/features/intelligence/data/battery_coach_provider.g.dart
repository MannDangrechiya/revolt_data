// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battery_coach_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(batteryCoach)
final batteryCoachProvider = BatteryCoachProvider._();

final class BatteryCoachProvider
    extends
        $FunctionalProvider<
          AsyncValue<BatteryCoachTip>,
          BatteryCoachTip,
          FutureOr<BatteryCoachTip>
        >
    with $FutureModifier<BatteryCoachTip>, $FutureProvider<BatteryCoachTip> {
  BatteryCoachProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'batteryCoachProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$batteryCoachHash();

  @$internal
  @override
  $FutureProviderElement<BatteryCoachTip> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BatteryCoachTip> create(Ref ref) {
    return batteryCoach(ref);
  }
}

String _$batteryCoachHash() => r'5e318a5a7784d1902a4bae7b7256487fdd5a1fbb';
