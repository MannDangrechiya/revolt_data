import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/ui/volt_app_bar.dart';
import '../../../../shared/ui/volt_card.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/ev_protocol_provider.dart';
import '../providers/scanned_devices_provider.dart';
import '../widgets/scan_result_tile.dart';

/// Screen allowing users to scan for nearby EV BLE devices and connect across universal EV protocols.
class DeviceScanScreen extends HookConsumerWidget {
  const DeviceScanScreen({super.key});

  Future<void> _checkPermissionsAndScan(WidgetRef ref, BuildContext context) async {
    // Check Bluetooth adapter is ON before requesting permissions
    final adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      // Attempt to turn on Bluetooth (Android only, no-op on iOS)
      try {
        await FlutterBluePlus.turnOn();
      } catch (_) {}
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please turn on Bluetooth to scan for your EV.',
            ),
          ),
        );
      }
      return;
    }

    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    final scanGranted = statuses[Permission.bluetoothScan]?.isGranted ?? true;
    final connectGranted =
        statuses[Permission.bluetoothConnect]?.isGranted ?? true;
    final locationGranted =
        statuses[Permission.locationWhenInUse]?.isGranted ?? true;

    if (scanGranted && connectGranted && locationGranted) {
      await ref.read(scannedDevicesProvider.notifier).startScan();
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Bluetooth and location permissions are required to scan for nearby EVs.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannedDevicesAsync = ref.watch(scannedDevicesProvider);
    final activeProtocol = ref.watch(activeEvProtocolTypeProvider);
    final repo = ref.read(bleRepositoryProvider);
    final bikesOnly = useState(true);

    // Auto-scan on first mount
    final hasScanned = useState(false);
    useEffect(() {
      if (!hasScanned.value) {
        hasScanned.value = true;
        Future.microtask(() {
          if (context.mounted) _checkPermissionsAndScan(ref, context);
        });
      }
      return null;
    }, const []);

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Universal EV Scanner',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            onPressed: () => _checkPermissionsAndScan(ref, context),
            tooltip: 'Rescan',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active EV Protocol Mode Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: EvProtocolType.values.map((proto) {
                  final isSelected = proto == activeProtocol;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      avatar: Icon(
                        isSelected ? LucideIcons.check : LucideIcons.cpu,
                        size: 14,
                      ),
                      label: Text(
                        proto.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          ref.read(activeEvProtocolTypeProvider.notifier).setProtocol(proto);
                          if (proto != EvProtocolType.revoltBle) {
                            bikesOnly.value = false;
                          }
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            VoltCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  const Icon(LucideIcons.radio, color: Colors.blue, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${activeProtocol.brand} • ${activeProtocol.description}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Filter Toggle Row
            Row(
              children: [
                FilterChip(
                  avatar: const Icon(LucideIcons.bike, size: 16),
                  label: Text(activeProtocol == EvProtocolType.revoltBle ? 'RV400 Bikes Only' : '${activeProtocol.brand} Only'),
                  selected: bikesOnly.value,
                  onSelected: (val) => bikesOnly.value = true,
                ),
                const SizedBox(width: 8),
                FilterChip(
                  avatar: const Icon(LucideIcons.bluetooth, size: 16),
                  label: const Text('All BLE Devices'),
                  selected: !bikesOnly.value,
                  onSelected: (val) => bikesOnly.value = false,
                ),
              ],
            ),
            const SizedBox(height: 12),
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
                        onPressed: () => _checkPermissionsAndScan(ref, context),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
                data: (allDevices) {
                  final devices = bikesOnly.value
                      ? allDevices.where((d) => d.isRevoltBike).toList()
                      : allDevices;

                  if (devices.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.bluetoothSearching,
                                size: 48, color: Colors.grey),
                            const SizedBox(height: 12),
                            Text(
                              bikesOnly.value
                                  ? 'No RV400 bikes found nearby'
                                  : 'No Bluetooth devices found nearby',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              bikesOnly.value
                                  ? 'Your bike may broadcast under a generic Bluetooth name (e.g. JL, BK, BLE module) or require GPS Location to be enabled.'
                                  : 'Make sure your bike ignition is ON, Bluetooth & Location Services (GPS) are active, and no other phone is connected to the bike.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: [
                                if (bikesOnly.value && allDevices.isNotEmpty)
                                  ElevatedButton.icon(
                                    onPressed: () => bikesOnly.value = false,
                                    icon: const Icon(LucideIcons.bluetooth),
                                    label: Text('Show All ${allDevices.length} BLE Devices'),
                                  ),
                                ElevatedButton.icon(
                                  onPressed: () => _checkPermissionsAndScan(ref, context),
                                  icon: const Icon(LucideIcons.refreshCw),
                                  label: const Text('Rescan'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: devices.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return ScanResultTile(
                        device: device,
                        onConnect: () async {
                          try {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Connecting to RV400...'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                            await repo.connect(device.id);

                            // The bike disconnects unauthenticated links
                            // quickly (observed as little as ~1s) — too fast
                            // to rely on the user navigating to the pair
                            // screen and typing the token by hand. Fire the
                            // known-good token immediately instead.
                            bool paired = false;
                            try {
                              paired = await repo.pair(AppConstants.knownBlePairingToken);
                            } catch (_) {
                              // connection dropped before the write landed
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              if (paired) {
                                context.go('/device');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Connected & paired to RV400!'),
                                    backgroundColor: Colors.green.shade700,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                context.go('/device/pair?deviceId=${device.id}');
                              }
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
