// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gps_tracking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GpsTrackingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsTrackingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GpsTrackingState()';
}


}

/// @nodoc
class $GpsTrackingStateCopyWith<$Res>  {
$GpsTrackingStateCopyWith(GpsTrackingState _, $Res Function(GpsTrackingState) __);
}


/// Adds pattern-matching-related methods to [GpsTrackingState].
extension GpsTrackingStatePatterns on GpsTrackingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GpsTrackingStateIdle value)?  idle,TResult Function( GpsTrackingStateActive value)?  active,TResult Function( GpsTrackingStateFinalizing value)?  finalizing,TResult Function( GpsTrackingStateCompleted value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GpsTrackingStateIdle() when idle != null:
return idle(_that);case GpsTrackingStateActive() when active != null:
return active(_that);case GpsTrackingStateFinalizing() when finalizing != null:
return finalizing(_that);case GpsTrackingStateCompleted() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GpsTrackingStateIdle value)  idle,required TResult Function( GpsTrackingStateActive value)  active,required TResult Function( GpsTrackingStateFinalizing value)  finalizing,required TResult Function( GpsTrackingStateCompleted value)  completed,}){
final _that = this;
switch (_that) {
case GpsTrackingStateIdle():
return idle(_that);case GpsTrackingStateActive():
return active(_that);case GpsTrackingStateFinalizing():
return finalizing(_that);case GpsTrackingStateCompleted():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GpsTrackingStateIdle value)?  idle,TResult? Function( GpsTrackingStateActive value)?  active,TResult? Function( GpsTrackingStateFinalizing value)?  finalizing,TResult? Function( GpsTrackingStateCompleted value)?  completed,}){
final _that = this;
switch (_that) {
case GpsTrackingStateIdle() when idle != null:
return idle(_that);case GpsTrackingStateActive() when active != null:
return active(_that);case GpsTrackingStateFinalizing() when finalizing != null:
return finalizing(_that);case GpsTrackingStateCompleted() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( DateTime startTime,  double startOdometer,  List<GpsPoint> route,  double distanceKm,  double maxSpeedKmh,  double currentSpeedKmh,  int durationSeconds)?  active,TResult Function()?  finalizing,TResult Function( List<GpsPoint> route,  double totalDistanceKm,  double maxSpeedKmh,  Duration duration,  DateTime startTime,  DateTime endTime)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GpsTrackingStateIdle() when idle != null:
return idle();case GpsTrackingStateActive() when active != null:
return active(_that.startTime,_that.startOdometer,_that.route,_that.distanceKm,_that.maxSpeedKmh,_that.currentSpeedKmh,_that.durationSeconds);case GpsTrackingStateFinalizing() when finalizing != null:
return finalizing();case GpsTrackingStateCompleted() when completed != null:
return completed(_that.route,_that.totalDistanceKm,_that.maxSpeedKmh,_that.duration,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( DateTime startTime,  double startOdometer,  List<GpsPoint> route,  double distanceKm,  double maxSpeedKmh,  double currentSpeedKmh,  int durationSeconds)  active,required TResult Function()  finalizing,required TResult Function( List<GpsPoint> route,  double totalDistanceKm,  double maxSpeedKmh,  Duration duration,  DateTime startTime,  DateTime endTime)  completed,}) {final _that = this;
switch (_that) {
case GpsTrackingStateIdle():
return idle();case GpsTrackingStateActive():
return active(_that.startTime,_that.startOdometer,_that.route,_that.distanceKm,_that.maxSpeedKmh,_that.currentSpeedKmh,_that.durationSeconds);case GpsTrackingStateFinalizing():
return finalizing();case GpsTrackingStateCompleted():
return completed(_that.route,_that.totalDistanceKm,_that.maxSpeedKmh,_that.duration,_that.startTime,_that.endTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( DateTime startTime,  double startOdometer,  List<GpsPoint> route,  double distanceKm,  double maxSpeedKmh,  double currentSpeedKmh,  int durationSeconds)?  active,TResult? Function()?  finalizing,TResult? Function( List<GpsPoint> route,  double totalDistanceKm,  double maxSpeedKmh,  Duration duration,  DateTime startTime,  DateTime endTime)?  completed,}) {final _that = this;
switch (_that) {
case GpsTrackingStateIdle() when idle != null:
return idle();case GpsTrackingStateActive() when active != null:
return active(_that.startTime,_that.startOdometer,_that.route,_that.distanceKm,_that.maxSpeedKmh,_that.currentSpeedKmh,_that.durationSeconds);case GpsTrackingStateFinalizing() when finalizing != null:
return finalizing();case GpsTrackingStateCompleted() when completed != null:
return completed(_that.route,_that.totalDistanceKm,_that.maxSpeedKmh,_that.duration,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc


class GpsTrackingStateIdle implements GpsTrackingState {
  const GpsTrackingStateIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsTrackingStateIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GpsTrackingState.idle()';
}


}




/// @nodoc


class GpsTrackingStateActive implements GpsTrackingState {
  const GpsTrackingStateActive({required this.startTime, required this.startOdometer, required final  List<GpsPoint> route, required this.distanceKm, required this.maxSpeedKmh, required this.currentSpeedKmh, required this.durationSeconds}): _route = route;
  

 final  DateTime startTime;
 final  double startOdometer;
 final  List<GpsPoint> _route;
 List<GpsPoint> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}

 final  double distanceKm;
 final  double maxSpeedKmh;
 final  double currentSpeedKmh;
 final  int durationSeconds;

/// Create a copy of GpsTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GpsTrackingStateActiveCopyWith<GpsTrackingStateActive> get copyWith => _$GpsTrackingStateActiveCopyWithImpl<GpsTrackingStateActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsTrackingStateActive&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.startOdometer, startOdometer) || other.startOdometer == startOdometer)&&const DeepCollectionEquality().equals(other._route, _route)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.maxSpeedKmh, maxSpeedKmh) || other.maxSpeedKmh == maxSpeedKmh)&&(identical(other.currentSpeedKmh, currentSpeedKmh) || other.currentSpeedKmh == currentSpeedKmh)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,startOdometer,const DeepCollectionEquality().hash(_route),distanceKm,maxSpeedKmh,currentSpeedKmh,durationSeconds);

@override
String toString() {
  return 'GpsTrackingState.active(startTime: $startTime, startOdometer: $startOdometer, route: $route, distanceKm: $distanceKm, maxSpeedKmh: $maxSpeedKmh, currentSpeedKmh: $currentSpeedKmh, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $GpsTrackingStateActiveCopyWith<$Res> implements $GpsTrackingStateCopyWith<$Res> {
  factory $GpsTrackingStateActiveCopyWith(GpsTrackingStateActive value, $Res Function(GpsTrackingStateActive) _then) = _$GpsTrackingStateActiveCopyWithImpl;
@useResult
$Res call({
 DateTime startTime, double startOdometer, List<GpsPoint> route, double distanceKm, double maxSpeedKmh, double currentSpeedKmh, int durationSeconds
});




}
/// @nodoc
class _$GpsTrackingStateActiveCopyWithImpl<$Res>
    implements $GpsTrackingStateActiveCopyWith<$Res> {
  _$GpsTrackingStateActiveCopyWithImpl(this._self, this._then);

  final GpsTrackingStateActive _self;
  final $Res Function(GpsTrackingStateActive) _then;

/// Create a copy of GpsTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? startOdometer = null,Object? route = null,Object? distanceKm = null,Object? maxSpeedKmh = null,Object? currentSpeedKmh = null,Object? durationSeconds = null,}) {
  return _then(GpsTrackingStateActive(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,startOdometer: null == startOdometer ? _self.startOdometer : startOdometer // ignore: cast_nullable_to_non_nullable
as double,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<GpsPoint>,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,maxSpeedKmh: null == maxSpeedKmh ? _self.maxSpeedKmh : maxSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,currentSpeedKmh: null == currentSpeedKmh ? _self.currentSpeedKmh : currentSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class GpsTrackingStateFinalizing implements GpsTrackingState {
  const GpsTrackingStateFinalizing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsTrackingStateFinalizing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GpsTrackingState.finalizing()';
}


}




/// @nodoc


class GpsTrackingStateCompleted implements GpsTrackingState {
  const GpsTrackingStateCompleted({required final  List<GpsPoint> route, required this.totalDistanceKm, required this.maxSpeedKmh, required this.duration, required this.startTime, required this.endTime}): _route = route;
  

 final  List<GpsPoint> _route;
 List<GpsPoint> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}

 final  double totalDistanceKm;
 final  double maxSpeedKmh;
 final  Duration duration;
 final  DateTime startTime;
 final  DateTime endTime;

/// Create a copy of GpsTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GpsTrackingStateCompletedCopyWith<GpsTrackingStateCompleted> get copyWith => _$GpsTrackingStateCompletedCopyWithImpl<GpsTrackingStateCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpsTrackingStateCompleted&&const DeepCollectionEquality().equals(other._route, _route)&&(identical(other.totalDistanceKm, totalDistanceKm) || other.totalDistanceKm == totalDistanceKm)&&(identical(other.maxSpeedKmh, maxSpeedKmh) || other.maxSpeedKmh == maxSpeedKmh)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_route),totalDistanceKm,maxSpeedKmh,duration,startTime,endTime);

@override
String toString() {
  return 'GpsTrackingState.completed(route: $route, totalDistanceKm: $totalDistanceKm, maxSpeedKmh: $maxSpeedKmh, duration: $duration, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $GpsTrackingStateCompletedCopyWith<$Res> implements $GpsTrackingStateCopyWith<$Res> {
  factory $GpsTrackingStateCompletedCopyWith(GpsTrackingStateCompleted value, $Res Function(GpsTrackingStateCompleted) _then) = _$GpsTrackingStateCompletedCopyWithImpl;
@useResult
$Res call({
 List<GpsPoint> route, double totalDistanceKm, double maxSpeedKmh, Duration duration, DateTime startTime, DateTime endTime
});




}
/// @nodoc
class _$GpsTrackingStateCompletedCopyWithImpl<$Res>
    implements $GpsTrackingStateCompletedCopyWith<$Res> {
  _$GpsTrackingStateCompletedCopyWithImpl(this._self, this._then);

  final GpsTrackingStateCompleted _self;
  final $Res Function(GpsTrackingStateCompleted) _then;

/// Create a copy of GpsTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? route = null,Object? totalDistanceKm = null,Object? maxSpeedKmh = null,Object? duration = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(GpsTrackingStateCompleted(
route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<GpsPoint>,totalDistanceKm: null == totalDistanceKm ? _self.totalDistanceKm : totalDistanceKm // ignore: cast_nullable_to_non_nullable
as double,maxSpeedKmh: null == maxSpeedKmh ? _self.maxSpeedKmh : maxSpeedKmh // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
