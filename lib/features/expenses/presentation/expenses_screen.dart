import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/expenses_provider.dart';
import '../domain/expense.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/error_retry_widget.dart';

class ExpensesScreen extends HookConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesProvider);
    final totalsByCategoryAsync = ref.watch(expensesByCategoryProvider);
    final totalAsync = ref.watch(totalExpensesProvider);
    
    final selectedCategory = useState<ExpenseCategory?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _FilterSheet(
                  currentFilter: selectedCategory.value,
                  onFilterChanged: (val) {
                    selectedCategory.value = val;
                    Navigator.pop(context);
                  },
                ),
              );
            },
          )
        ],
      ),
      body: expensesAsync.when(
        data: (expenses) {
          final totalsByCategory = totalsByCategoryAsync.asData?.value ?? {};
          final total = totalAsync.asData?.value ?? 0.0;
          
          final filteredExpenses = selectedCategory.value == null 
              ? expenses 
              : expenses.where((e) => e.category == selectedCategory.value).toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text('Total Spent', style: TextStyle(fontSize: 16)),
                        Text(
                          '₹${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (totalsByCategory.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        sections: totalsByCategory.entries.toList().asMap().entries.map((entry) {
                          final idx = entry.key;
                          final e = entry.value;
                          final color = Colors.primaries[idx % Colors.primaries.length];
                          
                          return PieChartSectionData(
                            color: color,
                            value: e.value,
                            title: '${(e.value / total * 100).toStringAsFixed(1)}%',
                            radius: 50.0,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              if (totalsByCategory.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Wrap(
                      spacing: 8,
                      children: totalsByCategory.entries.toList().asMap().entries.map((entry) {
                        final idx = entry.key;
                        final e = entry.value;
                        return Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.primaries[idx % Colors.primaries.length],
                            radius: 8,
                          ),
                          label: Text('${e.key.name.toUpperCase()}: ₹${e.value.toStringAsFixed(2)}'),
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Expense History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      if (selectedCategory.value != null)
                        ActionChip(
                          label: Text('Filter: ${selectedCategory.value!.name}'),
                          onPressed: () => selectedCategory.value = null,
                          avatar: const Icon(Icons.close, size: 16),
                        ),
                    ],
                  ),
                ),
              ),
              if (filteredExpenses.isEmpty)
                const SliverToBoxAdapter(
                  child: EmptyStateWidget(
                    title: 'No expenses recorded',
                    message: 'Add an expense to start tracking your spending.',
                    icon: Icons.currency_rupee,
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final expense = filteredExpenses[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(expense.receiptPhotoPath != null ? Icons.receipt : Icons.currency_rupee),
                        ),
                        title: Text('${expense.category.name.toUpperCase()} • ₹${expense.amount.toStringAsFixed(2)}'),
                        subtitle: Text(
                          '${DateFormat('MMM d, yyyy').format(expense.date)}'
                          '${expense.description != null ? '\n${expense.description}' : ''}'
                        ),
                        isThreeLine: expense.description != null,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref.read(expensesProvider.notifier).removeExpense(expense.id);
                          },
                        ),
                        onTap: () => context.push('/expenses/edit', extra: expense),
                      );
                    },
                    childCount: filteredExpenses.length,
                  ),
                ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
            ],
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(16.0),
          child: ListSkeletonLoader(itemCount: 5, itemHeight: 80),
        ),
        error: (e, st) => ErrorRetryWidget(
          message: e.toString(),
          onRetry: () => ref.refresh(expensesProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final ExpenseCategory? currentFilter;
  final ValueChanged<ExpenseCategory?> onFilterChanged;

  const _FilterSheet({required this.currentFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filter by Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: currentFilter == null,
                onSelected: (s) {
                  if (s) onFilterChanged(null);
                },
              ),
              ...ExpenseCategory.values.map((c) => ChoiceChip(
                label: Text(c.name.toUpperCase()),
                selected: currentFilter == c,
                onSelected: (s) {
                  if (s) onFilterChanged(c);
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}
