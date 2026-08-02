// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecentActivity {

 String get id; ActivityType get type; DateTime get date; String get title; String get subtitle; double get value;
/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentActivityCopyWith<RecentActivity> get copyWith => _$RecentActivityCopyWithImpl<RecentActivity>(this as RecentActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,date,title,subtitle,value);

@override
String toString() {
  return 'RecentActivity(id: $id, type: $type, date: $date, title: $title, subtitle: $subtitle, value: $value)';
}


}

/// @nodoc
abstract mixin class $RecentActivityCopyWith<$Res>  {
  factory $RecentActivityCopyWith(RecentActivity value, $Res Function(RecentActivity) _then) = _$RecentActivityCopyWithImpl;
@useResult
$Res call({
 String id, ActivityType type, DateTime date, String title, String subtitle, double value
});




}
/// @nodoc
class _$RecentActivityCopyWithImpl<$Res>
    implements $RecentActivityCopyWith<$Res> {
  _$RecentActivityCopyWithImpl(this._self, this._then);

  final RecentActivity _self;
  final $Res Function(RecentActivity) _then;

/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? date = null,Object? title = null,Object? subtitle = null,Object? value = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentActivity].
extension RecentActivityPatterns on RecentActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentActivity value)  $default,){
final _that = this;
switch (_that) {
case _RecentActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentActivity value)?  $default,){
final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ActivityType type,  DateTime date,  String title,  String subtitle,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
return $default(_that.id,_that.type,_that.date,_that.title,_that.subtitle,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ActivityType type,  DateTime date,  String title,  String subtitle,  double value)  $default,) {final _that = this;
switch (_that) {
case _RecentActivity():
return $default(_that.id,_that.type,_that.date,_that.title,_that.subtitle,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ActivityType type,  DateTime date,  String title,  String subtitle,  double value)?  $default,) {final _that = this;
switch (_that) {
case _RecentActivity() when $default != null:
return $default(_that.id,_that.type,_that.date,_that.title,_that.subtitle,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _RecentActivity implements RecentActivity {
  const _RecentActivity({required this.id, required this.type, required this.date, required this.title, required this.subtitle, required this.value});
  

@override final  String id;
@override final  ActivityType type;
@override final  DateTime date;
@override final  String title;
@override final  String subtitle;
@override final  double value;

/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentActivityCopyWith<_RecentActivity> get copyWith => __$RecentActivityCopyWithImpl<_RecentActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,date,title,subtitle,value);

@override
String toString() {
  return 'RecentActivity(id: $id, type: $type, date: $date, title: $title, subtitle: $subtitle, value: $value)';
}


}

/// @nodoc
abstract mixin class _$RecentActivityCopyWith<$Res> implements $RecentActivityCopyWith<$Res> {
  factory _$RecentActivityCopyWith(_RecentActivity value, $Res Function(_RecentActivity) _then) = __$RecentActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, ActivityType type, DateTime date, String title, String subtitle, double value
});




}
/// @nodoc
class __$RecentActivityCopyWithImpl<$Res>
    implements _$RecentActivityCopyWith<$Res> {
  __$RecentActivityCopyWithImpl(this._self, this._then);

  final _RecentActivity _self;
  final $Res Function(_RecentActivity) _then;

/// Create a copy of RecentActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? date = null,Object? title = null,Object? subtitle = null,Object? value = null,}) {
  return _then(_RecentActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$DashboardData {

 double get currentOdometer; double get todayDistance; double get weeklyDistance; double get monthlyDistance; double get totalDistance; Ride? get lastRide; ChargeLog? get lastCharge; Reminder? get upcomingReminder; List<RecentActivity> get recentActivities; int get totalCharges; double get totalChargingCost; double get petrolSaved;// Assume ~ 1 liter per 40km, ₹100/liter
 double get co2Saved;// Assume ~ 40g/km for EV vs 100g/km for ICE
 int get latestBatteryPercentage; BleConnectionState get connectionStatus; VehicleSnapshot? get liveSnapshot;
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this as DashboardData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.currentOdometer, currentOdometer) || other.currentOdometer == currentOdometer)&&(identical(other.todayDistance, todayDistance) || other.todayDistance == todayDistance)&&(identical(other.weeklyDistance, weeklyDistance) || other.weeklyDistance == weeklyDistance)&&(identical(other.monthlyDistance, monthlyDistance) || other.monthlyDistance == monthlyDistance)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.lastRide, lastRide) || other.lastRide == lastRide)&&(identical(other.lastCharge, lastCharge) || other.lastCharge == lastCharge)&&(identical(other.upcomingReminder, upcomingReminder) || other.upcomingReminder == upcomingReminder)&&const DeepCollectionEquality().equals(other.recentActivities, recentActivities)&&(identical(other.totalCharges, totalCharges) || other.totalCharges == totalCharges)&&(identical(other.totalChargingCost, totalChargingCost) || other.totalChargingCost == totalChargingCost)&&(identical(other.petrolSaved, petrolSaved) || other.petrolSaved == petrolSaved)&&(identical(other.co2Saved, co2Saved) || other.co2Saved == co2Saved)&&(identical(other.latestBatteryPercentage, latestBatteryPercentage) || other.latestBatteryPercentage == latestBatteryPercentage)&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.liveSnapshot, liveSnapshot) || other.liveSnapshot == liveSnapshot));
}


