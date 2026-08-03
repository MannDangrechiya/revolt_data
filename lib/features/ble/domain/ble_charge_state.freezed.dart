// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_charge_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BleChargeState {

 BleChargeStatus get status; DateTime? get startTime; DateTime? get endTime; int get startBattery; int get currentBattery; int get batteryGained; double get kwhAdded; int get durationSeconds; int get peakBatteryTemp; double get peakPowerKw; ChargeLog? get lastSavedChargeLog;
/// Create a copy of BleChargeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BleChargeStateCopyWith<BleChargeState> get copyWith => _$BleChargeStateCopyWithImpl<BleChargeState>(this as BleChargeState, _$identity);

  /// Serializes this BleChargeState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleChargeState&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.startBattery, startBattery) || other.startBattery == startBattery)&&(identical(other.currentBattery, currentBattery) || other.currentBattery == currentBattery)&&(identical(other.batteryGained, batteryGained) || other.batteryGained == batteryGained)&&(identical(other.kwhAdded, kwhAdded) || other.kwhAdded == kwhAdded)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.peakBatteryTemp, peakBatteryTemp) || other.peakBatteryTemp == peakBatteryTemp)&&(identical(other.peakPowerKw, peakPowerKw) || other.peakPowerKw == peakPowerKw)&&(identical(other.lastSavedChargeLog, lastSavedChargeLog) || other.lastSavedChargeLog == lastSavedChargeLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,startTime,endTime,startBattery,currentBattery,batteryGained,kwhAdded,durationSeconds,peakBatteryTemp,peakPowerKw,lastSavedChargeLog);

@override
String toString() {
  return 'BleChargeState(status: $status, startTime: $startTime, endTime: $endTime, startBattery: $startBattery, currentBattery: $currentBattery, batteryGained: $batteryGained, kwhAdded: $kwhAdded, durationSeconds: $durationSeconds, peakBatteryTemp: $peakBatteryTemp, peakPowerKw: $peakPowerKw, lastSavedChargeLog: $lastSavedChargeLog)';
}


}

/// @nodoc
abstract mixin class $BleChargeStateCopyWith<$Res>  {
  factory $BleChargeStateCopyWith(BleChargeState value, $Res Function(BleChargeState) _then) = _$BleChargeStateCopyWithImpl;
@useResult
$Res call({
 BleChargeStatus status, DateTime? startTime, DateTime? endTime, int startBattery, int currentBattery, int batteryGained, double kwhAdded, int durationSeconds, int peakBatteryTemp, double peakPowerKw, ChargeLog? lastSavedChargeLog
});


$ChargeLogCopyWith<$Res>? get lastSavedChargeLog;

}
/// @nodoc
class _$BleChargeStateCopyWithImpl<$Res>
    implements $BleChargeStateCopyWith<$Res> {
  _$BleChargeStateCopyWithImpl(this._self, this._then);

  final BleChargeState _self;
  final $Res Function(BleChargeState) _then;

/// Create a copy of BleChargeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? startTime = freezed,Object? endTime = freezed,Object? startBattery = null,Object? currentBattery = null,Object? batteryGained = null,Object? kwhAdded = null,Object? durationSeconds = null,Object? peakBatteryTemp = null,Object? peakPowerKw = null,Object? lastSavedChargeLog = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BleChargeStatus,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,startBattery: null == startBattery ? _self.startBattery : startBattery // ignore: cast_nullable_to_non_nullable
as int,currentBattery: null == currentBattery ? _self.currentBattery : currentBattery // ignore: cast_nullable_to_non_nullable
as int,batteryGained: null == batteryGained ? _self.batteryGained : batteryGained // ignore: cast_nullable_to_non_nullable
as int,kwhAdded: null == kwhAdded ? _self.kwhAdded : kwhAdded // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,peakBatteryTemp: null == peakBatteryTemp ? _self.peakBatteryTemp : peakBatteryTemp // ignore: cast_nullable_to_non_nullable
as int,peakPowerKw: null == peakPowerKw ? _self.peakPowerKw : peakPowerKw // ignore: cast_nullable_to_non_nullable
as double,lastSavedChargeLog: freezed == lastSavedChargeLog ? _self.lastSavedChargeLog : lastSavedChargeLog // ignore: cast_nullable_to_non_nullable
as ChargeLog?,
  ));
}
/// Create a copy of BleChargeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChargeLogCopyWith<$Res>? get lastSavedChargeLog {
    if (_self.lastSavedChargeLog == null) {
    return null;
  }

  return $ChargeLogCopyWith<$Res>(_self.lastSavedChargeLog!, (value) {
    return _then(_self.copyWith(lastSavedChargeLog: value));
  });
}
}


