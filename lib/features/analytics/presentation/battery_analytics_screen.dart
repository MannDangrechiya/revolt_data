import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../application/battery_analytics_service.dart';
import '../../../shared/ui/error_widget.dart';

class BatteryAnalyticsScreen extends HookConsumerWidget {
  const BatteryAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(batteryAnalyticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Battery Analytics')),
      body: analyticsAsync.when(
        data: (data) {
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
                    title: 'Total Cycles',
                    value: data.totalChargeCycles.toString(),
                    icon: Icons.autorenew,
                  ),
                  _StatCard(
                    title: 'Full Charges',
                    value: data.fullCharges.toString(),
                    icon: Icons.battery_full,
                  ),
                  _StatCard(
                    title: 'Avg Duration',
                    value: '${data.averageChargingDurationMins.round()}m',
                    icon: Icons.timer,
                  ),
                  _StatCard(
                    title: 'Battery Health',
                    value: '${data.currentHealthPercent.round()}%',
                    icon: Icons.favorite,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Degradation Curve (Estimated)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 100),
                              FlSpot(data.totalChargeCycles.toDouble(), data.currentHealthPercent),
                            ],
                            isCurved: true,
                            color: Theme.of(context).colorScheme.primary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => VoltErrorWidget(
          message: e.toString(),
          onRetry: () => ref.refresh(batteryAnalyticsProvider),
        ),
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
