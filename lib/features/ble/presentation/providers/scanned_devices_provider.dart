import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/ble_device_info.dart';
import 'ble_connection_provider.dart';

/// StateNotifier to manage scanning state and list of discovered BLE devices.
class ScannedDevicesNotifier extends StateNotifier<AsyncValue<List<BleDeviceInfo>>> {
  final Ref _ref;

  ScannedDevicesNotifier(this._ref) : super(const AsyncValue.data([]));

  Future<void> startScan({Duration timeout = const Duration(seconds: 10)}) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(bleRepositoryProvider);
      final devices = await repo.scan(timeout: timeout);
      state = AsyncValue.data(devices);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

/// Provider for scanned BLE devices.
final scannedDevicesProvider =
    StateNotifierProvider<ScannedDevicesNotifier, AsyncValue<List<BleDeviceInfo>>>(
  (ref) => ScannedDevicesNotifier(ref),
);
