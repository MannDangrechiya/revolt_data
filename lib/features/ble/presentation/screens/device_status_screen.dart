import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../shared/ui/volt_app_bar.dart';
import '../../../../shared/ui/volt_card.dart';
import '../../domain/connection_state.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/vehicle_snapshot_provider.dart';
import '../widgets/connection_status_badge.dart';
import '../widgets/live_telemetry_card.dart';

/// Screen rendering detailed BLE device connection status and real-time telemetry.
class DeviceStatusScreen extends HookConsumerWidget {
  const DeviceStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStateAsync = ref.watch(bleConnectionStateProvider);
    final snapshotAsync = ref.watch(vehicleSnapshotProvider);
    final repo = ref.read(bleRepositoryProvider);
    final currentState = repo.currentConnectionState;

    final effectiveState = connectionStateAsync.value ?? currentState;

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Device Status',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bluetooth),
            onPressed: () => context.push('/device/scan'),
            tooltip: 'Scan for bikes',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoltCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Revolt RV400',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ConnectionStatusBadge(state: effectiveState),
                    ],
                  ),
                  if (effectiveState != BleConnectionState.disconnected)
                    OutlinedButton.icon(
                      onPressed: () async {
                        await repo.disconnect();
                      },
                      icon: const Icon(LucideIcons.power, size: 16),
                      label: const Text('Disconnect'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () => context.push('/device/scan'),
                      icon: const Icon(LucideIcons.search, size: 16),
                      label: const Text('Scan'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            snapshotAsync.when(
              loading: () => VoltCard(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        effectiveState == BleConnectionState.authenticated ||
                                effectiveState == BleConnectionState.connected
                            ? 'Waiting for telemetry packets...'
                            : 'Connect to RV400 to view live telemetry.',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              error: (err, stack) => VoltCard(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Telemetry error: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              data: (snapshot) => LiveTelemetryCard(snapshot: snapshot),
            ),
          ],
        ),
      ),
    );
  }
}
