// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncState {

 double get lastSyncedOdometer; DateTime get lastSyncedAt; int get lastKnownBatteryPercent;
/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStateCopyWith<SyncState> get copyWith => _$SyncStateCopyWithImpl<SyncState>(this as SyncState, _$identity);

  /// Serializes this SyncState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncState&&(identical(other.lastSyncedOdometer, lastSyncedOdometer) || other.lastSyncedOdometer == lastSyncedOdometer)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.lastKnownBatteryPercent, lastKnownBatteryPercent) || other.lastKnownBatteryPercent == lastKnownBatteryPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastSyncedOdometer,lastSyncedAt,lastKnownBatteryPercent);

@override
String toString() {
  return 'SyncState(lastSyncedOdometer: $lastSyncedOdometer, lastSyncedAt: $lastSyncedAt, lastKnownBatteryPercent: $lastKnownBatteryPercent)';
}


}

/// @nodoc
abstract mixin class $SyncStateCopyWith<$Res>  {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) _then) = _$SyncStateCopyWithImpl;
@useResult
$Res call({
 double lastSyncedOdometer, DateTime lastSyncedAt, int lastKnownBatteryPercent
});




}
/// @nodoc
class _$SyncStateCopyWithImpl<$Res>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._self, this._then);

  final SyncState _self;
  final $Res Function(SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastSyncedOdometer = null,Object? lastSyncedAt = null,Object? lastKnownBatteryPercent = null,}) {
  return _then(_self.copyWith(
lastSyncedOdometer: null == lastSyncedOdometer ? _self.lastSyncedOdometer : lastSyncedOdometer // ignore: cast_nullable_to_non_nullable
as double,lastSyncedAt: null == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastKnownBatteryPercent: null == lastKnownBatteryPercent ? _self.lastKnownBatteryPercent : lastKnownBatteryPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncState].
extension SyncStatePatterns on SyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncState value)  $default,){
final _that = this;
switch (_that) {
case _SyncState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncState value)?  $default,){
final _that = this;
switch (_that) {
case _SyncState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lastSyncedOdometer,  DateTime lastSyncedAt,  int lastKnownBatteryPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncState() when $default != null:
return $default(_that.lastSyncedOdometer,_that.lastSyncedAt,_that.lastKnownBatteryPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lastSyncedOdometer,  DateTime lastSyncedAt,  int lastKnownBatteryPercent)  $default,) {final _that = this;
switch (_that) {
case _SyncState():
return $default(_that.lastSyncedOdometer,_that.lastSyncedAt,_that.lastKnownBatteryPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lastSyncedOdometer,  DateTime lastSyncedAt,  int lastKnownBatteryPercent)?  $default,) {final _that = this;
switch (_that) {
case _SyncState() when $default != null:
return $default(_that.lastSyncedOdometer,_that.lastSyncedAt,_that.lastKnownBatteryPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncState extends SyncState {
  const _SyncState({required this.lastSyncedOdometer, required this.lastSyncedAt, required this.lastKnownBatteryPercent}): super._();
  factory _SyncState.fromJson(Map<String, dynamic> json) => _$SyncStateFromJson(json);

@override final  double lastSyncedOdometer;
@override final  DateTime lastSyncedAt;
@override final  int lastKnownBatteryPercent;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncStateCopyWith<_SyncState> get copyWith => __$SyncStateCopyWithImpl<_SyncState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncState&&(identical(other.lastSyncedOdometer, lastSyncedOdometer) || other.lastSyncedOdometer == lastSyncedOdometer)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.lastKnownBatteryPercent, lastKnownBatteryPercent) || other.lastKnownBatteryPercent == lastKnownBatteryPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastSyncedOdometer,lastSyncedAt,lastKnownBatteryPercent);

@override
String toString() {
  return 'SyncState(lastSyncedOdometer: $lastSyncedOdometer, lastSyncedAt: $lastSyncedAt, lastKnownBatteryPercent: $lastKnownBatteryPercent)';
}


}

/// @nodoc
abstract mixin class _$SyncStateCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory _$SyncStateCopyWith(_SyncState value, $Res Function(_SyncState) _then) = __$SyncStateCopyWithImpl;
@override @useResult
$Res call({
 double lastSyncedOdometer, DateTime lastSyncedAt, int lastKnownBatteryPercent
});




}
/// @nodoc
class __$SyncStateCopyWithImpl<$Res>
    implements _$SyncStateCopyWith<$Res> {
  __$SyncStateCopyWithImpl(this._self, this._then);

  final _SyncState _self;
  final $Res Function(_SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastSyncedOdometer = null,Object? lastSyncedAt = null,Object? lastKnownBatteryPercent = null,}) {
  return _then(_SyncState(
lastSyncedOdometer: null == lastSyncedOdometer ? _self.lastSyncedOdometer : lastSyncedOdometer // ignore: cast_nullable_to_non_nullable
as double,lastSyncedAt: null == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastKnownBatteryPercent: null == lastKnownBatteryPercent ? _self.lastKnownBatteryPercent : lastKnownBatteryPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
