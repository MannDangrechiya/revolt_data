import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/ble_device_info.dart';
import 'ble_connection_provider.dart';

part 'scanned_devices_provider.g.dart';

/// Notifier managing scanned RV400 BLE devices.
@riverpod
class ScannedDevices extends _$ScannedDevices {
  @override
  FutureOr<List<BleDeviceInfo>> build() {
    return [];
  }

  Future<void> startScan({Duration timeout = const Duration(seconds: 10)}) async {
    final repo = ref.read(bleRepositoryProvider); // capture before async gap
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final devices = await repo.scan(timeout: timeout);
      // Sort by RSSI descending so strongest signal devices appear at top
      devices.sort((a, b) => b.rssi.compareTo(a.rssi));
      return devices;
    });
    // The screen may have navigated away (e.g. user tapped Connect) while
    // the scan was still running — don't touch state on a disposed provider.
    if (!ref.mounted) return;
    state = result;
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}
