import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/battery_health_provider.dart';
import '../../data/charging_provider.dart';


class BatteryHealthDashboard extends HookConsumerWidget {
  const BatteryHealthDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cycles = ref.watch(totalChargeCyclesProvider).asData?.value ?? 0;
    final efficiency = ref.watch(powerEfficiencyProvider).asData?.value ?? 0.0;
    final health = ref.watch(batteryHealthEstimateProvider).asData?.value ?? 100.0;
    final totalCost = ref.watch(totalChargingCostProvider).asData?.value ?? 0.0;
    final avgSpeed = ref.watch(averageChargingSpeedProvider).asData?.value ?? 0.0;
    final distribution = ref.watch(chargingLocationDistributionProvider).asData?.value ?? {};

    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: _buildMetricCard(theme, 'Health', '${health.toStringAsFixed(1)}%', Icons.health_and_safety, Colors.green)),
            Expanded(child: _buildMetricCard(theme, 'Cycles', '$cycles', Icons.loop, Colors.blue)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildMetricCard(theme, 'Efficiency', '${efficiency.toStringAsFixed(2)} km/kWh', Icons.speed, Colors.orange)),
            Expanded(child: _buildMetricCard(theme, 'Total Cost', '₹${totalCost.toStringAsFixed(2)}', Icons.currency_rupee, Colors.purple)),
          ],
        ),
        _buildMetricCard(theme, 'Average Speed', '${avgSpeed.toStringAsFixed(1)} kW', Icons.bolt, Colors.amber),
        
        const SizedBox(height: 16),
        Text('Location Distribution', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: distribution.entries.map((e) {
            return Column(
              children: [
                Text(e.key.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${e.value} charges'),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(ThemeData theme, String title, String value, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text(title, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
