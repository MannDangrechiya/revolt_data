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

String _$batteryAnalyticsHash() => r'0bbe1b3b0dd8e5f7fd5f0a269d48a61ec60263d3';
