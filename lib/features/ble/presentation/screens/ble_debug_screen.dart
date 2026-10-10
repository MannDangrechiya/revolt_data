import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/ui/volt_app_bar.dart';
import '../../../../shared/ui/volt_card.dart';
import '../../../rides/domain/ride.dart';
import '../../domain/ble_charge_state.dart';
import '../../domain/ble_trip_state.dart';
import '../providers/ble_charge_provider.dart';
import '../providers/ble_debug_provider.dart';
import '../providers/ble_trip_provider.dart';
import '../providers/vehicle_snapshot_provider.dart';

/// Companion debug screen for hardware validation on the Revolt RV400.
class BleDebugScreen extends HookConsumerWidget {
  const BleDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packetLog = ref.watch(rawPacketLogProvider);
    final snapshot = ref.watch(lastKnownVehicleSnapshotProvider);
    final debugActions = ref.read(bleDebugActionsProvider.notifier);

    final scrollController = useScrollController();

    // Auto-scroll terminal view to bottom on new packets
    useEffect(() {
      if (scrollController.hasClients && packetLog.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          }
        });
      }
      return null;
    }, [packetLog.length]);

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

    final now = DateTime.now();
    final isStale = snapshot == null ||
        snapshot.timestamp == null ||
        now.difference(snapshot.timestamp!).inSeconds > 5;

    return Scaffold(
      appBar: VoltAppBar(
        title: 'BLE Debug & Validation',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.trash2),
            onPressed: () => debugActions.clearPacketLog(),
            tooltip: 'Clear Packet Log',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Action Controls
            const Text(
              'Manual Debug Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () => debugActions.forceTripStart(),
                  icon: const Icon(LucideIcons.play, size: 16),
                  label: const Text('Force Trip Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async => await debugActions.forceTripStop(),
                  icon: const Icon(LucideIcons.square, size: 16),
                  label: const Text('Force Trip Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => debugActions.forceChargeStart(),
                  icon: const Icon(LucideIcons.zap, size: 16),
                  label: const Text('Force Charge Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade800,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async => await debugActions.forceChargeStop(),
                  icon: const Icon(LucideIcons.batteryCharging, size: 16),
                  label: const Text('Force Charge Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () async => await debugActions.clearCache(),
                  icon: const Icon(LucideIcons.trash2, size: 16),
                  label: const Text('Clear Cache'),
                ),
                OutlinedButton.icon(
                  onPressed: () async => await debugActions.simulateDisconnect(),
                  icon: const Icon(LucideIcons.power, size: 16),
                  label: const Text('Simulate Disconnect'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange.shade800,
                    side: BorderSide(color: Colors.orange.shade800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section 2: Terminal View (Last 100 BLE Packets)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Raw BLE Packet Log',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Count: ${packetLog.length}/100',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            VoltCard(
              padding: EdgeInsets.zero,
              color: const Color(0xFF1E1E1E),
              child: Container(
                height: 220,
                padding: const EdgeInsets.all(12),
                child: packetLog.isEmpty
                    ? const Center(
                        child: Text(
                          'No BLE packets received yet.',
                          style: TextStyle(color: Colors.grey, fontFamily: 'monospace'),
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: packetLog.length,
                        itemBuilder: (context, index) {
                          final packet = packetLog[index];
                          final timeStr =
                              packet.timestamp.toIso8601String().substring(11, 19);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '[$timeStr] ${packet.direction.name.toUpperCase()} (${packet.rawBytes.length}B): ${packet.hexString}',
                                  style: const TextStyle(
                                    color: Colors.cyanAccent,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  packet.parsedJson,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                const Divider(color: Colors.white24, height: 12),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Section 3: Live VehicleSnapshot Table & Stale Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Live VehicleSnapshot Fields',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isStale ? Colors.red.shade100 : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isStale ? Colors.red.shade700 : Colors.green.shade700,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isStale ? LucideIcons.alertTriangle : LucideIcons.checkCircle2,
                        size: 14,
                        color: isStale ? Colors.red.shade700 : Colors.green.shade700,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isStale ? 'STALE (>5s)' : 'LIVE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isStale ? Colors.red.shade700 : Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            VoltCard(
              padding: const EdgeInsets.all(12),
              child: snapshot == null
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'No snapshot data available.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        _buildSnapshotRow('batteryPercentage', snapshot.formattedBatteryPercent),
                        _buildSnapshotRow('batteryVoltage', snapshot.formattedVoltage),
                        _buildSnapshotRow('batteryCurrent', snapshot.formattedCurrent),
                        _buildSnapshotRow('speed', snapshot.formattedSpeed),
                        _buildSnapshotRow('odometer', snapshot.formattedOdometer),
                        _buildSnapshotRow('tripDistance', snapshot.formattedTripDistance),
                        _buildSnapshotRow('rideMode', snapshot.formattedRideMode),
                        _buildSnapshotRow('range', snapshot.formattedRange),
                        _buildSnapshotRow('power', snapshot.formattedPower),
                        _buildSnapshotRow('batteryTemp', snapshot.formattedBatteryTemp),
                        _buildSnapshotRow('motorTemp', snapshot.formattedMotorTemp),
                        _buildSnapshotRow('batteryHealth', snapshot.formattedBatteryHealth),
                        _buildSnapshotRow('faultCodes',
                            snapshot.faultCodes.isNotEmpty ? snapshot.faultCodes.join(', ') : 'None'),
                        _buildSnapshotRow('gpsCoords', snapshot.gpsCoords ?? 'N/A'),
                        _buildSnapshotRow(
                            'timestamp',
                            snapshot.timestamp != null
                                ? snapshot.timestamp!.toIso8601String().substring(11, 19)
                                : 'N/A'),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnapshotRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        ],
      ),
    );
  }
}