/// Adds pattern-matching-related methods to [BleChargeState].
extension BleChargeStatePatterns on BleChargeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BleChargeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BleChargeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BleChargeState value)  $default,){
final _that = this;
switch (_that) {
case _BleChargeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BleChargeState value)?  $default,){
final _that = this;
switch (_that) {
case _BleChargeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BleChargeStatus status,  DateTime? startTime,  DateTime? endTime,  int startBattery,  int currentBattery,  int batteryGained,  double kwhAdded,  int durationSeconds,  int peakBatteryTemp,  double peakPowerKw,  ChargeLog? lastSavedChargeLog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BleChargeState() when $default != null:
return $default(_that.status,_that.startTime,_that.endTime,_that.startBattery,_that.currentBattery,_that.batteryGained,_that.kwhAdded,_that.durationSeconds,_that.peakBatteryTemp,_that.peakPowerKw,_that.lastSavedChargeLog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BleChargeStatus status,  DateTime? startTime,  DateTime? endTime,  int startBattery,  int currentBattery,  int batteryGained,  double kwhAdded,  int durationSeconds,  int peakBatteryTemp,  double peakPowerKw,  ChargeLog? lastSavedChargeLog)  $default,) {final _that = this;
switch (_that) {
case _BleChargeState():
return $default(_that.status,_that.startTime,_that.endTime,_that.startBattery,_that.currentBattery,_that.batteryGained,_that.kwhAdded,_that.durationSeconds,_that.peakBatteryTemp,_that.peakPowerKw,_that.lastSavedChargeLog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BleChargeStatus status,  DateTime? startTime,  DateTime? endTime,  int startBattery,  int currentBattery,  int batteryGained,  double kwhAdded,  int durationSeconds,  int peakBatteryTemp,  double peakPowerKw,  ChargeLog? lastSavedChargeLog)?  $default,) {final _that = this;
switch (_that) {
case _BleChargeState() when $default != null:
return $default(_that.status,_that.startTime,_that.endTime,_that.startBattery,_that.currentBattery,_that.batteryGained,_that.kwhAdded,_that.durationSeconds,_that.peakBatteryTemp,_that.peakPowerKw,_that.lastSavedChargeLog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BleChargeState implements BleChargeState {
  const _BleChargeState({this.status = BleChargeStatus.idle, this.startTime, this.endTime, this.startBattery = 0, this.currentBattery = 0, this.batteryGained = 0, this.kwhAdded = 0.0, this.durationSeconds = 0, this.peakBatteryTemp = 0, this.peakPowerKw = 0.0, this.lastSavedChargeLog});
  factory _BleChargeState.fromJson(Map<String, dynamic> json) => _$BleChargeStateFromJson(json);

@override@JsonKey() final  BleChargeStatus status;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override@JsonKey() final  int startBattery;
@override@JsonKey() final  int currentBattery;
@override@JsonKey() final  int batteryGained;
@override@JsonKey() final  double kwhAdded;
@override@JsonKey() final  int durationSeconds;
@override@JsonKey() final  int peakBatteryTemp;
@override@JsonKey() final  double peakPowerKw;
@override final  ChargeLog? lastSavedChargeLog;

/// Create a copy of BleChargeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BleChargeStateCopyWith<_BleChargeState> get copyWith => __$BleChargeStateCopyWithImpl<_BleChargeState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BleChargeStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BleChargeState&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.startBattery, startBattery) || other.startBattery == startBattery)&&(identical(other.currentBattery, currentBattery) || other.currentBattery == currentBattery)&&(identical(other.batteryGained, batteryGained) || other.batteryGained == batteryGained)&&(identical(other.kwhAdded, kwhAdded) || other.kwhAdded == kwhAdded)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.peakBatteryTemp, peakBatteryTemp) || other.peakBatteryTemp == peakBatteryTemp)&&(identical(other.peakPowerKw, peakPowerKw) || other.peakPowerKw == peakPowerKw)&&(identical(other.lastSavedChargeLog, lastSavedChargeLog) || other.lastSavedChargeLog == lastSavedChargeLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,startTime,endTime,startBattery,currentBattery,batteryGained,kwhAdded,durationSeconds,peakBatteryTemp,peakPowerKw,lastSavedChargeLog);

@override
String toString() {
  return 'BleChargeState(status: $status, startTime: $startTime, endTime: $endTime, startBattery: $startBattery, currentBattery: $currentBattery, batteryGained: $batteryGained, kwhAdded: $kwhAdded, durationSeconds: $durationSeconds, peakBatteryTemp: $peakBatteryTemp, peakPowerKw: $peakPowerKw, lastSavedChargeLog: $lastSavedChargeLog)';
}


}

/// @nodoc
abstract mixin class _$BleChargeStateCopyWith<$Res> implements $BleChargeStateCopyWith<$Res> {
  factory _$BleChargeStateCopyWith(_BleChargeState value, $Res Function(_BleChargeState) _then) = __$BleChargeStateCopyWithImpl;
@override @useResult
$Res call({
 BleChargeStatus status, DateTime? startTime, DateTime? endTime, int startBattery, int currentBattery, int batteryGained, double kwhAdded, int durationSeconds, int peakBatteryTemp, double peakPowerKw, ChargeLog? lastSavedChargeLog
});


@override $ChargeLogCopyWith<$Res>? get lastSavedChargeLog;

}
/// @nodoc
class __$BleChargeStateCopyWithImpl<$Res>
    implements _$BleChargeStateCopyWith<$Res> {
  __$BleChargeStateCopyWithImpl(this._self, this._then);

  final _BleChargeState _self;
  final $Res Function(_BleChargeState) _then;

/// Create a copy of BleChargeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? startTime = freezed,Object? endTime = freezed,Object? startBattery = null,Object? currentBattery = null,Object? batteryGained = null,Object? kwhAdded = null,Object? durationSeconds = null,Object? peakBatteryTemp = null,Object? peakPowerKw = null,Object? lastSavedChargeLog = freezed,}) {
  return _then(_BleChargeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BleChargeStatus,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,startBattery: null == startBattery ? _self.startBattery : startBattery // ignore: cast_nullable_to_non_nullable
as int,currentBattery: null == currentBattery ? _self.currentBattery : currentBattery // ignore: cast_nullable_to_non_nullable
as int,batteryGained: null == batteryGained ? _self.batteryGained : batteryGained // ignore: cast_nullable_to_non_nullable
as int,kwhAdded: null == kwhAdded ? _self.kwhAdded : kwhAdded // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,peakBatteryTemp: null == peakBatteryTemp ? _self.peakBatteryTemp : peakBatteryTemp // ignore: cast_nullable_to_non_nullable
as int,peakPowerKw: null == peakPowerKw ? _self.peakPowerKw : peakPowerKw // ignore: cast_nullable_to_non_nullable
as double,lastSavedChargeLog: freezed == lastSavedChargeLog ? _self.lastSavedChargeLog : lastSavedChargeLog // ignore: cast_nullable_to_non_nullable
as ChargeLog?,
  ));
}

/// Create a copy of BleChargeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChargeLogCopyWith<$Res>? get lastSavedChargeLog {
    if (_self.lastSavedChargeLog == null) {
    return null;
  }

  return $ChargeLogCopyWith<$Res>(_self.lastSavedChargeLog!, (value) {
    return _then(_self.copyWith(lastSavedChargeLog: value));
  });
}
}

// dart format on
