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
  description: json['description'] as String?,
  bikeId: (json['bikeId'] as num?)?.toInt(),
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'category': _$ExpenseCategoryEnumMap[instance.category]!,
  'amount': instance.amount,
  'notes': instance.notes,
  'receiptPhotoPath': instance.receiptPhotoPath,
  'description': instance.description,
  'bikeId': instance.bikeId,
};

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.electricity: 'electricity',
  ExpenseCategory.service: 'service',
  ExpenseCategory.tires: 'tires',
  ExpenseCategory.insurance: 'insurance',
  ExpenseCategory.accessories: 'accessories',
  ExpenseCategory.other: 'other',
  ExpenseCategory.parking: 'parking',
  ExpenseCategory.washing: 'washing',
  ExpenseCategory.cleaning: 'cleaning',
  ExpenseCategory.brakes: 'brakes',
  ExpenseCategory.suspension: 'suspension',
  ExpenseCategory.registration: 'registration',
};
