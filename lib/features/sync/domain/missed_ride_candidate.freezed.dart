// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'missed_ride_candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissedRideCandidate {

 String get id; DateTime get estimatedStartTime; DateTime get estimatedEndTime; double get odometerDeltaKm; double? get gpsDistanceKm; double? get gpsMaxSpeedKmh; List<GpsPoint>? get gpsRoute; String get confidence; String get dataSource;
/// Create a copy of MissedRideCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissedRideCandidateCopyWith<MissedRideCandidate> get copyWith => _$MissedRideCandidateCopyWithImpl<MissedRideCandidate>(this as MissedRideCandidate, _$identity);

  /// Serializes this MissedRideCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissedRideCandidate&&(identical(other.id, id) || other.id == id)&&(identical(other.estimatedStartTime, estimatedStartTime) || other.estimatedStartTime == estimatedStartTime)&&(identical(other.estimatedEndTime, estimatedEndTime) || other.estimatedEndTime == estimatedEndTime)&&(identical(other.odometerDeltaKm, odometerDeltaKm) || other.odometerDeltaKm == odometerDeltaKm)&&(identical(other.gpsDistanceKm, gpsDistanceKm) || other.gpsDistanceKm == gpsDistanceKm)&&(identical(other.gpsMaxSpeedKmh, gpsMaxSpeedKmh) || other.gpsMaxSpeedKmh == gpsMaxSpeedKmh)&&const DeepCollectionEquality().equals(other.gpsRoute, gpsRoute)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,estimatedStartTime,estimatedEndTime,odometerDeltaKm,gpsDistanceKm,gpsMaxSpeedKmh,const DeepCollectionEquality().hash(gpsRoute),confidence,dataSource);

@override
String toString() {
  return 'MissedRideCandidate(id: $id, estimatedStartTime: $estimatedStartTime, estimatedEndTime: $estimatedEndTime, odometerDeltaKm: $odometerDeltaKm, gpsDistanceKm: $gpsDistanceKm, gpsMaxSpeedKmh: $gpsMaxSpeedKmh, gpsRoute: $gpsRoute, confidence: $confidence, dataSource: $dataSource)';
}


}