@override
int get hashCode => Object.hash(runtimeType,currentOdometer,todayDistance,weeklyDistance,monthlyDistance,totalDistance,lastRide,lastCharge,upcomingReminder,const DeepCollectionEquality().hash(recentActivities),totalCharges,totalChargingCost,petrolSaved,co2Saved,latestBatteryPercentage,connectionStatus,liveSnapshot);

@override
String toString() {
  return 'DashboardData(currentOdometer: $currentOdometer, todayDistance: $todayDistance, weeklyDistance: $weeklyDistance, monthlyDistance: $monthlyDistance, totalDistance: $totalDistance, lastRide: $lastRide, lastCharge: $lastCharge, upcomingReminder: $upcomingReminder, recentActivities: $recentActivities, totalCharges: $totalCharges, totalChargingCost: $totalChargingCost, petrolSaved: $petrolSaved, co2Saved: $co2Saved, latestBatteryPercentage: $latestBatteryPercentage, connectionStatus: $connectionStatus, liveSnapshot: $liveSnapshot)';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res>  {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
 double currentOdometer, double todayDistance, double weeklyDistance, double monthlyDistance, double totalDistance, Ride? lastRide, ChargeLog? lastCharge, Reminder? upcomingReminder, List<RecentActivity> recentActivities, int totalCharges, double totalChargingCost, double petrolSaved, double co2Saved, int latestBatteryPercentage, BleConnectionState connectionStatus, VehicleSnapshot? liveSnapshot
});


