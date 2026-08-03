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

 int get batteryPercent; double get batteryVoltage; double get batteryCurrent; int get batteryTemp; int get motorTemp; double get speed; double get tripDistance; double get odometer; String get rideMode; double get range; double get power; List<String> get faultCodes; int? get batteryHealth; String? get gpsCoords; DateTime? get timestamp;
/// Create a copy of VehicleSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleSnapshotCopyWith<VehicleSnapshot> get copyWith => _$VehicleSnapshotCopyWithImpl<VehicleSnapshot>(this as VehicleSnapshot, _$identity);

  /// Serializes this VehicleSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleSnapshot&&(identical(other.batteryPercent, batteryPercent) || other.batteryPercent == batteryPercent)&&(identical(other.batteryVoltage, batteryVoltage) || other.batteryVoltage == batteryVoltage)&&(identical(other.batteryCurrent, batteryCurrent) || other.batteryCurrent == batteryCurrent)&&(identical(other.batteryTemp, batteryTemp) || other.batteryTemp == batteryTemp)&&(identical(other.motorTemp, motorTemp) || other.motorTemp == motorTemp)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.tripDistance, tripDistance) || other.tripDistance == tripDistance)&&(identical(other.odometer, odometer) || other.odometer == odometer)&&(identical(other.rideMode, rideMode) || other.rideMode == rideMode)&&(identical(other.range, range) || other.range == range)&&(identical(other.power, power) || other.power == power)&&const DeepCollectionEquality().equals(other.faultCodes, faultCodes)&&(identical(other.batteryHealth, batteryHealth) || other.batteryHealth == batteryHealth)&&(identical(other.gpsCoords, gpsCoords) || other.gpsCoords == gpsCoords)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,batteryPercent,batteryVoltage,batteryCurrent,batteryTemp,motorTemp,speed,tripDistance,odometer,rideMode,range,power,const DeepCollectionEquality().hash(faultCodes),batteryHealth,gpsCoords,timestamp);

