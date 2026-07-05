import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/expenses_provider.dart';

class ExpensesScreen extends HookConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesProvider);
    final totalsByCategoryAsync = ref.watch(expensesByCategoryProvider);
    final totalAsync = ref.watch(totalExpensesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Expenses Tracker')),
      body: expensesAsync.when(
        data: (expenses) {
          final totalsByCategory = totalsByCategoryAsync.asData?.value ?? {};
          final total = totalAsync.asData?.value ?? 0.0;

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
                          '\$${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (totalsByCategory.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('By Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: totalsByCategory.entries.map((e) {
                            return Chip(
                              label: Text('${e.key.name.toUpperCase()}: \$${e.value.toStringAsFixed(2)}'),
                              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text('Expense History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              if (expenses.isEmpty)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No expenses recorded.'),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final expense = expenses[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(expense.receiptPhotoPath != null ? Icons.receipt : Icons.attach_money),
                        ),
                        title: Text('${expense.category.name.toUpperCase()} • \$${expense.amount.toStringAsFixed(2)}'),
                        subtitle: Text(DateFormat('MMM d, yyyy').format(expense.date)),
                        trailing: expense.notes != null ? const Icon(Icons.note) : null,
                      );
                    },
                    childCount: expenses.length,
                  ),
                ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