$RideCopyWith<$Res>? get lastRide;$ChargeLogCopyWith<$Res>? get lastCharge;$ReminderCopyWith<$Res>? get upcomingReminder;$VehicleSnapshotCopyWith<$Res>? get liveSnapshot;

}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentOdometer = null,Object? todayDistance = null,Object? weeklyDistance = null,Object? monthlyDistance = null,Object? totalDistance = null,Object? lastRide = freezed,Object? lastCharge = freezed,Object? upcomingReminder = freezed,Object? recentActivities = null,Object? totalCharges = null,Object? totalChargingCost = null,Object? petrolSaved = null,Object? co2Saved = null,Object? latestBatteryPercentage = null,Object? connectionStatus = null,Object? liveSnapshot = freezed,}) {
  return _then(_self.copyWith(
currentOdometer: null == currentOdometer ? _self.currentOdometer : currentOdometer // ignore: cast_nullable_to_non_nullable
as double,todayDistance: null == todayDistance ? _self.todayDistance : todayDistance // ignore: cast_nullable_to_non_nullable
as double,weeklyDistance: null == weeklyDistance ? _self.weeklyDistance : weeklyDistance // ignore: cast_nullable_to_non_nullable
as double,monthlyDistance: null == monthlyDistance ? _self.monthlyDistance : monthlyDistance // ignore: cast_nullable_to_non_nullable
as double,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as double,lastRide: freezed == lastRide ? _self.lastRide : lastRide // ignore: cast_nullable_to_non_nullable
as Ride?,lastCharge: freezed == lastCharge ? _self.lastCharge : lastCharge // ignore: cast_nullable_to_non_nullable
as ChargeLog?,upcomingReminder: freezed == upcomingReminder ? _self.upcomingReminder : upcomingReminder // ignore: cast_nullable_to_non_nullable
as Reminder?,recentActivities: null == recentActivities ? _self.recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<RecentActivity>,totalCharges: null == totalCharges ? _self.totalCharges : totalCharges // ignore: cast_nullable_to_non_nullable
as int,totalChargingCost: null == totalChargingCost ? _self.totalChargingCost : totalChargingCost // ignore: cast_nullable_to_non_nullable
as double,petrolSaved: null == petrolSaved ? _self.petrolSaved : petrolSaved // ignore: cast_nullable_to_non_nullable
as double,co2Saved: null == co2Saved ? _self.co2Saved : co2Saved // ignore: cast_nullable_to_non_nullable
as double,latestBatteryPercentage: null == latestBatteryPercentage ? _self.latestBatteryPercentage : latestBatteryPercentage // ignore: cast_nullable_to_non_nullable
as int,connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as BleConnectionState,liveSnapshot: freezed == liveSnapshot ? _self.liveSnapshot : liveSnapshot // ignore: cast_nullable_to_non_nullable
as VehicleSnapshot?,
  ));
}
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideCopyWith<$Res>? get lastRide {
    if (_self.lastRide == null) {
    return null;
  }

  return $RideCopyWith<$Res>(_self.lastRide!, (value) {
    return _then(_self.copyWith(lastRide: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChargeLogCopyWith<$Res>? get lastCharge {
    if (_self.lastCharge == null) {
    return null;
  }

  return $ChargeLogCopyWith<$Res>(_self.lastCharge!, (value) {
    return _then(_self.copyWith(lastCharge: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReminderCopyWith<$Res>? get upcomingReminder {
    if (_self.upcomingReminder == null) {
    return null;
  }

  return $ReminderCopyWith<$Res>(_self.upcomingReminder!, (value) {
    return _then(_self.copyWith(upcomingReminder: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleSnapshotCopyWith<$Res>? get liveSnapshot {
    if (_self.liveSnapshot == null) {
    return null;
  }

  return $VehicleSnapshotCopyWith<$Res>(_self.liveSnapshot!, (value) {
    return _then(_self.copyWith(liveSnapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardData].
extension DashboardDataPatterns on DashboardData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardData value)  $default,){
final _that = this;
switch (_that) {
case _DashboardData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardData value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentOdometer,  double todayDistance,  double weeklyDistance,  double monthlyDistance,  double totalDistance,  Ride? lastRide,  ChargeLog? lastCharge,  Reminder? upcomingReminder,  List<RecentActivity> recentActivities,  int totalCharges,  double totalChargingCost,  double petrolSaved,  double co2Saved,  int latestBatteryPercentage,  BleConnectionState connectionStatus,  VehicleSnapshot? liveSnapshot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.currentOdometer,_that.todayDistance,_that.weeklyDistance,_that.monthlyDistance,_that.totalDistance,_that.lastRide,_that.lastCharge,_that.upcomingReminder,_that.recentActivities,_that.totalCharges,_that.totalChargingCost,_that.petrolSaved,_that.co2Saved,_that.latestBatteryPercentage,_that.connectionStatus,_that.liveSnapshot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentOdometer,  double todayDistance,  double weeklyDistance,  double monthlyDistance,  double totalDistance,  Ride? lastRide,  ChargeLog? lastCharge,  Reminder? upcomingReminder,  List<RecentActivity> recentActivities,  int totalCharges,  double totalChargingCost,  double petrolSaved,  double co2Saved,  int latestBatteryPercentage,  BleConnectionState connectionStatus,  VehicleSnapshot? liveSnapshot)  $default,) {final _that = this;
switch (_that) {
case _DashboardData():
return $default(_that.currentOdometer,_that.todayDistance,_that.weeklyDistance,_that.monthlyDistance,_that.totalDistance,_that.lastRide,_that.lastCharge,_that.upcomingReminder,_that.recentActivities,_that.totalCharges,_that.totalChargingCost,_that.petrolSaved,_that.co2Saved,_that.latestBatteryPercentage,_that.connectionStatus,_that.liveSnapshot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentOdometer,  double todayDistance,  double weeklyDistance,  double monthlyDistance,  double totalDistance,  Ride? lastRide,  ChargeLog? lastCharge,  Reminder? upcomingReminder,  List<RecentActivity> recentActivities,  int totalCharges,  double totalChargingCost,  double petrolSaved,  double co2Saved,  int latestBatteryPercentage,  BleConnectionState connectionStatus,  VehicleSnapshot? liveSnapshot)?  $default,) {final _that = this;
switch (_that) {
case _DashboardData() when $default != null:
return $default(_that.currentOdometer,_that.todayDistance,_that.weeklyDistance,_that.monthlyDistance,_that.totalDistance,_that.lastRide,_that.lastCharge,_that.upcomingReminder,_that.recentActivities,_that.totalCharges,_that.totalChargingCost,_that.petrolSaved,_that.co2Saved,_that.latestBatteryPercentage,_that.connectionStatus,_that.liveSnapshot);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardData implements DashboardData {
  const _DashboardData({required this.currentOdometer, required this.todayDistance, required this.weeklyDistance, required this.monthlyDistance, required this.totalDistance, this.lastRide, this.lastCharge, this.upcomingReminder, final  List<RecentActivity> recentActivities = const [], required this.totalCharges, required this.totalChargingCost, required this.petrolSaved, required this.co2Saved, required this.latestBatteryPercentage, this.connectionStatus = BleConnectionState.disconnected, this.liveSnapshot}): _recentActivities = recentActivities;
  

@override final  double currentOdometer;
@override final  double todayDistance;
@override final  double weeklyDistance;
@override final  double monthlyDistance;
@override final  double totalDistance;
@override final  Ride? lastRide;
@override final  ChargeLog? lastCharge;
@override final  Reminder? upcomingReminder;
 final  List<RecentActivity> _recentActivities;
@override@JsonKey() List<RecentActivity> get recentActivities {
  if (_recentActivities is EqualUnmodifiableListView) return _recentActivities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentActivities);
}

@override final  int totalCharges;
@override final  double totalChargingCost;
@override final  double petrolSaved;
// Assume ~ 1 liter per 40km, ₹100/liter
@override final  double co2Saved;
// Assume ~ 40g/km for EV vs 100g/km for ICE
@override final  int latestBatteryPercentage;
@override@JsonKey() final  BleConnectionState connectionStatus;
@override final  VehicleSnapshot? liveSnapshot;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataCopyWith<_DashboardData> get copyWith => __$DashboardDataCopyWithImpl<_DashboardData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardData&&(identical(other.currentOdometer, currentOdometer) || other.currentOdometer == currentOdometer)&&(identical(other.todayDistance, todayDistance) || other.todayDistance == todayDistance)&&(identical(other.weeklyDistance, weeklyDistance) || other.weeklyDistance == weeklyDistance)&&(identical(other.monthlyDistance, monthlyDistance) || other.monthlyDistance == monthlyDistance)&&(identical(other.totalDistance, totalDistance) || other.totalDistance == totalDistance)&&(identical(other.lastRide, lastRide) || other.lastRide == lastRide)&&(identical(other.lastCharge, lastCharge) || other.lastCharge == lastCharge)&&(identical(other.upcomingReminder, upcomingReminder) || other.upcomingReminder == upcomingReminder)&&const DeepCollectionEquality().equals(other._recentActivities, _recentActivities)&&(identical(other.totalCharges, totalCharges) || other.totalCharges == totalCharges)&&(identical(other.totalChargingCost, totalChargingCost) || other.totalChargingCost == totalChargingCost)&&(identical(other.petrolSaved, petrolSaved) || other.petrolSaved == petrolSaved)&&(identical(other.co2Saved, co2Saved) || other.co2Saved == co2Saved)&&(identical(other.latestBatteryPercentage, latestBatteryPercentage) || other.latestBatteryPercentage == latestBatteryPercentage)&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.liveSnapshot, liveSnapshot) || other.liveSnapshot == liveSnapshot));
}


@override
int get hashCode => Object.hash(runtimeType,currentOdometer,todayDistance,weeklyDistance,monthlyDistance,totalDistance,lastRide,lastCharge,upcomingReminder,const DeepCollectionEquality().hash(_recentActivities),totalCharges,totalChargingCost,petrolSaved,co2Saved,latestBatteryPercentage,connectionStatus,liveSnapshot);

@override
String toString() {
  return 'DashboardData(currentOdometer: $currentOdometer, todayDistance: $todayDistance, weeklyDistance: $weeklyDistance, monthlyDistance: $monthlyDistance, totalDistance: $totalDistance, lastRide: $lastRide, lastCharge: $lastCharge, upcomingReminder: $upcomingReminder, recentActivities: $recentActivities, totalCharges: $totalCharges, totalChargingCost: $totalChargingCost, petrolSaved: $petrolSaved, co2Saved: $co2Saved, latestBatteryPercentage: $latestBatteryPercentage, connectionStatus: $connectionStatus, liveSnapshot: $liveSnapshot)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataCopyWith<$Res> implements $DashboardDataCopyWith<$Res> {
  factory _$DashboardDataCopyWith(_DashboardData value, $Res Function(_DashboardData) _then) = __$DashboardDataCopyWithImpl;
@override @useResult
$Res call({
 double currentOdometer, double todayDistance, double weeklyDistance, double monthlyDistance, double totalDistance, Ride? lastRide, ChargeLog? lastCharge, Reminder? upcomingReminder, List<RecentActivity> recentActivities, int totalCharges, double totalChargingCost, double petrolSaved, double co2Saved, int latestBatteryPercentage, BleConnectionState connectionStatus, VehicleSnapshot? liveSnapshot
});


@override $RideCopyWith<$Res>? get lastRide;@override $ChargeLogCopyWith<$Res>? get lastCharge;@override $ReminderCopyWith<$Res>? get upcomingReminder;@override $VehicleSnapshotCopyWith<$Res>? get liveSnapshot;

}
/// @nodoc
class __$DashboardDataCopyWithImpl<$Res>
    implements _$DashboardDataCopyWith<$Res> {
  __$DashboardDataCopyWithImpl(this._self, this._then);

  final _DashboardData _self;
  final $Res Function(_DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentOdometer = null,Object? todayDistance = null,Object? weeklyDistance = null,Object? monthlyDistance = null,Object? totalDistance = null,Object? lastRide = freezed,Object? lastCharge = freezed,Object? upcomingReminder = freezed,Object? recentActivities = null,Object? totalCharges = null,Object? totalChargingCost = null,Object? petrolSaved = null,Object? co2Saved = null,Object? latestBatteryPercentage = null,Object? connectionStatus = null,Object? liveSnapshot = freezed,}) {
  return _then(_DashboardData(
currentOdometer: null == currentOdometer ? _self.currentOdometer : currentOdometer // ignore: cast_nullable_to_non_nullable
as double,todayDistance: null == todayDistance ? _self.todayDistance : todayDistance // ignore: cast_nullable_to_non_nullable
as double,weeklyDistance: null == weeklyDistance ? _self.weeklyDistance : weeklyDistance // ignore: cast_nullable_to_non_nullable
as double,monthlyDistance: null == monthlyDistance ? _self.monthlyDistance : monthlyDistance // ignore: cast_nullable_to_non_nullable
as double,totalDistance: null == totalDistance ? _self.totalDistance : totalDistance // ignore: cast_nullable_to_non_nullable
as double,lastRide: freezed == lastRide ? _self.lastRide : lastRide // ignore: cast_nullable_to_non_nullable
as Ride?,lastCharge: freezed == lastCharge ? _self.lastCharge : lastCharge // ignore: cast_nullable_to_non_nullable
as ChargeLog?,upcomingReminder: freezed == upcomingReminder ? _self.upcomingReminder : upcomingReminder // ignore: cast_nullable_to_non_nullable
as Reminder?,recentActivities: null == recentActivities ? _self._recentActivities : recentActivities // ignore: cast_nullable_to_non_nullable
as List<RecentActivity>,totalCharges: null == totalCharges ? _self.totalCharges : totalCharges // ignore: cast_nullable_to_non_nullable
as int,totalChargingCost: null == totalChargingCost ? _self.totalChargingCost : totalChargingCost // ignore: cast_nullable_to_non_nullable
as double,petrolSaved: null == petrolSaved ? _self.petrolSaved : petrolSaved // ignore: cast_nullable_to_non_nullable
as double,co2Saved: null == co2Saved ? _self.co2Saved : co2Saved // ignore: cast_nullable_to_non_nullable
as double,latestBatteryPercentage: null == latestBatteryPercentage ? _self.latestBatteryPercentage : latestBatteryPercentage // ignore: cast_nullable_to_non_nullable
as int,connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as BleConnectionState,liveSnapshot: freezed == liveSnapshot ? _self.liveSnapshot : liveSnapshot // ignore: cast_nullable_to_non_nullable
as VehicleSnapshot?,
  ));
}

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideCopyWith<$Res>? get lastRide {
    if (_self.lastRide == null) {
    return null;
  }

  return $RideCopyWith<$Res>(_self.lastRide!, (value) {
    return _then(_self.copyWith(lastRide: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChargeLogCopyWith<$Res>? get lastCharge {
    if (_self.lastCharge == null) {
    return null;
  }

  return $ChargeLogCopyWith<$Res>(_self.lastCharge!, (value) {
    return _then(_self.copyWith(lastCharge: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReminderCopyWith<$Res>? get upcomingReminder {
    if (_self.upcomingReminder == null) {
    return null;
  }

  return $ReminderCopyWith<$Res>(_self.upcomingReminder!, (value) {
    return _then(_self.copyWith(upcomingReminder: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleSnapshotCopyWith<$Res>? get liveSnapshot {
    if (_self.liveSnapshot == null) {
    return null;
  }

  return $VehicleSnapshotCopyWith<$Res>(_self.liveSnapshot!, (value) {
    return _then(_self.copyWith(liveSnapshot: value));
  });
}
}

// dart format on
