import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../shared/ui/volt_app_bar.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/scanned_devices_provider.dart';
import '../widgets/scan_result_tile.dart';

/// Screen allowing users to scan for nearby Revolt RV400 BLE devices and connect.
class DeviceScanScreen extends HookConsumerWidget {
  const DeviceScanScreen({super.key});

  Future<void> _checkPermissionsAndScan(WidgetRef ref) async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    final scanGranted = statuses[Permission.bluetoothScan]?.isGranted ?? true;
    final connectGranted =
        statuses[Permission.bluetoothConnect]?.isGranted ?? true;

    if (scanGranted && connectGranted) {
      await ref.read(scannedDevicesProvider.notifier).startScan();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannedDevicesAsync = ref.watch(scannedDevicesProvider);
    final repo = ref.read(bleRepositoryProvider);

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Scan for RV400',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            onPressed: () => _checkPermissionsAndScan(ref),
            tooltip: 'Rescan',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your Revolt RV400 bike from the list below to connect via Bluetooth Low Energy.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: scannedDevicesAsync.when(
                loading: () => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Scanning for nearby RV400 bikes...'),
                    ],
                  ),
                ),
                error: (err, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LucideIcons.alertCircle,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text('Scan Error: $err'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _checkPermissionsAndScan(ref),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
                data: (devices) {
                  if (devices.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.bluetoothSearching,
                              size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          const Text('No RV400 bikes found nearby'),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => _checkPermissionsAndScan(ref),
                            icon: const Icon(LucideIcons.search),
                            label: const Text('Start Scan'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: devices.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return ScanResultTile(
                        device: device,
                        onConnect: () async {
                          try {
                            await repo.connect(device.id);
                            if (context.mounted) {
                              context.push('/device/pair', extra: device.id);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Connection failed: $e')),
                              );
                            }
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
