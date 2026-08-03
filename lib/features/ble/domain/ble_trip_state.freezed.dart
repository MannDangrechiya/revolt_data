// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_trip_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BleTripState {

 BleTripStatus get status; DateTime? get startTime; DateTime? get endTime; double get startOdometer; double get currentOdometer; double get distance; int get durationSeconds; double get currentSpeed; double get averageSpeed; double get maxSpeed; int get startBattery; int get currentBattery; String get currentRideMode; Ride? get lastSavedRide;
/// Create a copy of BleTripState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BleTripStateCopyWith<BleTripState> get copyWith => _$BleTripStateCopyWithImpl<BleTripState>(this as BleTripState, _$identity);

  /// Serializes this BleTripState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleTripState&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.startOdometer, startOdometer) || other.startOdometer == startOdometer)&&(identical(other.currentOdometer, currentOdometer) || other.currentOdometer == currentOdometer)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.currentSpeed, currentSpeed) || other.currentSpeed == currentSpeed)&&(identical(other.averageSpeed, averageSpeed) || other.averageSpeed == averageSpeed)&&(identical(other.maxSpeed, maxSpeed) || other.maxSpeed == maxSpeed)&&(identical(other.startBattery, startBattery) || other.startBattery == startBattery)&&(identical(other.currentBattery, currentBattery) || other.currentBattery == currentBattery)&&(identical(other.currentRideMode, currentRideMode) || other.currentRideMode == currentRideMode)&&(identical(other.lastSavedRide, lastSavedRide) || other.lastSavedRide == lastSavedRide));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,startTime,endTime,startOdometer,currentOdometer,distance,durationSeconds,currentSpeed,averageSpeed,maxSpeed,startBattery,currentBattery,currentRideMode,lastSavedRide);

@override
String toString() {
  return 'BleTripState(status: $status, startTime: $startTime, endTime: $endTime, startOdometer: $startOdometer, currentOdometer: $currentOdometer, distance: $distance, durationSeconds: $durationSeconds, currentSpeed: $currentSpeed, averageSpeed: $averageSpeed, maxSpeed: $maxSpeed, startBattery: $startBattery, currentBattery: $currentBattery, currentRideMode: $currentRideMode, lastSavedRide: $lastSavedRide)';
}


}

/// @nodoc
abstract mixin class $BleTripStateCopyWith<$Res>  {
  factory $BleTripStateCopyWith(BleTripState value, $Res Function(BleTripState) _then) = _$BleTripStateCopyWithImpl;
@useResult
$Res call({
 BleTripStatus status, DateTime? startTime, DateTime? endTime, double startOdometer, double currentOdometer, double distance, int durationSeconds, double currentSpeed, double averageSpeed, double maxSpeed, int startBattery, int currentBattery, String currentRideMode, Ride? lastSavedRide
});


$RideCopyWith<$Res>? get lastSavedRide;

}
/// @nodoc
class _$BleTripStateCopyWithImpl<$Res>
    implements $BleTripStateCopyWith<$Res> {
  _$BleTripStateCopyWithImpl(this._self, this._then);

  final BleTripState _self;
  final $Res Function(BleTripState) _then;

/// Create a copy of BleTripState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? startTime = freezed,Object? endTime = freezed,Object? startOdometer = null,Object? currentOdometer = null,Object? distance = null,Object? durationSeconds = null,Object? currentSpeed = null,Object? averageSpeed = null,Object? maxSpeed = null,Object? startBattery = null,Object? currentBattery = null,Object? currentRideMode = null,Object? lastSavedRide = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BleTripStatus,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,startOdometer: null == startOdometer ? _self.startOdometer : startOdometer // ignore: cast_nullable_to_non_nullable
as double,currentOdometer: null == currentOdometer ? _self.currentOdometer : currentOdometer // ignore: cast_nullable_to_non_nullable
as double,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,currentSpeed: null == currentSpeed ? _self.currentSpeed : currentSpeed // ignore: cast_nullable_to_non_nullable
as double,averageSpeed: null == averageSpeed ? _self.averageSpeed : averageSpeed // ignore: cast_nullable_to_non_nullable
as double,maxSpeed: null == maxSpeed ? _self.maxSpeed : maxSpeed // ignore: cast_nullable_to_non_nullable
as double,startBattery: null == startBattery ? _self.startBattery : startBattery // ignore: cast_nullable_to_non_nullable
as int,currentBattery: null == currentBattery ? _self.currentBattery : currentBattery // ignore: cast_nullable_to_non_nullable
as int,currentRideMode: null == currentRideMode ? _self.currentRideMode : currentRideMode // ignore: cast_nullable_to_non_nullable
as String,lastSavedRide: freezed == lastSavedRide ? _self.lastSavedRide : lastSavedRide // ignore: cast_nullable_to_non_nullable
as Ride?,
  ));
}
/// Create a copy of BleTripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideCopyWith<$Res>? get lastSavedRide {
    if (_self.lastSavedRide == null) {
    return null;
  }

  return $RideCopyWith<$Res>(_self.lastSavedRide!, (value) {
    return _then(_self.copyWith(lastSavedRide: value));
  });
}
}


