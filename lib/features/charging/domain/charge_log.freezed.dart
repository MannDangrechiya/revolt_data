// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'charge_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChargeLog {

 String get id; DateTime get date; double get durationMinutes; double get kwhAdded; double get cost; PaymentMethod get paymentMethod; LocationType get locationType; int get startBattery; int get endBattery; String? get locationName; String? get notes; DateTime? get startTime; DateTime? get endTime; String? get chargerType; String? get chargingMethod; double? get electricityPrice; String? get providerName; double? get maxChargingPowerKw; List<String> get photoPaths; int? get bikeId; String get source;
/// Create a copy of ChargeLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChargeLogCopyWith<ChargeLog> get copyWith => _$ChargeLogCopyWithImpl<ChargeLog>(this as ChargeLog, _$identity);

  /// Serializes this ChargeLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChargeLog&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.kwhAdded, kwhAdded) || other.kwhAdded == kwhAdded)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.startBattery, startBattery) || other.startBattery == startBattery)&&(identical(other.endBattery, endBattery) || other.endBattery == endBattery)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.chargerType, chargerType) || other.chargerType == chargerType)&&(identical(other.chargingMethod, chargingMethod) || other.chargingMethod == chargingMethod)&&(identical(other.electricityPrice, electricityPrice) || other.electricityPrice == electricityPrice)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.maxChargingPowerKw, maxChargingPowerKw) || other.maxChargingPowerKw == maxChargingPowerKw)&&const DeepCollectionEquality().equals(other.photoPaths, photoPaths)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,date,durationMinutes,kwhAdded,cost,paymentMethod,locationType,startBattery,endBattery,locationName,notes,startTime,endTime,chargerType,chargingMethod,electricityPrice,providerName,maxChargingPowerKw,const DeepCollectionEquality().hash(photoPaths),bikeId,source]);

@override
String toString() {
  return 'ChargeLog(id: $id, date: $date, durationMinutes: $durationMinutes, kwhAdded: $kwhAdded, cost: $cost, paymentMethod: $paymentMethod, locationType: $locationType, startBattery: $startBattery, endBattery: $endBattery, locationName: $locationName, notes: $notes, startTime: $startTime, endTime: $endTime, chargerType: $chargerType, chargingMethod: $chargingMethod, electricityPrice: $electricityPrice, providerName: $providerName, maxChargingPowerKw: $maxChargingPowerKw, photoPaths: $photoPaths, bikeId: $bikeId, source: $source)';
}


}

