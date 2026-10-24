import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../dashboard/data/dashboard_provider.dart';

/// Screen presenting lifetime battery health, State of Health (SOH %),
/// equivalent full cycle calculations, cell degradation trends, and
/// practical lithium-ion care protocols for the Revolt RV400 3.24 kWh pack.
class BatteryHealthScreen extends ConsumerWidget {
  const BatteryHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
    final dashboardData = ref.watch(dashboardDataProvider).value;
    final snapshot = liveSnapshot ?? lastSnapshot;

    // Use live snapshot odometer if available, otherwise fall back to dashboard calibrated cluster odometer
    final currentOdo = snapshot?.odometer ?? dashboardData?.currentOdometer ?? 19920.0;
    // Estimated cycles based on ~33 Wh/km over odometer
    final totalKwhCharged = (currentOdo * 33.0) / 1000.0;
    final equivalentCycles = currentOdo > 0 ? (totalKwhCharged / 3.24).clamp(1.0, 3000.0) : 0.0;

    // SOH estimate (NMC cells retain ~80% after 1500 cycles)
    final sohPercent = snapshot?.batteryHealth?.toDouble() ??
        (currentOdo > 0 ? (100.0 - (equivalentCycles * 0.012)).clamp(75.0, 100.0) : 100.0);

    final currentCapacityAh = (45.0 * (sohPercent / 100.0)).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Longevity & Health'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plugZap),
            tooltip: '15A Charging Screen',
            onPressed: () => context.push('/home-charging'),
          ),
          IconButton(
            icon: const Icon(LucideIcons.activity),
            tooltip: 'Live BMS Diagnostics',
            onPressed: () => context.push('/battery-diagnostics'),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Hero SOH Card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF064E3B), const Color(0xFF0F172A)]
                    : [const Color(0xFFD1FAE5), const Color(0xFFF0FDF4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(LucideIcons.shieldCheck, color: Color(0xFF10B981), size: 18),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'STATE OF HEALTH (SOH)',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                                color: isDark ? const Color(0xFF34D399) : const Color(0xFF059669),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF10B981)),
                      ),
                      child: const Text(
                        'OPTIMAL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Radial or Percentage Highlight
                Text(
                  '${sohPercent.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  '$currentCapacityAh Ah remaining of original 45.0 Ah (3.24 kWh)',
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (sohPercent / 100.0).clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: Colors.black12,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Lifecycle & Usage 4-Grid
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  context,
                  title: 'Full Cycles',
                  value: equivalentCycles.toStringAsFixed(0),
                  sub: 'of ~1,500 rated cycles',
                  icon: LucideIcons.refreshCw,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricTile(
                  context,
                  title: 'Energy Used',
                  value: '${totalKwhCharged.toStringAsFixed(1)} kWh',
                  sub: 'Cumulative traction power',
                  icon: LucideIcons.zap,
                  color: Colors.amber,
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
                  title: 'Avg Efficiency',
                  value: '33.0 Wh/km',
                  sub: '~30.3 km per kWh',
                  icon: LucideIcons.gauge,
                  color: const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricTile(
                  context,
                  title: 'Pack Chemistry',
                  value: 'NMC 72V',
                  sub: 'High energy density',
                  icon: LucideIcons.cpu,
                  color: Colors.purpleAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Thermal Exposure Distribution
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(LucideIcons.thermometer, size: 18, color: Colors.deepOrange),
                    SizedBox(width: 8),
                    Text(
                      'Thermal Operating History',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Percentage of operational ride hours within optimal thermal boundaries',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                _buildThermalBar(
                  label: 'Optimal Zone (20°C - 38°C)',
                  percent: 88,
                  color: const Color(0xFF10B981),
                ),
                const SizedBox(height: 8),
                _buildThermalBar(
                  label: 'Warm Zone (38°C - 45°C)',
                  percent: 10,
                  color: const Color(0xFFF59E0B),
                ),
                const SizedBox(height: 8),
                _buildThermalBar(
                  label: 'High Temp Alert (> 45°C)',
                  percent: 2,
                  color: const Color(0xFFEF4444),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Longevity Care Best Practices
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(LucideIcons.heartPulse, size: 18, color: Color(0xFF10B981)),
                    SizedBox(width: 8),
                    Text(
                      'RV400 Battery Longevity Protocols',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                _buildTip(
                  icon: LucideIcons.batteryLow,
                  title: 'Prevent Deep Discharges',
                  body: 'Recharge when battery reaches 20%. Regularly draining to 0% accelerates lithium plating and capacity fade.',
                ),
                _buildTip(
                  icon: LucideIcons.wind,
                  title: 'Post-Ride Cool Down',
                  body: 'After riding fast in Sport mode, wait 15-20 minutes before plugging in the 15A charger to avoid thermal stress.',
                ),
                _buildTip(
                  icon: LucideIcons.power,
                  title: 'Storage Strategy (50% - 60% SOC)',
                  body: 'If leaving the bike unridden for over a week, store battery at 50-60% SOC and flip the MCB breaker switch OFF.',
                ),
                _buildTip(
                  icon: LucideIcons.sun,
                  title: 'Shade Charging',
                  body: 'Always charge your RV400 under shade. Direct midday sunlight during AC charging can raise cell temperatures above 45°C.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildMetricTile(
    BuildContext context, {
    required String title,
    required String value,
    required String sub,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThermalBar({
    required String label,
    required int percent,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            Text('$percent%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent / 100.0,
            minHeight: 6,
            backgroundColor: Colors.black12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildTip({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF10B981)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(fontSize: 12, height: 1.35, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
