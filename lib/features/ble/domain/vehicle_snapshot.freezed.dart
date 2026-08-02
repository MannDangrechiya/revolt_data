// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleSnapshot {

 int get battery; double get voltage; double get current; int get temp; double get speed; double get odo; double get range; String get mode; List<String> get faults; DateTime? get timestamp;
/// Create a copy of VehicleSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleSnapshotCopyWith<VehicleSnapshot> get copyWith => _$VehicleSnapshotCopyWithImpl<VehicleSnapshot>(this as VehicleSnapshot, _$identity);

  /// Serializes this VehicleSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleSnapshot&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.voltage, voltage) || other.voltage == voltage)&&(identical(other.current, current) || other.current == current)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.odo, odo) || other.odo == odo)&&(identical(other.range, range) || other.range == range)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.faults, faults)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,battery,voltage,current,temp,speed,odo,range,mode,const DeepCollectionEquality().hash(faults),timestamp);

@override
String toString() {
  return 'VehicleSnapshot(battery: $battery, voltage: $voltage, current: $current, temp: $temp, speed: $speed, odo: $odo, range: $range, mode: $mode, faults: $faults, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $VehicleSnapshotCopyWith<$Res>  {
  factory $VehicleSnapshotCopyWith(VehicleSnapshot value, $Res Function(VehicleSnapshot) _then) = _$VehicleSnapshotCopyWithImpl;
@useResult
$Res call({
 int battery, double voltage, double current, int temp, double speed, double odo, double range, String mode, List<String> faults, DateTime? timestamp
});




}
/// @nodoc
class _$VehicleSnapshotCopyWithImpl<$Res>
    implements $VehicleSnapshotCopyWith<$Res> {
  _$VehicleSnapshotCopyWithImpl(this._self, this._then);

  final VehicleSnapshot _self;
  final $Res Function(VehicleSnapshot) _then;

/// Create a copy of VehicleSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? battery = null,Object? voltage = null,Object? current = null,Object? temp = null,Object? speed = null,Object? odo = null,Object? range = null,Object? mode = null,Object? faults = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as int,voltage: null == voltage ? _self.voltage : voltage // ignore: cast_nullable_to_non_nullable
as double,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,odo: null == odo ? _self.odo : odo // ignore: cast_nullable_to_non_nullable
as double,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as double,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,faults: null == faults ? _self.faults : faults // ignore: cast_nullable_to_non_nullable
as List<String>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleSnapshot].
extension VehicleSnapshotPatterns on VehicleSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _VehicleSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int battery,  double voltage,  double current,  int temp,  double speed,  double odo,  double range,  String mode,  List<String> faults,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleSnapshot() when $default != null:
return $default(_that.battery,_that.voltage,_that.current,_that.temp,_that.speed,_that.odo,_that.range,_that.mode,_that.faults,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int battery,  double voltage,  double current,  int temp,  double speed,  double odo,  double range,  String mode,  List<String> faults,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _VehicleSnapshot():
return $default(_that.battery,_that.voltage,_that.current,_that.temp,_that.speed,_that.odo,_that.range,_that.mode,_that.faults,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int battery,  double voltage,  double current,  int temp,  double speed,  double odo,  double range,  String mode,  List<String> faults,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _VehicleSnapshot() when $default != null:
return $default(_that.battery,_that.voltage,_that.current,_that.temp,_that.speed,_that.odo,_that.range,_that.mode,_that.faults,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleSnapshot implements VehicleSnapshot {
  const _VehicleSnapshot({required this.battery, required this.voltage, required this.current, required this.temp, required this.speed, required this.odo, required this.range, required this.mode, final  List<String> faults = const [], this.timestamp}): _faults = faults;
  factory _VehicleSnapshot.fromJson(Map<String, dynamic> json) => _$VehicleSnapshotFromJson(json);

@override final  int battery;
@override final  double voltage;
@override final  double current;
@override final  int temp;
@override final  double speed;
@override final  double odo;
@override final  double range;
@override final  String mode;
 final  List<String> _faults;
@override@JsonKey() List<String> get faults {
  if (_faults is EqualUnmodifiableListView) return _faults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faults);
}

@override final  DateTime? timestamp;

/// Create a copy of VehicleSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleSnapshotCopyWith<_VehicleSnapshot> get copyWith => __$VehicleSnapshotCopyWithImpl<_VehicleSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleSnapshot&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.voltage, voltage) || other.voltage == voltage)&&(identical(other.current, current) || other.current == current)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.odo, odo) || other.odo == odo)&&(identical(other.range, range) || other.range == range)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._faults, _faults)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,battery,voltage,current,temp,speed,odo,range,mode,const DeepCollectionEquality().hash(_faults),timestamp);

@override
String toString() {
  return 'VehicleSnapshot(battery: $battery, voltage: $voltage, current: $current, temp: $temp, speed: $speed, odo: $odo, range: $range, mode: $mode, faults: $faults, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$VehicleSnapshotCopyWith<$Res> implements $VehicleSnapshotCopyWith<$Res> {
  factory _$VehicleSnapshotCopyWith(_VehicleSnapshot value, $Res Function(_VehicleSnapshot) _then) = __$VehicleSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int battery, double voltage, double current, int temp, double speed, double odo, double range, String mode, List<String> faults, DateTime? timestamp
});




}
/// @nodoc
class __$VehicleSnapshotCopyWithImpl<$Res>
    implements _$VehicleSnapshotCopyWith<$Res> {
  __$VehicleSnapshotCopyWithImpl(this._self, this._then);

  final _VehicleSnapshot _self;
  final $Res Function(_VehicleSnapshot) _then;

/// Create a copy of VehicleSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? battery = null,Object? voltage = null,Object? current = null,Object? temp = null,Object? speed = null,Object? odo = null,Object? range = null,Object? mode = null,Object? faults = null,Object? timestamp = freezed,}) {
  return _then(_VehicleSnapshot(
battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as int,voltage: null == voltage ? _self.voltage : voltage // ignore: cast_nullable_to_non_nullable
as double,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,odo: null == odo ? _self.odo : odo // ignore: cast_nullable_to_non_nullable
as double,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as double,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,faults: null == faults ? _self._faults : faults // ignore: cast_nullable_to_non_nullable
as List<String>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
