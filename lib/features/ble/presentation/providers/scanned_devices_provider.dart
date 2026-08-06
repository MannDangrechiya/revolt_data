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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(bleRepositoryProvider);
      final devices = await repo.scan(timeout: timeout);
      // Sort by RSSI descending so strongest signal devices appear at top
      devices.sort((a, b) => b.rssi.compareTo(a.rssi));
      return devices;
    });
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}