/// @nodoc
abstract mixin class $ChargeLogCopyWith<$Res>  {
  factory $ChargeLogCopyWith(ChargeLog value, $Res Function(ChargeLog) _then) = _$ChargeLogCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, double durationMinutes, double kwhAdded, double cost, PaymentMethod paymentMethod, LocationType locationType, int startBattery, int endBattery, String? locationName, String? notes, DateTime? startTime, DateTime? endTime, String? chargerType, String? chargingMethod, double? electricityPrice, String? providerName, double? maxChargingPowerKw, List<String> photoPaths, int? bikeId, String source
});




}
/// @nodoc
class _$ChargeLogCopyWithImpl<$Res>
    implements $ChargeLogCopyWith<$Res> {
  _$ChargeLogCopyWithImpl(this._self, this._then);

  final ChargeLog _self;
  final $Res Function(ChargeLog) _then;

/// Create a copy of ChargeLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? durationMinutes = null,Object? kwhAdded = null,Object? cost = null,Object? paymentMethod = null,Object? locationType = null,Object? startBattery = null,Object? endBattery = null,Object? locationName = freezed,Object? notes = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? chargerType = freezed,Object? chargingMethod = freezed,Object? electricityPrice = freezed,Object? providerName = freezed,Object? maxChargingPowerKw = freezed,Object? photoPaths = null,Object? bikeId = freezed,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as double,kwhAdded: null == kwhAdded ? _self.kwhAdded : kwhAdded // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,locationType: null == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as LocationType,startBattery: null == startBattery ? _self.startBattery : startBattery // ignore: cast_nullable_to_non_nullable
as int,endBattery: null == endBattery ? _self.endBattery : endBattery // ignore: cast_nullable_to_non_nullable
as int,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,chargerType: freezed == chargerType ? _self.chargerType : chargerType // ignore: cast_nullable_to_non_nullable
as String?,chargingMethod: freezed == chargingMethod ? _self.chargingMethod : chargingMethod // ignore: cast_nullable_to_non_nullable
as String?,electricityPrice: freezed == electricityPrice ? _self.electricityPrice : electricityPrice // ignore: cast_nullable_to_non_nullable
as double?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,maxChargingPowerKw: freezed == maxChargingPowerKw ? _self.maxChargingPowerKw : maxChargingPowerKw // ignore: cast_nullable_to_non_nullable
as double?,photoPaths: null == photoPaths ? _self.photoPaths : photoPaths // ignore: cast_nullable_to_non_nullable
as List<String>,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChargeLog].
extension ChargeLogPatterns on ChargeLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChargeLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChargeLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChargeLog value)  $default,){
final _that = this;
switch (_that) {
case _ChargeLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChargeLog value)?  $default,){
final _that = this;
switch (_that) {
case _ChargeLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  double durationMinutes,  double kwhAdded,  double cost,  PaymentMethod paymentMethod,  LocationType locationType,  int startBattery,  int endBattery,  String? locationName,  String? notes,  DateTime? startTime,  DateTime? endTime,  String? chargerType,  String? chargingMethod,  double? electricityPrice,  String? providerName,  double? maxChargingPowerKw,  List<String> photoPaths,  int? bikeId,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChargeLog() when $default != null:
return $default(_that.id,_that.date,_that.durationMinutes,_that.kwhAdded,_that.cost,_that.paymentMethod,_that.locationType,_that.startBattery,_that.endBattery,_that.locationName,_that.notes,_that.startTime,_that.endTime,_that.chargerType,_that.chargingMethod,_that.electricityPrice,_that.providerName,_that.maxChargingPowerKw,_that.photoPaths,_that.bikeId,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  double durationMinutes,  double kwhAdded,  double cost,  PaymentMethod paymentMethod,  LocationType locationType,  int startBattery,  int endBattery,  String? locationName,  String? notes,  DateTime? startTime,  DateTime? endTime,  String? chargerType,  String? chargingMethod,  double? electricityPrice,  String? providerName,  double? maxChargingPowerKw,  List<String> photoPaths,  int? bikeId,  String source)  $default,) {final _that = this;
switch (_that) {
case _ChargeLog():
return $default(_that.id,_that.date,_that.durationMinutes,_that.kwhAdded,_that.cost,_that.paymentMethod,_that.locationType,_that.startBattery,_that.endBattery,_that.locationName,_that.notes,_that.startTime,_that.endTime,_that.chargerType,_that.chargingMethod,_that.electricityPrice,_that.providerName,_that.maxChargingPowerKw,_that.photoPaths,_that.bikeId,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  double durationMinutes,  double kwhAdded,  double cost,  PaymentMethod paymentMethod,  LocationType locationType,  int startBattery,  int endBattery,  String? locationName,  String? notes,  DateTime? startTime,  DateTime? endTime,  String? chargerType,  String? chargingMethod,  double? electricityPrice,  String? providerName,  double? maxChargingPowerKw,  List<String> photoPaths,  int? bikeId,  String source)?  $default,) {final _that = this;
switch (_that) {
case _ChargeLog() when $default != null:
return $default(_that.id,_that.date,_that.durationMinutes,_that.kwhAdded,_that.cost,_that.paymentMethod,_that.locationType,_that.startBattery,_that.endBattery,_that.locationName,_that.notes,_that.startTime,_that.endTime,_that.chargerType,_that.chargingMethod,_that.electricityPrice,_that.providerName,_that.maxChargingPowerKw,_that.photoPaths,_that.bikeId,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChargeLog implements ChargeLog {
  const _ChargeLog({required this.id, required this.date, required this.durationMinutes, required this.kwhAdded, required this.cost, required this.paymentMethod, required this.locationType, required this.startBattery, required this.endBattery, this.locationName, this.notes, this.startTime, this.endTime, this.chargerType, this.chargingMethod, this.electricityPrice, this.providerName, this.maxChargingPowerKw, final  List<String> photoPaths = const [], this.bikeId, this.source = 'manual'}): _photoPaths = photoPaths;
  factory _ChargeLog.fromJson(Map<String, dynamic> json) => _$ChargeLogFromJson(json);

@override final  String id;
@override final  DateTime date;
@override final  double durationMinutes;
@override final  double kwhAdded;
@override final  double cost;
@override final  PaymentMethod paymentMethod;
@override final  LocationType locationType;
@override final  int startBattery;
@override final  int endBattery;
@override final  String? locationName;
@override final  String? notes;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  String? chargerType;
@override final  String? chargingMethod;
@override final  double? electricityPrice;
@override final  String? providerName;
@override final  double? maxChargingPowerKw;
 final  List<String> _photoPaths;
@override@JsonKey() List<String> get photoPaths {
  if (_photoPaths is EqualUnmodifiableListView) return _photoPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoPaths);
}

@override final  int? bikeId;
@override@JsonKey() final  String source;

/// Create a copy of ChargeLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChargeLogCopyWith<_ChargeLog> get copyWith => __$ChargeLogCopyWithImpl<_ChargeLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChargeLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChargeLog&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.kwhAdded, kwhAdded) || other.kwhAdded == kwhAdded)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.startBattery, startBattery) || other.startBattery == startBattery)&&(identical(other.endBattery, endBattery) || other.endBattery == endBattery)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.chargerType, chargerType) || other.chargerType == chargerType)&&(identical(other.chargingMethod, chargingMethod) || other.chargingMethod == chargingMethod)&&(identical(other.electricityPrice, electricityPrice) || other.electricityPrice == electricityPrice)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.maxChargingPowerKw, maxChargingPowerKw) || other.maxChargingPowerKw == maxChargingPowerKw)&&const DeepCollectionEquality().equals(other._photoPaths, _photoPaths)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,date,durationMinutes,kwhAdded,cost,paymentMethod,locationType,startBattery,endBattery,locationName,notes,startTime,endTime,chargerType,chargingMethod,electricityPrice,providerName,maxChargingPowerKw,const DeepCollectionEquality().hash(_photoPaths),bikeId,source]);

@override
String toString() {
  return 'ChargeLog(id: $id, date: $date, durationMinutes: $durationMinutes, kwhAdded: $kwhAdded, cost: $cost, paymentMethod: $paymentMethod, locationType: $locationType, startBattery: $startBattery, endBattery: $endBattery, locationName: $locationName, notes: $notes, startTime: $startTime, endTime: $endTime, chargerType: $chargerType, chargingMethod: $chargingMethod, electricityPrice: $electricityPrice, providerName: $providerName, maxChargingPowerKw: $maxChargingPowerKw, photoPaths: $photoPaths, bikeId: $bikeId, source: $source)';
}


}

/// @nodoc
abstract mixin class _$ChargeLogCopyWith<$Res> implements $ChargeLogCopyWith<$Res> {
  factory _$ChargeLogCopyWith(_ChargeLog value, $Res Function(_ChargeLog) _then) = __$ChargeLogCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, double durationMinutes, double kwhAdded, double cost, PaymentMethod paymentMethod, LocationType locationType, int startBattery, int endBattery, String? locationName, String? notes, DateTime? startTime, DateTime? endTime, String? chargerType, String? chargingMethod, double? electricityPrice, String? providerName, double? maxChargingPowerKw, List<String> photoPaths, int? bikeId, String source
});




}
/// @nodoc
class __$ChargeLogCopyWithImpl<$Res>
    implements _$ChargeLogCopyWith<$Res> {
  __$ChargeLogCopyWithImpl(this._self, this._then);

  final _ChargeLog _self;
  final $Res Function(_ChargeLog) _then;

/// Create a copy of ChargeLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? durationMinutes = null,Object? kwhAdded = null,Object? cost = null,Object? paymentMethod = null,Object? locationType = null,Object? startBattery = null,Object? endBattery = null,Object? locationName = freezed,Object? notes = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? chargerType = freezed,Object? chargingMethod = freezed,Object? electricityPrice = freezed,Object? providerName = freezed,Object? maxChargingPowerKw = freezed,Object? photoPaths = null,Object? bikeId = freezed,Object? source = null,}) {
  return _then(_ChargeLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as double,kwhAdded: null == kwhAdded ? _self.kwhAdded : kwhAdded // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,locationType: null == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as LocationType,startBattery: null == startBattery ? _self.startBattery : startBattery // ignore: cast_nullable_to_non_nullable
as int,endBattery: null == endBattery ? _self.endBattery : endBattery // ignore: cast_nullable_to_non_nullable
as int,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,chargerType: freezed == chargerType ? _self.chargerType : chargerType // ignore: cast_nullable_to_non_nullable
as String?,chargingMethod: freezed == chargingMethod ? _self.chargingMethod : chargingMethod // ignore: cast_nullable_to_non_nullable
as String?,electricityPrice: freezed == electricityPrice ? _self.electricityPrice : electricityPrice // ignore: cast_nullable_to_non_nullable
as double?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,maxChargingPowerKw: freezed == maxChargingPowerKw ? _self.maxChargingPowerKw : maxChargingPowerKw // ignore: cast_nullable_to_non_nullable
as double?,photoPaths: null == photoPaths ? _self._photoPaths : photoPaths // ignore: cast_nullable_to_non_nullable
as List<String>,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