/// @nodoc
abstract mixin class $MissedRideCandidateCopyWith<$Res>  {
  factory $MissedRideCandidateCopyWith(MissedRideCandidate value, $Res Function(MissedRideCandidate) _then) = _$MissedRideCandidateCopyWithImpl;
@useResult
$Res call({
 String id, DateTime estimatedStartTime, DateTime estimatedEndTime, double odometerDeltaKm, double? gpsDistanceKm, double? gpsMaxSpeedKmh, List<GpsPoint>? gpsRoute, String confidence, String dataSource
});




}
/// @nodoc
class _$MissedRideCandidateCopyWithImpl<$Res>
    implements $MissedRideCandidateCopyWith<$Res> {
  _$MissedRideCandidateCopyWithImpl(this._self, this._then);

  final MissedRideCandidate _self;
  final $Res Function(MissedRideCandidate) _then;

/// Create a copy of MissedRideCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? estimatedStartTime = null,Object? estimatedEndTime = null,Object? odometerDeltaKm = null,Object? gpsDistanceKm = freezed,Object? gpsMaxSpeedKmh = freezed,Object? gpsRoute = freezed,Object? confidence = null,Object? dataSource = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,estimatedStartTime: null == estimatedStartTime ? _self.estimatedStartTime : estimatedStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedEndTime: null == estimatedEndTime ? _self.estimatedEndTime : estimatedEndTime // ignore: cast_nullable_to_non_nullable
as DateTime,odometerDeltaKm: null == odometerDeltaKm ? _self.odometerDeltaKm : odometerDeltaKm // ignore: cast_nullable_to_non_nullable
as double,gpsDistanceKm: freezed == gpsDistanceKm ? _self.gpsDistanceKm : gpsDistanceKm // ignore: cast_nullable_to_non_nullable
as double?,gpsMaxSpeedKmh: freezed == gpsMaxSpeedKmh ? _self.gpsMaxSpeedKmh : gpsMaxSpeedKmh // ignore: cast_nullable_to_non_nullable
as double?,gpsRoute: freezed == gpsRoute ? _self.gpsRoute : gpsRoute // ignore: cast_nullable_to_non_nullable
as List<GpsPoint>?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,dataSource: null == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MissedRideCandidate].
extension MissedRideCandidatePatterns on MissedRideCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissedRideCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissedRideCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissedRideCandidate value)  $default,){
final _that = this;
switch (_that) {
case _MissedRideCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissedRideCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _MissedRideCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime estimatedStartTime,  DateTime estimatedEndTime,  double odometerDeltaKm,  double? gpsDistanceKm,  double? gpsMaxSpeedKmh,  List<GpsPoint>? gpsRoute,  String confidence,  String dataSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissedRideCandidate() when $default != null:
return $default(_that.id,_that.estimatedStartTime,_that.estimatedEndTime,_that.odometerDeltaKm,_that.gpsDistanceKm,_that.gpsMaxSpeedKmh,_that.gpsRoute,_that.confidence,_that.dataSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime estimatedStartTime,  DateTime estimatedEndTime,  double odometerDeltaKm,  double? gpsDistanceKm,  double? gpsMaxSpeedKmh,  List<GpsPoint>? gpsRoute,  String confidence,  String dataSource)  $default,) {final _that = this;
switch (_that) {
case _MissedRideCandidate():
return $default(_that.id,_that.estimatedStartTime,_that.estimatedEndTime,_that.odometerDeltaKm,_that.gpsDistanceKm,_that.gpsMaxSpeedKmh,_that.gpsRoute,_that.confidence,_that.dataSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime estimatedStartTime,  DateTime estimatedEndTime,  double odometerDeltaKm,  double? gpsDistanceKm,  double? gpsMaxSpeedKmh,  List<GpsPoint>? gpsRoute,  String confidence,  String dataSource)?  $default,) {final _that = this;
switch (_that) {
case _MissedRideCandidate() when $default != null:
return $default(_that.id,_that.estimatedStartTime,_that.estimatedEndTime,_that.odometerDeltaKm,_that.gpsDistanceKm,_that.gpsMaxSpeedKmh,_that.gpsRoute,_that.confidence,_that.dataSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissedRideCandidate implements MissedRideCandidate {
  const _MissedRideCandidate({required this.id, required this.estimatedStartTime, required this.estimatedEndTime, required this.odometerDeltaKm, required this.gpsDistanceKm, required this.gpsMaxSpeedKmh, required final  List<GpsPoint>? gpsRoute, required this.confidence, required this.dataSource}): _gpsRoute = gpsRoute;
  factory _MissedRideCandidate.fromJson(Map<String, dynamic> json) => _$MissedRideCandidateFromJson(json);

@override final  String id;
@override final  DateTime estimatedStartTime;
@override final  DateTime estimatedEndTime;
@override final  double odometerDeltaKm;
@override final  double? gpsDistanceKm;
@override final  double? gpsMaxSpeedKmh;
 final  List<GpsPoint>? _gpsRoute;
@override List<GpsPoint>? get gpsRoute {
  final value = _gpsRoute;
  if (value == null) return null;
  if (_gpsRoute is EqualUnmodifiableListView) return _gpsRoute;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String confidence;
@override final  String dataSource;

/// Create a copy of MissedRideCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissedRideCandidateCopyWith<_MissedRideCandidate> get copyWith => __$MissedRideCandidateCopyWithImpl<_MissedRideCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissedRideCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissedRideCandidate&&(identical(other.id, id) || other.id == id)&&(identical(other.estimatedStartTime, estimatedStartTime) || other.estimatedStartTime == estimatedStartTime)&&(identical(other.estimatedEndTime, estimatedEndTime) || other.estimatedEndTime == estimatedEndTime)&&(identical(other.odometerDeltaKm, odometerDeltaKm) || other.odometerDeltaKm == odometerDeltaKm)&&(identical(other.gpsDistanceKm, gpsDistanceKm) || other.gpsDistanceKm == gpsDistanceKm)&&(identical(other.gpsMaxSpeedKmh, gpsMaxSpeedKmh) || other.gpsMaxSpeedKmh == gpsMaxSpeedKmh)&&const DeepCollectionEquality().equals(other._gpsRoute, _gpsRoute)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,estimatedStartTime,estimatedEndTime,odometerDeltaKm,gpsDistanceKm,gpsMaxSpeedKmh,const DeepCollectionEquality().hash(_gpsRoute),confidence,dataSource);

@override
String toString() {
  return 'MissedRideCandidate(id: $id, estimatedStartTime: $estimatedStartTime, estimatedEndTime: $estimatedEndTime, odometerDeltaKm: $odometerDeltaKm, gpsDistanceKm: $gpsDistanceKm, gpsMaxSpeedKmh: $gpsMaxSpeedKmh, gpsRoute: $gpsRoute, confidence: $confidence, dataSource: $dataSource)';
}


}

/// @nodoc
abstract mixin class _$MissedRideCandidateCopyWith<$Res> implements $MissedRideCandidateCopyWith<$Res> {
  factory _$MissedRideCandidateCopyWith(_MissedRideCandidate value, $Res Function(_MissedRideCandidate) _then) = __$MissedRideCandidateCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime estimatedStartTime, DateTime estimatedEndTime, double odometerDeltaKm, double? gpsDistanceKm, double? gpsMaxSpeedKmh, List<GpsPoint>? gpsRoute, String confidence, String dataSource
});




}
/// @nodoc
class __$MissedRideCandidateCopyWithImpl<$Res>
    implements _$MissedRideCandidateCopyWith<$Res> {
  __$MissedRideCandidateCopyWithImpl(this._self, this._then);

  final _MissedRideCandidate _self;
  final $Res Function(_MissedRideCandidate) _then;

/// Create a copy of MissedRideCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? estimatedStartTime = null,Object? estimatedEndTime = null,Object? odometerDeltaKm = null,Object? gpsDistanceKm = freezed,Object? gpsMaxSpeedKmh = freezed,Object? gpsRoute = freezed,Object? confidence = null,Object? dataSource = null,}) {
  return _then(_MissedRideCandidate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,estimatedStartTime: null == estimatedStartTime ? _self.estimatedStartTime : estimatedStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedEndTime: null == estimatedEndTime ? _self.estimatedEndTime : estimatedEndTime // ignore: cast_nullable_to_non_nullable
as DateTime,odometerDeltaKm: null == odometerDeltaKm ? _self.odometerDeltaKm : odometerDeltaKm // ignore: cast_nullable_to_non_nullable
as double,gpsDistanceKm: freezed == gpsDistanceKm ? _self.gpsDistanceKm : gpsDistanceKm // ignore: cast_nullable_to_non_nullable
as double?,gpsMaxSpeedKmh: freezed == gpsMaxSpeedKmh ? _self.gpsMaxSpeedKmh : gpsMaxSpeedKmh // ignore: cast_nullable_to_non_nullable
as double?,gpsRoute: freezed == gpsRoute ? _self._gpsRoute : gpsRoute // ignore: cast_nullable_to_non_nullable
as List<GpsPoint>?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,dataSource: null == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