@override
String toString() {
  return 'VehicleSnapshot(batteryPercent: $batteryPercent, batteryVoltage: $batteryVoltage, batteryCurrent: $batteryCurrent, batteryTemp: $batteryTemp, motorTemp: $motorTemp, speed: $speed, tripDistance: $tripDistance, odometer: $odometer, rideMode: $rideMode, range: $range, power: $power, faultCodes: $faultCodes, batteryHealth: $batteryHealth, gpsCoords: $gpsCoords, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $VehicleSnapshotCopyWith<$Res>  {
  factory $VehicleSnapshotCopyWith(VehicleSnapshot value, $Res Function(VehicleSnapshot) _then) = _$VehicleSnapshotCopyWithImpl;
@useResult
$Res call({
 int batteryPercent, double batteryVoltage, double batteryCurrent, int batteryTemp, int motorTemp, double speed, double tripDistance, double odometer, String rideMode, double range, double power, List<String> faultCodes, int? batteryHealth, String? gpsCoords, DateTime? timestamp
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
@pragma('vm:prefer-inline') @override $Res call({Object? batteryPercent = null,Object? batteryVoltage = null,Object? batteryCurrent = null,Object? batteryTemp = null,Object? motorTemp = null,Object? speed = null,Object? tripDistance = null,Object? odometer = null,Object? rideMode = null,Object? range = null,Object? power = null,Object? faultCodes = null,Object? batteryHealth = freezed,Object? gpsCoords = freezed,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
batteryPercent: null == batteryPercent ? _self.batteryPercent : batteryPercent // ignore: cast_nullable_to_non_nullable
as int,batteryVoltage: null == batteryVoltage ? _self.batteryVoltage : batteryVoltage // ignore: cast_nullable_to_non_nullable
as double,batteryCurrent: null == batteryCurrent ? _self.batteryCurrent : batteryCurrent // ignore: cast_nullable_to_non_nullable
as double,batteryTemp: null == batteryTemp ? _self.batteryTemp : batteryTemp // ignore: cast_nullable_to_non_nullable
as int,motorTemp: null == motorTemp ? _self.motorTemp : motorTemp // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,tripDistance: null == tripDistance ? _self.tripDistance : tripDistance // ignore: cast_nullable_to_non_nullable
as double,odometer: null == odometer ? _self.odometer : odometer // ignore: cast_nullable_to_non_nullable
as double,rideMode: null == rideMode ? _self.rideMode : rideMode // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as double,power: null == power ? _self.power : power // ignore: cast_nullable_to_non_nullable
as double,faultCodes: null == faultCodes ? _self.faultCodes : faultCodes // ignore: cast_nullable_to_non_nullable
as List<String>,batteryHealth: freezed == batteryHealth ? _self.batteryHealth : batteryHealth // ignore: cast_nullable_to_non_nullable
as int?,gpsCoords: freezed == gpsCoords ? _self.gpsCoords : gpsCoords // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int batteryPercent,  double batteryVoltage,  double batteryCurrent,  int batteryTemp,  int motorTemp,  double speed,  double tripDistance,  double odometer,  String rideMode,  double range,  double power,  List<String> faultCodes,  int? batteryHealth,  String? gpsCoords,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleSnapshot() when $default != null:
return $default(_that.batteryPercent,_that.batteryVoltage,_that.batteryCurrent,_that.batteryTemp,_that.motorTemp,_that.speed,_that.tripDistance,_that.odometer,_that.rideMode,_that.range,_that.power,_that.faultCodes,_that.batteryHealth,_that.gpsCoords,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int batteryPercent,  double batteryVoltage,  double batteryCurrent,  int batteryTemp,  int motorTemp,  double speed,  double tripDistance,  double odometer,  String rideMode,  double range,  double power,  List<String> faultCodes,  int? batteryHealth,  String? gpsCoords,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _VehicleSnapshot():
return $default(_that.batteryPercent,_that.batteryVoltage,_that.batteryCurrent,_that.batteryTemp,_that.motorTemp,_that.speed,_that.tripDistance,_that.odometer,_that.rideMode,_that.range,_that.power,_that.faultCodes,_that.batteryHealth,_that.gpsCoords,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int batteryPercent,  double batteryVoltage,  double batteryCurrent,  int batteryTemp,  int motorTemp,  double speed,  double tripDistance,  double odometer,  String rideMode,  double range,  double power,  List<String> faultCodes,  int? batteryHealth,  String? gpsCoords,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _VehicleSnapshot() when $default != null:
return $default(_that.batteryPercent,_that.batteryVoltage,_that.batteryCurrent,_that.batteryTemp,_that.motorTemp,_that.speed,_that.tripDistance,_that.odometer,_that.rideMode,_that.range,_that.power,_that.faultCodes,_that.batteryHealth,_that.gpsCoords,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleSnapshot implements VehicleSnapshot {
  const _VehicleSnapshot({required this.batteryPercent, required this.batteryVoltage, required this.batteryCurrent, required this.batteryTemp, required this.motorTemp, required this.speed, required this.tripDistance, required this.odometer, required this.rideMode, required this.range, required this.power, final  List<String> faultCodes = const [], this.batteryHealth, this.gpsCoords, this.timestamp}): _faultCodes = faultCodes;
  factory _VehicleSnapshot.fromJson(Map<String, dynamic> json) => _$VehicleSnapshotFromJson(json);

@override final  int batteryPercent;
@override final  double batteryVoltage;
@override final  double batteryCurrent;
@override final  int batteryTemp;
@override final  int motorTemp;
@override final  double speed;
@override final  double tripDistance;
@override final  double odometer;
@override final  String rideMode;
@override final  double range;
@override final  double power;
 final  List<String> _faultCodes;
@override@JsonKey() List<String> get faultCodes {
  if (_faultCodes is EqualUnmodifiableListView) return _faultCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faultCodes);
}

@override final  int? batteryHealth;
@override final  String? gpsCoords;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleSnapshot&&(identical(other.batteryPercent, batteryPercent) || other.batteryPercent == batteryPercent)&&(identical(other.batteryVoltage, batteryVoltage) || other.batteryVoltage == batteryVoltage)&&(identical(other.batteryCurrent, batteryCurrent) || other.batteryCurrent == batteryCurrent)&&(identical(other.batteryTemp, batteryTemp) || other.batteryTemp == batteryTemp)&&(identical(other.motorTemp, motorTemp) || other.motorTemp == motorTemp)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.tripDistance, tripDistance) || other.tripDistance == tripDistance)&&(identical(other.odometer, odometer) || other.odometer == odometer)&&(identical(other.rideMode, rideMode) || other.rideMode == rideMode)&&(identical(other.range, range) || other.range == range)&&(identical(other.power, power) || other.power == power)&&const DeepCollectionEquality().equals(other._faultCodes, _faultCodes)&&(identical(other.batteryHealth, batteryHealth) || other.batteryHealth == batteryHealth)&&(identical(other.gpsCoords, gpsCoords) || other.gpsCoords == gpsCoords)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,batteryPercent,batteryVoltage,batteryCurrent,batteryTemp,motorTemp,speed,tripDistance,odometer,rideMode,range,power,const DeepCollectionEquality().hash(_faultCodes),batteryHealth,gpsCoords,timestamp);

@override
String toString() {
  return 'VehicleSnapshot(batteryPercent: $batteryPercent, batteryVoltage: $batteryVoltage, batteryCurrent: $batteryCurrent, batteryTemp: $batteryTemp, motorTemp: $motorTemp, speed: $speed, tripDistance: $tripDistance, odometer: $odometer, rideMode: $rideMode, range: $range, power: $power, faultCodes: $faultCodes, batteryHealth: $batteryHealth, gpsCoords: $gpsCoords, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$VehicleSnapshotCopyWith<$Res> implements $VehicleSnapshotCopyWith<$Res> {
  factory _$VehicleSnapshotCopyWith(_VehicleSnapshot value, $Res Function(_VehicleSnapshot) _then) = __$VehicleSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int batteryPercent, double batteryVoltage, double batteryCurrent, int batteryTemp, int motorTemp, double speed, double tripDistance, double odometer, String rideMode, double range, double power, List<String> faultCodes, int? batteryHealth, String? gpsCoords, DateTime? timestamp
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
@override @pragma('vm:prefer-inline') $Res call({Object? batteryPercent = null,Object? batteryVoltage = null,Object? batteryCurrent = null,Object? batteryTemp = null,Object? motorTemp = null,Object? speed = null,Object? tripDistance = null,Object? odometer = null,Object? rideMode = null,Object? range = null,Object? power = null,Object? faultCodes = null,Object? batteryHealth = freezed,Object? gpsCoords = freezed,Object? timestamp = freezed,}) {
  return _then(_VehicleSnapshot(
batteryPercent: null == batteryPercent ? _self.batteryPercent : batteryPercent // ignore: cast_nullable_to_non_nullable
as int,batteryVoltage: null == batteryVoltage ? _self.batteryVoltage : batteryVoltage // ignore: cast_nullable_to_non_nullable
as double,batteryCurrent: null == batteryCurrent ? _self.batteryCurrent : batteryCurrent // ignore: cast_nullable_to_non_nullable
as double,batteryTemp: null == batteryTemp ? _self.batteryTemp : batteryTemp // ignore: cast_nullable_to_non_nullable
as int,motorTemp: null == motorTemp ? _self.motorTemp : motorTemp // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,tripDistance: null == tripDistance ? _self.tripDistance : tripDistance // ignore: cast_nullable_to_non_nullable
as double,odometer: null == odometer ? _self.odometer : odometer // ignore: cast_nullable_to_non_nullable
as double,rideMode: null == rideMode ? _self.rideMode : rideMode // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as double,power: null == power ? _self.power : power // ignore: cast_nullable_to_non_nullable
as double,faultCodes: null == faultCodes ? _self._faultCodes : faultCodes // ignore: cast_nullable_to_non_nullable
as List<String>,batteryHealth: freezed == batteryHealth ? _self.batteryHealth : batteryHealth // ignore: cast_nullable_to_non_nullable
as int?,gpsCoords: freezed == gpsCoords ? _self.gpsCoords : gpsCoords // ignore: cast_nullable_to_non_nullable
as String?,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