/// Adds pattern-matching-related methods to [BleTripState].
extension BleTripStatePatterns on BleTripState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BleTripState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BleTripState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BleTripState value)  $default,){
final _that = this;
switch (_that) {
case _BleTripState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BleTripState value)?  $default,){
final _that = this;
switch (_that) {
case _BleTripState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BleTripStatus status,  DateTime? startTime,  DateTime? endTime,  double startOdometer,  double currentOdometer,  double distance,  int durationSeconds,  double currentSpeed,  double averageSpeed,  double maxSpeed,  int startBattery,  int currentBattery,  String currentRideMode,  Ride? lastSavedRide)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BleTripState() when $default != null:
return $default(_that.status,_that.startTime,_that.endTime,_that.startOdometer,_that.currentOdometer,_that.distance,_that.durationSeconds,_that.currentSpeed,_that.averageSpeed,_that.maxSpeed,_that.startBattery,_that.currentBattery,_that.currentRideMode,_that.lastSavedRide);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BleTripStatus status,  DateTime? startTime,  DateTime? endTime,  double startOdometer,  double currentOdometer,  double distance,  int durationSeconds,  double currentSpeed,  double averageSpeed,  double maxSpeed,  int startBattery,  int currentBattery,  String currentRideMode,  Ride? lastSavedRide)  $default,) {final _that = this;
switch (_that) {
case _BleTripState():
return $default(_that.status,_that.startTime,_that.endTime,_that.startOdometer,_that.currentOdometer,_that.distance,_that.durationSeconds,_that.currentSpeed,_that.averageSpeed,_that.maxSpeed,_that.startBattery,_that.currentBattery,_that.currentRideMode,_that.lastSavedRide);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BleTripStatus status,  DateTime? startTime,  DateTime? endTime,  double startOdometer,  double currentOdometer,  double distance,  int durationSeconds,  double currentSpeed,  double averageSpeed,  double maxSpeed,  int startBattery,  int currentBattery,  String currentRideMode,  Ride? lastSavedRide)?  $default,) {final _that = this;
switch (_that) {
case _BleTripState() when $default != null:
return $default(_that.status,_that.startTime,_that.endTime,_that.startOdometer,_that.currentOdometer,_that.distance,_that.durationSeconds,_that.currentSpeed,_that.averageSpeed,_that.maxSpeed,_that.startBattery,_that.currentBattery,_that.currentRideMode,_that.lastSavedRide);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BleTripState implements BleTripState {
  const _BleTripState({this.status = BleTripStatus.idle, this.startTime, this.endTime, this.startOdometer = 0.0, this.currentOdometer = 0.0, this.distance = 0.0, this.durationSeconds = 0, this.currentSpeed = 0.0, this.averageSpeed = 0.0, this.maxSpeed = 0.0, this.startBattery = 0, this.currentBattery = 0, this.currentRideMode = 'Eco', this.lastSavedRide});
  factory _BleTripState.fromJson(Map<String, dynamic> json) => _$BleTripStateFromJson(json);

@override@JsonKey() final  BleTripStatus status;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override@JsonKey() final  double startOdometer;
@override@JsonKey() final  double currentOdometer;
@override@JsonKey() final  double distance;
@override@JsonKey() final  int durationSeconds;
@override@JsonKey() final  double currentSpeed;
@override@JsonKey() final  double averageSpeed;
@override@JsonKey() final  double maxSpeed;
@override@JsonKey() final  int startBattery;
@override@JsonKey() final  int currentBattery;
@override@JsonKey() final  String currentRideMode;
@override final  Ride? lastSavedRide;

/// Create a copy of BleTripState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BleTripStateCopyWith<_BleTripState> get copyWith => __$BleTripStateCopyWithImpl<_BleTripState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BleTripStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BleTripState&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.startOdometer, startOdometer) || other.startOdometer == startOdometer)&&(identical(other.currentOdometer, currentOdometer) || other.currentOdometer == currentOdometer)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.currentSpeed, currentSpeed) || other.currentSpeed == currentSpeed)&&(identical(other.averageSpeed, averageSpeed) || other.averageSpeed == averageSpeed)&&(identical(other.maxSpeed, maxSpeed) || other.maxSpeed == maxSpeed)&&(identical(other.startBattery, startBattery) || other.startBattery == startBattery)&&(identical(other.currentBattery, currentBattery) || other.currentBattery == currentBattery)&&(identical(other.currentRideMode, currentRideMode) || other.currentRideMode == currentRideMode)&&(identical(other.lastSavedRide, lastSavedRide) || other.lastSavedRide == lastSavedRide));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,startTime,endTime,startOdometer,currentOdometer,distance,durationSeconds,currentSpeed,averageSpeed,maxSpeed,startBattery,currentBattery,currentRideMode,lastSavedRide);

@override
String toString() {
  return 'BleTripState(status: $status, startTime: $startTime, endTime: $endTime, startOdometer: $startOdometer, currentOdometer: $currentOdometer, distance: $distance, durationSeconds: $durationSeconds, currentSpeed: $currentSpeed, averageSpeed: $averageSpeed, maxSpeed: $maxSpeed, startBattery: $startBattery, currentBattery: $currentBattery, currentRideMode: $currentRideMode, lastSavedRide: $lastSavedRide)';
}


}

/// @nodoc
abstract mixin class _$BleTripStateCopyWith<$Res> implements $BleTripStateCopyWith<$Res> {
  factory _$BleTripStateCopyWith(_BleTripState value, $Res Function(_BleTripState) _then) = __$BleTripStateCopyWithImpl;
@override @useResult
$Res call({
 BleTripStatus status, DateTime? startTime, DateTime? endTime, double startOdometer, double currentOdometer, double distance, int durationSeconds, double currentSpeed, double averageSpeed, double maxSpeed, int startBattery, int currentBattery, String currentRideMode, Ride? lastSavedRide
});


@override $RideCopyWith<$Res>? get lastSavedRide;

}
/// @nodoc
class __$BleTripStateCopyWithImpl<$Res>
    implements _$BleTripStateCopyWith<$Res> {
  __$BleTripStateCopyWithImpl(this._self, this._then);

  final _BleTripState _self;
  final $Res Function(_BleTripState) _then;

/// Create a copy of BleTripState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? startTime = freezed,Object? endTime = freezed,Object? startOdometer = null,Object? currentOdometer = null,Object? distance = null,Object? durationSeconds = null,Object? currentSpeed = null,Object? averageSpeed = null,Object? maxSpeed = null,Object? startBattery = null,Object? currentBattery = null,Object? currentRideMode = null,Object? lastSavedRide = freezed,}) {
  return _then(_BleTripState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BleTripStatus,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,startOdometer: null == startOdometer ? _self.startOdometer : startOdometer // ignore: cast_nullable_to_non_nullable
as double,currentOdometer: null == currentOdometer ? _self.currentOdometer : currentOdometer // ignore: cast_nullable_to_non_nullable
as double,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,currentSpeed: null == currentSpeed ? _self.currentSpeed : currentSpeed // ignore: cast_nullable_to_non_nullable
as double,averageSpeed: null == averageSpeed ? _self.averageSpeed : averageSpeed // ignore: cast_nullable_to_non_nullable
as double,maxSpeed: null == maxSpeed ? _self.maxSpeed : maxSpeed // ignore: cast_nullable_to_non_nullable
as double,startBattery: null == startBattery ? _self.startBattery : startBattery // ignore: cast_nullable_to_non_nullable
as int,currentBattery: null == currentBattery ? _self.currentBattery : currentBattery // ignore: cast_nullable_to_non_nullable
as int,currentRideMode: null == currentRideMode ? _self.currentRideMode : currentRideMode // ignore: cast_nullable_to_non_nullable
as String,lastSavedRide: freezed == lastSavedRide ? _self.lastSavedRide : lastSavedRide // ignore: cast_nullable_to_non_nullable
as Ride?,
  ));
}

/// Create a copy of BleTripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideCopyWith<$Res>? get lastSavedRide {
    if (_self.lastSavedRide == null) {
    return null;
  }

  return $RideCopyWith<$Res>(_self.lastSavedRide!, (value) {
    return _then(_self.copyWith(lastSavedRide: value));
  });
}
}

// dart format on
