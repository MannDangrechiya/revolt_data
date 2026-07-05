import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/expense.dart';

part 'expenses_provider.g.dart';

@riverpod
class Expenses extends _$Expenses {
  @override
  Stream<List<Expense>> build() {
    final db = ref.watch(databaseProvider);
    return db.select(db.expensesTable).watch().map((rows) {
      final expenses = rows.map((row) => row.toDomain()).toList();
      expenses.sort((a, b) => b.date.compareTo(a.date));
      return expenses;
    });
  }

  Future<void> addExpense(Expense expense) async {
    final db = ref.watch(databaseProvider);
    await db.into(db.expensesTable).insert(expense.toCompanion());
  }

  Future<void> removeExpense(String id) async {
    final db = ref.watch(databaseProvider);
    await (db.delete(db.expensesTable)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Future<Map<ExpenseCategory, double>> expensesByCategory(Ref ref) async {
  final expenses = await ref.watch(expensesProvider.future);
  final map = <ExpenseCategory, double>{};
  
  for (final exp in expenses) {
    map[exp.category] = (map[exp.category] ?? 0.0) + exp.amount;
  }
  return map;
}

@riverpod
Future<double> totalExpenses(Ref ref) async {
  final map = await ref.watch(expensesByCategoryProvider.future);
  return map.values.fold<double>(0.0, (sum, val) => sum + val);
}
