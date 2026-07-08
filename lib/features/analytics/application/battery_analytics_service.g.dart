// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battery_analytics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(batteryAnalytics)
final batteryAnalyticsProvider = BatteryAnalyticsProvider._();

final class BatteryAnalyticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<BatteryAnalytics>,
          BatteryAnalytics,
          FutureOr<BatteryAnalytics>
        >
    with $FutureModifier<BatteryAnalytics>, $FutureProvider<BatteryAnalytics> {
  BatteryAnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'batteryAnalyticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$batteryAnalyticsHash();

  @$internal
  @override
  $FutureProviderElement<BatteryAnalytics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BatteryAnalytics> create(Ref ref) {
    return batteryAnalytics(ref);
  }
}

String _$batteryAnalyticsHash() => r'c5ee032735f91c74715f005ea0b2eaabeddd0c4c';
