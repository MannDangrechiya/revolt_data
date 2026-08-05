// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battery_health_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BatteryHealthSnapshot {

 String get id; DateTime get date; double get healthPercent; double get rangeAtFullCharge; int? get bikeId;
/// Create a copy of BatteryHealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatteryHealthSnapshotCopyWith<BatteryHealthSnapshot> get copyWith => _$BatteryHealthSnapshotCopyWithImpl<BatteryHealthSnapshot>(this as BatteryHealthSnapshot, _$identity);

  /// Serializes this BatteryHealthSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatteryHealthSnapshot&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.healthPercent, healthPercent) || other.healthPercent == healthPercent)&&(identical(other.rangeAtFullCharge, rangeAtFullCharge) || other.rangeAtFullCharge == rangeAtFullCharge)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,healthPercent,rangeAtFullCharge,bikeId);

@override
String toString() {
  return 'BatteryHealthSnapshot(id: $id, date: $date, healthPercent: $healthPercent, rangeAtFullCharge: $rangeAtFullCharge, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class $BatteryHealthSnapshotCopyWith<$Res>  {
  factory $BatteryHealthSnapshotCopyWith(BatteryHealthSnapshot value, $Res Function(BatteryHealthSnapshot) _then) = _$BatteryHealthSnapshotCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, double healthPercent, double rangeAtFullCharge, int? bikeId
});




}
/// @nodoc
class _$BatteryHealthSnapshotCopyWithImpl<$Res>
    implements $BatteryHealthSnapshotCopyWith<$Res> {
  _$BatteryHealthSnapshotCopyWithImpl(this._self, this._then);

  final BatteryHealthSnapshot _self;
  final $Res Function(BatteryHealthSnapshot) _then;

/// Create a copy of BatteryHealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? healthPercent = null,Object? rangeAtFullCharge = null,Object? bikeId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,healthPercent: null == healthPercent ? _self.healthPercent : healthPercent // ignore: cast_nullable_to_non_nullable
as double,rangeAtFullCharge: null == rangeAtFullCharge ? _self.rangeAtFullCharge : rangeAtFullCharge // ignore: cast_nullable_to_non_nullable
as double,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BatteryHealthSnapshot].
extension BatteryHealthSnapshotPatterns on BatteryHealthSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BatteryHealthSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BatteryHealthSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BatteryHealthSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _BatteryHealthSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BatteryHealthSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _BatteryHealthSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  double healthPercent,  double rangeAtFullCharge,  int? bikeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BatteryHealthSnapshot() when $default != null:
return $default(_that.id,_that.date,_that.healthPercent,_that.rangeAtFullCharge,_that.bikeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  double healthPercent,  double rangeAtFullCharge,  int? bikeId)  $default,) {final _that = this;
switch (_that) {
case _BatteryHealthSnapshot():
return $default(_that.id,_that.date,_that.healthPercent,_that.rangeAtFullCharge,_that.bikeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  double healthPercent,  double rangeAtFullCharge,  int? bikeId)?  $default,) {final _that = this;
switch (_that) {
case _BatteryHealthSnapshot() when $default != null:
return $default(_that.id,_that.date,_that.healthPercent,_that.rangeAtFullCharge,_that.bikeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BatteryHealthSnapshot implements BatteryHealthSnapshot {
  const _BatteryHealthSnapshot({required this.id, required this.date, required this.healthPercent, required this.rangeAtFullCharge, this.bikeId});
  factory _BatteryHealthSnapshot.fromJson(Map<String, dynamic> json) => _$BatteryHealthSnapshotFromJson(json);

@override final  String id;
@override final  DateTime date;
@override final  double healthPercent;
@override final  double rangeAtFullCharge;
@override final  int? bikeId;

/// Create a copy of BatteryHealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatteryHealthSnapshotCopyWith<_BatteryHealthSnapshot> get copyWith => __$BatteryHealthSnapshotCopyWithImpl<_BatteryHealthSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatteryHealthSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatteryHealthSnapshot&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.healthPercent, healthPercent) || other.healthPercent == healthPercent)&&(identical(other.rangeAtFullCharge, rangeAtFullCharge) || other.rangeAtFullCharge == rangeAtFullCharge)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,healthPercent,rangeAtFullCharge,bikeId);

@override
String toString() {
  return 'BatteryHealthSnapshot(id: $id, date: $date, healthPercent: $healthPercent, rangeAtFullCharge: $rangeAtFullCharge, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class _$BatteryHealthSnapshotCopyWith<$Res> implements $BatteryHealthSnapshotCopyWith<$Res> {
  factory _$BatteryHealthSnapshotCopyWith(_BatteryHealthSnapshot value, $Res Function(_BatteryHealthSnapshot) _then) = __$BatteryHealthSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, double healthPercent, double rangeAtFullCharge, int? bikeId
});




}
/// @nodoc
class __$BatteryHealthSnapshotCopyWithImpl<$Res>
    implements _$BatteryHealthSnapshotCopyWith<$Res> {
  __$BatteryHealthSnapshotCopyWithImpl(this._self, this._then);

  final _BatteryHealthSnapshot _self;
  final $Res Function(_BatteryHealthSnapshot) _then;

/// Create a copy of BatteryHealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? healthPercent = null,Object? rangeAtFullCharge = null,Object? bikeId = freezed,}) {
  return _then(_BatteryHealthSnapshot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,healthPercent: null == healthPercent ? _self.healthPercent : healthPercent // ignore: cast_nullable_to_non_nullable
as double,rangeAtFullCharge: null == rangeAtFullCharge ? _self.rangeAtFullCharge : rangeAtFullCharge // ignore: cast_nullable_to_non_nullable
as double,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
