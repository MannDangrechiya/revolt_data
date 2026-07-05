import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../rides/data/rides_provider.dart';
import '../../../rides/domain/ride.dart';

class EfficiencyChart extends HookConsumerWidget {
  const EfficiencyChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ridesAsync = ref.watch(ridesProvider);
    final theme = Theme.of(context);

    // Map each ride to an efficiency point: km per % battery
    final spots = ridesAsync.maybeWhen(
      data: (rides) {
        final validRides = rides.where((r) => r.batteryBefore > r.batteryAfter).toList()
          ..sort((a, b) => a.date.compareTo(b.date)); // Sort chronologically

        return validRides.asMap().entries.map((e) {
          final index = e.key.toDouble();
          final ride = e.value;
          final batteryConsumed = ride.batteryBefore - ride.batteryAfter;
          final efficiency = ride.distance / batteryConsumed; // km per %
          return FlSpot(index, efficiency);
        }).toList();
      },
      orElse: () => <FlSpot>[],
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Efficiency Trend (km per %)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: spots.isEmpty
                  ? const Center(child: Text('Not enough data'))
                  : LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: theme.colorScheme.secondary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                            ),
                          ),
                        ],
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
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
    );
  }
}
