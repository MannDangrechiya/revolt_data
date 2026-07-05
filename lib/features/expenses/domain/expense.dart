import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

enum ExpenseCategory {
  @JsonValue('electricity')
  electricity,
  @JsonValue('service')
  service,
  @JsonValue('tires')
  tires,
  @JsonValue('insurance')
  insurance,
  @JsonValue('accessories')
  accessories,
  @JsonValue('other')
  other,
}

@freezed
abstract class Expense with _$Expense {
  const factory Expense({
    required String id,
    required DateTime date,
    required ExpenseCategory category,
    required double amount,
    String? notes,
    String? receiptPhotoPath,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
}
