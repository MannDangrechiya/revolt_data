// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      category: $enumDecode(_$ExpenseCategoryEnumMap, json['category']),
      amount: (json['amount'] as num).toDouble(),
      notes: json['notes'] as String?,
      receiptPhotoPath: json['receiptPhotoPath'] as String?,
    );

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'category': _$ExpenseCategoryEnumMap[instance.category]!,
      'amount': instance.amount,
      'notes': instance.notes,
      'receiptPhotoPath': instance.receiptPhotoPath,
    };

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.electricity: 'electricity',
  ExpenseCategory.service: 'service',
  ExpenseCategory.tires: 'tires',
  ExpenseCategory.insurance: 'insurance',
  ExpenseCategory.accessories: 'accessories',
  ExpenseCategory.other: 'other',
};
