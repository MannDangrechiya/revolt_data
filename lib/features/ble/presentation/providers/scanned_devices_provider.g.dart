// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_devices_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier managing scanned RV400 BLE devices.

@ProviderFor(ScannedDevices)
final scannedDevicesProvider = ScannedDevicesProvider._();

/// Notifier managing scanned RV400 BLE devices.
final class ScannedDevicesProvider
    extends $AsyncNotifierProvider<ScannedDevices, List<BleDeviceInfo>> {
  /// Notifier managing scanned RV400 BLE devices.
  ScannedDevicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scannedDevicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scannedDevicesHash();

  @$internal
  @override
  ScannedDevices create() => ScannedDevices();
}

String _$scannedDevicesHash() => r'a6ab0fd8df3f29c38698f822dc288494df318e13';

/// Notifier managing scanned RV400 BLE devices.

abstract class _$ScannedDevices extends $AsyncNotifier<List<BleDeviceInfo>> {
  FutureOr<List<BleDeviceInfo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BleDeviceInfo>>, List<BleDeviceInfo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BleDeviceInfo>>, List<BleDeviceInfo>>,
              AsyncValue<List<BleDeviceInfo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
