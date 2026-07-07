import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../application/statistics_service.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statisticsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics & Impact'),
      ),
      body: statsAsync.when(
        data: (stats) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeaderCard(context, stats),
                const SizedBox(height: 16),
                _buildSavingsGrid(context, stats),
                const SizedBox(height: 24),
                const Text('Ride Analytics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildRideStatsRow(context, stats),
                const SizedBox(height: 24),
                const Text('Monthly Expenditure', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildMonthlyChart(context, stats),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, StatisticsData stats) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Total Ownership Cost',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${stats.totalOwnershipCost.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavingsGrid(BuildContext context, StatisticsData stats) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            icon: LucideIcons.leaf,
            color: Colors.green,
            title: 'CO₂ Saved',
            value: '${stats.co2SavedKg.toStringAsFixed(1)} kg',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            icon: LucideIcons.banknote,
            color: Colors.blue,
            title: 'Petrol Savings',
            value: '₹${stats.petrolSavings.toStringAsFixed(0)}',
          ),
        ),
      ],
    );
  }

  Widget _buildRideStatsRow(BuildContext context, StatisticsData stats) {
    return Row(
      children: [
        Expanded(
          child: _buildSmallStatCard(
            context,
            title: 'Longest',
            value: '${stats.longestRide.toStringAsFixed(1)} km',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildSmallStatCard(
            context,
            title: 'Shortest',
            value: '${stats.shortestRide.toStringAsFixed(1)} km',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildSmallStatCard(
            context,
            title: 'Average',
            value: '${stats.avgRideDistance.toStringAsFixed(1)} km',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, {required IconData icon, required Color color, required String title, required String value}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStatCard(BuildContext context, {required String title, required String value}) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyChart(BuildContext context, StatisticsData stats) {
    if (stats.monthlyExpenses.isEmpty) {
      return const SizedBox(height: 200, child: Center(child: Text('No data yet')));
    }

    final barGroups = <BarChartGroupData>[];
    for (int i = 1; i <= 12; i++) {
      if (stats.monthlyExpenses.containsKey(i)) {
        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: stats.monthlyExpenses[i]!,
                color: Theme.of(context).colorScheme.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: stats.monthlyExpenses.values.reduce((a, b) => a > b ? a : b) * 1.2,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(months[value.toInt() - 1], style: const TextStyle(fontSize: 10)),
                      );
                    },
                    reservedSize: 28,
                  ),
                ),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: barGroups,
            ),
          ),
        ),
      ),
    );
  }
}
