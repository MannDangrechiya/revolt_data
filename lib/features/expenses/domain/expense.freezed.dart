// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Expense {

 String get id; DateTime get date; ExpenseCategory get category; double get amount; String? get notes; String? get receiptPhotoPath; String? get description; int? get bikeId;
/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCopyWith<Expense> get copyWith => _$ExpenseCopyWithImpl<Expense>(this as Expense, _$identity);

  /// Serializes this Expense to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Expense&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.receiptPhotoPath, receiptPhotoPath) || other.receiptPhotoPath == receiptPhotoPath)&&(identical(other.description, description) || other.description == description)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,category,amount,notes,receiptPhotoPath,description,bikeId);

@override
String toString() {
  return 'Expense(id: $id, date: $date, category: $category, amount: $amount, notes: $notes, receiptPhotoPath: $receiptPhotoPath, description: $description, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class $ExpenseCopyWith<$Res>  {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) _then) = _$ExpenseCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, ExpenseCategory category, double amount, String? notes, String? receiptPhotoPath, String? description, int? bikeId
});




}
/// @nodoc
class _$ExpenseCopyWithImpl<$Res>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._self, this._then);

  final Expense _self;
  final $Res Function(Expense) _then;

/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? category = null,Object? amount = null,Object? notes = freezed,Object? receiptPhotoPath = freezed,Object? description = freezed,Object? bikeId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategory,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,receiptPhotoPath: freezed == receiptPhotoPath ? _self.receiptPhotoPath : receiptPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Expense].
extension ExpensePatterns on Expense {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Expense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Expense() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Expense value)  $default,){
final _that = this;
switch (_that) {
case _Expense():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Expense value)?  $default,){
final _that = this;
switch (_that) {
case _Expense() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  ExpenseCategory category,  double amount,  String? notes,  String? receiptPhotoPath,  String? description,  int? bikeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Expense() when $default != null:
return $default(_that.id,_that.date,_that.category,_that.amount,_that.notes,_that.receiptPhotoPath,_that.description,_that.bikeId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  ExpenseCategory category,  double amount,  String? notes,  String? receiptPhotoPath,  String? description,  int? bikeId)  $default,) {final _that = this;
switch (_that) {
case _Expense():
return $default(_that.id,_that.date,_that.category,_that.amount,_that.notes,_that.receiptPhotoPath,_that.description,_that.bikeId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  ExpenseCategory category,  double amount,  String? notes,  String? receiptPhotoPath,  String? description,  int? bikeId)?  $default,) {final _that = this;
switch (_that) {
case _Expense() when $default != null:
return $default(_that.id,_that.date,_that.category,_that.amount,_that.notes,_that.receiptPhotoPath,_that.description,_that.bikeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Expense implements Expense {
  const _Expense({required this.id, required this.date, required this.category, required this.amount, this.notes, this.receiptPhotoPath, this.description, this.bikeId});
  factory _Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);

@override final  String id;
@override final  DateTime date;
@override final  ExpenseCategory category;
@override final  double amount;
@override final  String? notes;
@override final  String? receiptPhotoPath;
@override final  String? description;
@override final  int? bikeId;

/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCopyWith<_Expense> get copyWith => __$ExpenseCopyWithImpl<_Expense>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Expense&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.receiptPhotoPath, receiptPhotoPath) || other.receiptPhotoPath == receiptPhotoPath)&&(identical(other.description, description) || other.description == description)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,category,amount,notes,receiptPhotoPath,description,bikeId);

@override
String toString() {
  return 'Expense(id: $id, date: $date, category: $category, amount: $amount, notes: $notes, receiptPhotoPath: $receiptPhotoPath, description: $description, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$ExpenseCopyWith(_Expense value, $Res Function(_Expense) _then) = __$ExpenseCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, ExpenseCategory category, double amount, String? notes, String? receiptPhotoPath, String? description, int? bikeId
});




}
/// @nodoc
class __$ExpenseCopyWithImpl<$Res>
    implements _$ExpenseCopyWith<$Res> {
  __$ExpenseCopyWithImpl(this._self, this._then);

  final _Expense _self;
  final $Res Function(_Expense) _then;

/// Create a copy of Expense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? category = null,Object? amount = null,Object? notes = freezed,Object? receiptPhotoPath = freezed,Object? description = freezed,Object? bikeId = freezed,}) {
  return _then(_Expense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ExpenseCategory,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,receiptPhotoPath: freezed == receiptPhotoPath ? _self.receiptPhotoPath : receiptPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
