import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/ui/volt_app_bar.dart';
import '../../../../shared/ui/volt_card.dart';
import '../../../rides/domain/ride.dart';
import '../../domain/ble_charge_state.dart';
import '../../domain/ble_trip_state.dart';
import '../../domain/connection_state.dart';
import '../providers/ble_charge_provider.dart';
import '../providers/ble_connection_provider.dart';
import '../providers/ble_trip_provider.dart';
import '../providers/vehicle_snapshot_provider.dart';
import '../widgets/charging_status_card.dart';
import '../widgets/connection_status_badge.dart';
import '../widgets/live_telemetry_card.dart';
import '../widgets/trip_status_card.dart';

/// Screen rendering detailed BLE device connection status and real-time telemetry.
class DeviceStatusScreen extends HookConsumerWidget {
  const DeviceStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStateAsync = ref.watch(bleConnectionStateProvider);
    final snapshotAsync = ref.watch(vehicleSnapshotProvider);
    final persistedSnapshotAsync = ref.watch(persistedVehicleSnapshotProvider);
    final repo = ref.read(bleRepositoryProvider);
    final currentState = repo.currentConnectionState;

    final effectiveState = connectionStateAsync.value ?? currentState;
    final tripState = ref.watch(bleTripProvider);
    final chargeState = ref.watch(bleChargeProvider);

    // Listen for trip saved notification
    ref.listen<BleTripState>(bleTripProvider, (prev, next) {
      if (prev?.status != BleTripStatus.stopped &&
          next.status == BleTripStatus.stopped &&
          next.lastSavedRide != null) {
        final distStr = next.lastSavedRide!.distance.toStringAsFixed(1);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Trip Auto-Saved: $distStr km (Source: BLE)'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    // Listen for charge log saved notification
    ref.listen<BleChargeState>(bleChargeProvider, (prev, next) {
      if (prev?.status != BleChargeStatus.completed &&
          next.status == BleChargeStatus.completed &&
          next.lastSavedChargeLog != null) {
        final gainedStr = next.batteryGained;
        final kwhStr = next.kwhAdded.toStringAsFixed(2);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Charge Log Auto-Saved: +$gainedStr% ($kwhStr kWh)'),
            backgroundColor: Colors.amber.shade800,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Device Status',
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bug),
            onPressed: () => context.push('/device/debug'),
            tooltip: 'BLE Debug Screen',
          ),
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
            if (tripState.status != BleTripStatus.idle) ...[
              const SizedBox(height: 20),
              TripStatusCard(tripState: tripState),
            ],
            if (chargeState.status != BleChargeStatus.idle) ...[
              const SizedBox(height: 20),
              ChargingStatusCard(chargeState: chargeState),
            ],
            const SizedBox(height: 24),
            snapshotAsync.when(
              loading: () {
                // No live packet yet this session — fall back to whatever
                // was last synced to disk (survives app restart) instead of
                // just spinning. The bike has no channel to push data to us
                // without an active BLE connection, so this is "last known
                // state as of X", same as the official app's own sync label.
                final persisted = persistedSnapshotAsync.value;
                if (persisted != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 4),
                        child: Text(
                          'Last synced: ${persisted.timestamp?.toLocal() ?? "unknown"}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      LiveTelemetryCard(snapshot: persisted),
                    ],
                  );
                }
                return VoltCard(
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
                );
              },
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
