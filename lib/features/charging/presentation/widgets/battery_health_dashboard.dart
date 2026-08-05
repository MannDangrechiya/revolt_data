import 'package:fl_chart/fl_chart.dart';
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
    final health = ref.watch(batteryHealthEstimateProvider);
    final totalCost = ref.watch(totalChargingCostProvider).asData?.value ?? 0.0;
    final avgSpeed = ref.watch(averageChargingSpeedProvider).asData?.value ?? 0.0;
    final distribution = ref.watch(chargingLocationDistributionProvider).asData?.value ?? {};
    final historyAsync = ref.watch(batteryHealthHistoryProvider);
    final degradationRate = ref.watch(batteryHealthDegradationRateProvider).asData?.value ?? 0.0;

    final theme = Theme.of(context);

    final historySpots = historyAsync.maybeWhen(
      data: (snapshots) => snapshots.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value.healthPercent);
      }).toList(),
      orElse: () => <FlSpot>[],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: _buildMetricCard(theme, 'Health', health != null ? '$health%' : 'N/A', Icons.health_and_safety, Colors.green)),
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
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Battery Health Trend', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    if (degradationRate > 0)
                      Text(
                        '-${degradationRate.toStringAsFixed(2)}%/mo',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: historySpots.length < 2
                      ? const Center(child: Text('Not enough data yet'))
                      : LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: historySpots,
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: const FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.green.withValues(alpha: 0.15),
                                ),
                              ),
                            ],
                            borderData: FlBorderData(show: false),
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                        ),
                ),
              ],
            ),
          ),
        ),

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
