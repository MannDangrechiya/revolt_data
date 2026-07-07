import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../application/efficiency_service.dart';

class EfficiencyScreen extends HookConsumerWidget {
  const EfficiencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(efficiencyStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Efficiency Analysis')),
      body: statsAsync.when(
        data: (stats) {
          final sortedDays = stats.dailyAverageDistance.keys.toList()..sort((a, b) => a.compareTo(b));
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _StatCard(
                    title: 'Avg km / 1% Bat',
                    value: stats.kmPerPercentBattery.toStringAsFixed(2),
                    icon: Icons.electric_scooter,
                  ),
                  _StatCard(
                    title: 'Est km / Charge',
                    value: stats.kmPerCharge.toStringAsFixed(1),
                    icon: Icons.battery_charging_full,
                  ),
                  _StatCard(
                    title: 'Avg km / kWh',
                    value: stats.kmPerKwh.toStringAsFixed(2),
                    icon: Icons.bolt,
                  ),
                  _StatCard(
                    title: 'Cost per km',
                    value: '\$${stats.costPerKm.toStringAsFixed(2)}',
                    icon: Icons.attach_money,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Daily Distance (km)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              if (sortedDays.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= 0 && value.toInt() < sortedDays.length) {
                                    final date = sortedDays[value.toInt()];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(DateFormat('d/M').format(date), style: const TextStyle(fontSize: 10)),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: false),
                          barGroups: sortedDays.asMap().entries.map((e) {
                            return BarChartGroupData(
                              x: e.key,
                              barRods: [
                                BarChartRodData(
                                  toY: stats.dailyAverageDistance[e.value] ?? 0,
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 16,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                )
              else
                const Card(child: Padding(padding: EdgeInsets.all(32), child: Center(child: Text('Not enough data for chart')))),
              const SizedBox(height: 24),
              const Text('Efficiency Records', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.star, color: Colors.white)),
                      title: const Text('Best Efficiency'),
                      subtitle: const Text('km per 1% battery'),
                      trailing: Text(stats.bestEfficiencyKmPerPercent.toStringAsFixed(2), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const CircleAvatar(backgroundColor: Colors.red, child: Icon(Icons.warning, color: Colors.white)),
                      title: const Text('Worst Efficiency'),
                      subtitle: const Text('km per 1% battery'),
                      trailing: Text(stats.worstEfficiencyKmPerPercent.toStringAsFixed(2), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
