import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/ui/volt_app_bar.dart';
import '../../ble/domain/vehicle_snapshot.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';

/// Deep Battery Diagnostics & BMS Health Screen for Revolt RV400
class BatteryDiagnosticsScreen extends ConsumerWidget {
  const BatteryDiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
    final persistedSnapshot = ref.watch(persistedVehicleSnapshotProvider).value;

    final snapshot = liveSnapshot ?? lastSnapshot ?? persistedSnapshot;

    final soc = snapshot?.batteryPercent ?? 88;
    final voltage = snapshot?.batteryVoltage ?? 72.4;
    final current = snapshot?.batteryCurrent ?? 0.0;
    final batTemp = snapshot?.batteryTemp ?? 32;
    final motorTemp = snapshot?.motorTemp ?? 38;
    final health = snapshot?.batteryHealth ?? 97;
    final powerKw = ((voltage * current).abs() / 1000.0);
    final isCharging = current > 0;
    final faultCodes = snapshot?.faultCodes ?? const [];

    final estRangeEco = (soc * 1.5).round();
    final estRangeNormal = (soc * 1.0).round();
    final estRangeSport = (soc * 0.8).round();

    Color tempColor;
    String tempStatus;
    if (batTemp < 45) {
      tempColor = Colors.teal;
      tempStatus = 'Optimal';
    } else if (batTemp < 55) {
      tempColor = Colors.orange;
      tempStatus = 'Warm';
    } else {
      tempColor = Colors.red;
      tempStatus = 'Critical Heat';
    }

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Battery & BMS Diagnostics',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.heartPulse),
            tooltip: 'Battery Longevity & Health',
            onPressed: () => context.push('/battery-health'),
          ),
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            tooltip: 'Refresh Telematics',
            onPressed: () async {
              HapticFeedback.lightImpact();
              await ref.read(telemetryRepositoryProvider).refreshCloudTelemetry();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Battery diagnostics refreshed.'),
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
            // Hero SOC Gauge Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCharging ? LucideIcons.batteryCharging : LucideIcons.batteryMedium,
                            color: isCharging ? Colors.green : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isCharging ? 'CHARGING VIA BMS' : 'LITHIUM-ION PACK',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (snapshot?.source == TelemetrySource.ble
                                  ? Colors.teal
                                  : Colors.blue.shade700)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          snapshot?.source.label ?? 'Telematics',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: snapshot?.source == TelemetrySource.ble
                                ? Colors.teal
                                : Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: (soc / 100.0).clamp(0.0, 1.0),
                          strokeWidth: 12,
                          backgroundColor: Colors.grey.withValues(alpha: 0.2),
                          color: soc > 50
                              ? Colors.green
                              : (soc > 20 ? Colors.orange : Colors.red),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$soc%',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                          const Text(
                            'State of Charge',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniMetric(
                        context,
                        label: 'Capacity',
                        value: '3.24 kWh',
                        icon: LucideIcons.zap,
                      ),
                      _buildMiniMetric(
                        context,
                        label: 'Health (SOH)',
                        value: '$health%',
                        icon: LucideIcons.heartPulse,
                        color: health > 90 ? Colors.teal : Colors.orange,
                      ),
                      _buildMiniMetric(
                        context,
                        label: 'Pack Temp ($tempStatus)',
                        value: '$batTemp°C',
                        icon: LucideIcons.thermometer,
                        color: tempColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Live Electrical Metrics Grid
            const Text(
              'Live Electrical & Power Metrics',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Pack Voltage',
                    value: '${voltage.toStringAsFixed(1)} V',
                    subtext: 'Nominal 72.0V system',
                    icon: LucideIcons.activity,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: isCharging ? 'Charge Current' : 'Current Draw',
                    value: '${current.abs().toStringAsFixed(1)} A',
                    subtext: isCharging ? 'Regenerative / AC' : 'Discharge load',
                    icon: LucideIcons.zap,
                    color: isCharging ? Colors.green : Colors.amber.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Active Power',
                    value: '${powerKw.toStringAsFixed(2)} kW',
                    subtext: 'Real-time output load',
                    icon: LucideIcons.gauge,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Motor Temp',
                    value: '$motorTemp°C',
                    subtext: motorTemp < 50 ? 'Cool & optimal' : 'High load',
                    icon: LucideIcons.flame,
                    color: motorTemp < 50 ? Colors.teal : Colors.deepOrange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Range Estimate per Riding Mode
            const Text(
              'Estimated Range by Riding Mode',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRangeRow(context, mode: 'Eco Mode (45 km/h max)', km: estRangeEco, color: Colors.green),
                    const Divider(height: 16),
                    _buildRangeRow(context, mode: 'Normal Mode (65 km/h max)', km: estRangeNormal, color: Colors.blue),
                    const Divider(height: 16),
                    _buildRangeRow(context, mode: 'Sport Mode (85 km/h max)', km: estRangeSport, color: Colors.orange),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BMS Health & Diagnostics Check
            const Text(
              'BMS & Cell Diagnostic Trouble Codes (DTC)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: faultCodes.isEmpty
                    ? Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(LucideIcons.checkCircle, color: Colors.green, size: 24),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BMS Cells Fully Functional',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Zero faults reported by vehicle controller.',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.triangleAlert, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Diagnostic Faults Detected',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          for (final code in faultCodes)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const Icon(LucideIcons.chevronRight, size: 16, color: Colors.red),
                                  const SizedBox(width: 6),
                                  Text(
                                    code,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
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

  Widget _buildMiniMetric(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Color? color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color ?? Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMetricTile(
    BuildContext context, {
    required String title,
    required String value,
    required String subtext,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            subtext,
            style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeRow(
    BuildContext context, {
    required String mode,
    required int km,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              mode,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          '~$km km',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
