import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../shared/ui/volt_app_bar.dart';
import '../../ble/presentation/providers/ble_connection_provider.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../ble/presentation/widgets/connection_status_badge.dart';
import '../../remote/data/revolt_remote_repository_provider.dart';

/// Zero-Login Device & Telematics Hub for Revolt RV400
class DeviceHubScreen extends ConsumerStatefulWidget {
  const DeviceHubScreen({super.key});

  @override
  ConsumerState<DeviceHubScreen> createState() => _DeviceHubScreenState();
}

class _DeviceHubScreenState extends ConsumerState<DeviceHubScreen> {
  final TextEditingController _vinController = TextEditingController();
  final TextEditingController _customUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final remoteRepo = ref.read(revoltRemoteRepositoryProvider);
    _vinController.text = remoteRepo.configuredVehicleId ?? 'RV400-MH12-9988';
    _customUrlController.text = remoteRepo.customTelematicsUrl ?? '';
  }

  @override
  void dispose() {
    _vinController.dispose();
    _customUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remoteRepo = ref.watch(revoltRemoteRepositoryProvider);
    final bleState = ref.watch(bleConnectionStateProvider).value;
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);

    final snapshot = liveSnapshot ?? lastSnapshot;
    final isDemoMode = remoteRepo.isDemoModeEnabled;

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Device & Telematics Hub',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            tooltip: 'Sync Telematics',
            onPressed: () async {
              HapticFeedback.lightImpact();
              await ref.read(telemetryRepositoryProvider).refreshCloudTelemetry();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Telematics refreshed from active channel.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Connection Status Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Active Data Link',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isDemoMode
                            ? 'Simulated RV400 Feed'
                            : (bleState?.name.toUpperCase() ?? 'DISCONNECTED'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  ConnectionStatusBadge(
                    state: bleState,
                    source: snapshot?.source,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Demo Simulation Mode Switch Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isDemoMode ? Colors.blue : Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                  width: isDemoMode ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: (isDemoMode ? Colors.blue : Colors.grey).withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  LucideIcons.flaskConical,
                                  color: isDemoMode ? Colors.blue : Colors.grey,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Demo Simulation Mode',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Inject simulated live telemetry without bike',
                                      style: TextStyle(fontSize: 11, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Switch(
                          value: isDemoMode,
                          activeTrackColor: Colors.blue,
                          activeThumbColor: Colors.white,
                          onChanged: (val) {
                            HapticFeedback.mediumImpact();
                            remoteRepo.setDemoMode(val);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  val
                                      ? 'Demo mode enabled. Live telematics simulation active!'
                                      : 'Demo mode disabled. Polling hardware telemetry.',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (isDemoMode) ...[
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 10),
                      const Text(
                        'Simulating: 88% Battery | 72.4V | 1420.5 km Odo | Pune GPS Coords | Normal Mode',
                        style: TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Bike Identity & VIN Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Zero-Login Bike Configuration',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Direct telematics queries will target this vehicle identifier without requiring user login.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _vinController,
                      decoration: InputDecoration(
                        labelText: 'Vehicle ID / VIN / Chassis',
                        prefixIcon: const Icon(LucideIcons.fingerprint, size: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onChanged: (val) {
                        remoteRepo.setConfiguredVehicleId(val.trim());
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _customUrlController,
                      decoration: InputDecoration(
                        labelText: 'Custom Telematics API / Webhook URL',
                        hintText: 'https://my-revolt-server.local/api/live',
                        prefixIcon: const Icon(LucideIcons.globe, size: 20),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onChanged: (val) {
                        remoteRepo.setCustomTelematicsUrl(val.trim().isEmpty ? null : val.trim());
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Direct BLE Command Pad
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hardware Command Console',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Send raw control strings directly to the RV400 ECU characteristic.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _sendCommand('START#', 'Ignition Start (START#)'),
                            icon: const Icon(LucideIcons.power, size: 16, color: Colors.green),
                            label: const Text('START'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _sendCommand('STOP#', 'Ignition Stop (STOP#)'),
                            icon: const Icon(LucideIcons.circleStop, size: 16, color: Colors.red),
                            label: const Text('STOP'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _sendCommand('LOCATE#', 'Chirp Hazards (LOCATE#)'),
                            icon: const Icon(LucideIcons.bellRing, size: 16, color: Colors.blue),
                            label: const Text('LOCATE'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _sendCommand('LOCK#', 'ECU Immobilizer (LOCK#)'),
                            icon: const Icon(LucideIcons.lock, size: 16, color: Colors.orange),
                            label: const Text('LOCK'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _sendCommand(String cmd, String label) async {
    HapticFeedback.heavyImpact();
    final bleRepo = ref.read(bleRepositoryProvider);
    try {
      await bleRepo.sendCommand(cmd);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Command dispatched: $label'),
            backgroundColor: Colors.teal.shade800,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Command sent (Channel error: $e)'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
