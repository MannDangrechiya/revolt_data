// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Expenses)
final expensesProvider = ExpensesProvider._();

final class ExpensesProvider
    extends $StreamNotifierProvider<Expenses, List<Expense>> {
  ExpensesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesHash();

  @$internal
  @override
  Expenses create() => Expenses();
}

String _$expensesHash() => r'ff7d4c0c8ec20ae4e2bf06de14e8e74ca325df10';

abstract class _$Expenses extends $StreamNotifier<List<Expense>> {
  Stream<List<Expense>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Expense>>, List<Expense>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Expense>>, List<Expense>>,
              AsyncValue<List<Expense>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(expensesByCategory)
final expensesByCategoryProvider = ExpensesByCategoryProvider._();

final class ExpensesByCategoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<ExpenseCategory, double>>,
          Map<ExpenseCategory, double>,
          FutureOr<Map<ExpenseCategory, double>>
        >
    with
        $FutureModifier<Map<ExpenseCategory, double>>,
        $FutureProvider<Map<ExpenseCategory, double>> {
  ExpensesByCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesByCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesByCategoryHash();

  @$internal
  @override
  $FutureProviderElement<Map<ExpenseCategory, double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<ExpenseCategory, double>> create(Ref ref) {
    return expensesByCategory(ref);
  }
}

String _$expensesByCategoryHash() =>
    r'e895772b6f7e757724b49fa9c2dfb8b8c7d0bd05';

@ProviderFor(totalExpenses)
final totalExpensesProvider = TotalExpensesProvider._();

final class TotalExpensesProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  TotalExpensesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalExpensesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalExpensesHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return totalExpenses(ref);
  }
}

String _$totalExpensesHash() => r'16be79435e111538d150405167607cf7f6c187c4';
