import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../expenses/data/expenses_provider.dart';

class ExpenseBreakdownChart extends HookConsumerWidget {
  const ExpenseBreakdownChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesByCategoryAsync = ref.watch(expensesByCategoryProvider);
    final theme = Theme.of(context);

    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    final pieSections = expensesByCategoryAsync.maybeWhen(
      data: (expensesByCategory) {
        int colorIndex = 0;
        return expensesByCategory.entries.where((e) => e.value > 0).map((e) {
          final color = colors[colorIndex % colors.length];
          colorIndex++;
          
          return PieChartSectionData(
            value: e.value,
            title: '${e.key.name}\n₹${e.value.toStringAsFixed(0)}',
            color: color,
            radius: 60,
            titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList();
      },
      orElse: () => <PieChartSectionData>[],
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Expense Breakdown', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: pieSections.isEmpty
                  ? const Center(child: Text('No expenses recorded'))
                  : PieChart(
                      PieChartData(
                        sections: pieSections,
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
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
