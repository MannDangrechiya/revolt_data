// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_debug_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Circular buffer notifier holding up to 100 raw BLE packets.

@ProviderFor(RawPacketLog)
final rawPacketLogProvider = RawPacketLogProvider._();

/// Circular buffer notifier holding up to 100 raw BLE packets.
final class RawPacketLogProvider
    extends $NotifierProvider<RawPacketLog, List<LoggedPacket>> {
  /// Circular buffer notifier holding up to 100 raw BLE packets.
  RawPacketLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rawPacketLogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rawPacketLogHash();

  @$internal
  @override
  RawPacketLog create() => RawPacketLog();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LoggedPacket> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LoggedPacket>>(value),
    );
  }
}

String _$rawPacketLogHash() => r'736fba24b8d168931639f6aff97b5c567d6cbf8c';

/// Circular buffer notifier holding up to 100 raw BLE packets.

abstract class _$RawPacketLog extends $Notifier<List<LoggedPacket>> {
  List<LoggedPacket> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<LoggedPacket>, List<LoggedPacket>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<LoggedPacket>, List<LoggedPacket>>,
              List<LoggedPacket>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Service exposing debug actions for BLE hardware testing.

@ProviderFor(BleDebugActions)
final bleDebugActionsProvider = BleDebugActionsProvider._();

/// Service exposing debug actions for BLE hardware testing.
final class BleDebugActionsProvider
    extends $NotifierProvider<BleDebugActions, void> {
  /// Service exposing debug actions for BLE hardware testing.
  BleDebugActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bleDebugActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bleDebugActionsHash();

  @$internal
  @override
  BleDebugActions create() => BleDebugActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$bleDebugActionsHash() => r'9ab1e95a8f4b5985b7306db9bc9799f00857656e';

/// Service exposing debug actions for BLE hardware testing.

abstract class _$BleDebugActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
