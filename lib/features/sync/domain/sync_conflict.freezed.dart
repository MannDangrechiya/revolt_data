// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_conflict.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncConflict {

 String get conflictId; ConflictType get type; Ride get existingRide; MissedRideCandidate get newCandidate;
/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncConflictCopyWith<SyncConflict> get copyWith => _$SyncConflictCopyWithImpl<SyncConflict>(this as SyncConflict, _$identity);

  /// Serializes this SyncConflict to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncConflict&&(identical(other.conflictId, conflictId) || other.conflictId == conflictId)&&(identical(other.type, type) || other.type == type)&&(identical(other.existingRide, existingRide) || other.existingRide == existingRide)&&(identical(other.newCandidate, newCandidate) || other.newCandidate == newCandidate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conflictId,type,existingRide,newCandidate);

@override
String toString() {
  return 'SyncConflict(conflictId: $conflictId, type: $type, existingRide: $existingRide, newCandidate: $newCandidate)';
}


}

/// @nodoc
abstract mixin class $SyncConflictCopyWith<$Res>  {
  factory $SyncConflictCopyWith(SyncConflict value, $Res Function(SyncConflict) _then) = _$SyncConflictCopyWithImpl;
@useResult
$Res call({
 String conflictId, ConflictType type, Ride existingRide, MissedRideCandidate newCandidate
});


$RideCopyWith<$Res> get existingRide;$MissedRideCandidateCopyWith<$Res> get newCandidate;

}
/// @nodoc
class _$SyncConflictCopyWithImpl<$Res>
    implements $SyncConflictCopyWith<$Res> {
  _$SyncConflictCopyWithImpl(this._self, this._then);

  final SyncConflict _self;
  final $Res Function(SyncConflict) _then;

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conflictId = null,Object? type = null,Object? existingRide = null,Object? newCandidate = null,}) {
  return _then(_self.copyWith(
conflictId: null == conflictId ? _self.conflictId : conflictId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConflictType,existingRide: null == existingRide ? _self.existingRide : existingRide // ignore: cast_nullable_to_non_nullable
as Ride,newCandidate: null == newCandidate ? _self.newCandidate : newCandidate // ignore: cast_nullable_to_non_nullable
as MissedRideCandidate,
  ));
}
/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideCopyWith<$Res> get existingRide {
  
  return $RideCopyWith<$Res>(_self.existingRide, (value) {
    return _then(_self.copyWith(existingRide: value));
  });
}/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MissedRideCandidateCopyWith<$Res> get newCandidate {
  
  return $MissedRideCandidateCopyWith<$Res>(_self.newCandidate, (value) {
    return _then(_self.copyWith(newCandidate: value));
  });
}
}


/// Adds pattern-matching-related methods to [SyncConflict].
extension SyncConflictPatterns on SyncConflict {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncConflict value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncConflict value)  $default,){
final _that = this;
switch (_that) {
case _SyncConflict():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncConflict value)?  $default,){
final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String conflictId,  ConflictType type,  Ride existingRide,  MissedRideCandidate newCandidate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
return $default(_that.conflictId,_that.type,_that.existingRide,_that.newCandidate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String conflictId,  ConflictType type,  Ride existingRide,  MissedRideCandidate newCandidate)  $default,) {final _that = this;
switch (_that) {
case _SyncConflict():
return $default(_that.conflictId,_that.type,_that.existingRide,_that.newCandidate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String conflictId,  ConflictType type,  Ride existingRide,  MissedRideCandidate newCandidate)?  $default,) {final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
return $default(_that.conflictId,_that.type,_that.existingRide,_that.newCandidate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncConflict implements SyncConflict {
  const _SyncConflict({required this.conflictId, required this.type, required this.existingRide, required this.newCandidate});
  factory _SyncConflict.fromJson(Map<String, dynamic> json) => _$SyncConflictFromJson(json);

@override final  String conflictId;
@override final  ConflictType type;
@override final  Ride existingRide;
@override final  MissedRideCandidate newCandidate;

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncConflictCopyWith<_SyncConflict> get copyWith => __$SyncConflictCopyWithImpl<_SyncConflict>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncConflictToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncConflict&&(identical(other.conflictId, conflictId) || other.conflictId == conflictId)&&(identical(other.type, type) || other.type == type)&&(identical(other.existingRide, existingRide) || other.existingRide == existingRide)&&(identical(other.newCandidate, newCandidate) || other.newCandidate == newCandidate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conflictId,type,existingRide,newCandidate);

@override
String toString() {
  return 'SyncConflict(conflictId: $conflictId, type: $type, existingRide: $existingRide, newCandidate: $newCandidate)';
}


}

/// @nodoc
abstract mixin class _$SyncConflictCopyWith<$Res> implements $SyncConflictCopyWith<$Res> {
  factory _$SyncConflictCopyWith(_SyncConflict value, $Res Function(_SyncConflict) _then) = __$SyncConflictCopyWithImpl;
@override @useResult
$Res call({
 String conflictId, ConflictType type, Ride existingRide, MissedRideCandidate newCandidate
});


@override $RideCopyWith<$Res> get existingRide;@override $MissedRideCandidateCopyWith<$Res> get newCandidate;

}
/// @nodoc
class __$SyncConflictCopyWithImpl<$Res>
    implements _$SyncConflictCopyWith<$Res> {
  __$SyncConflictCopyWithImpl(this._self, this._then);

  final _SyncConflict _self;
  final $Res Function(_SyncConflict) _then;

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conflictId = null,Object? type = null,Object? existingRide = null,Object? newCandidate = null,}) {
  return _then(_SyncConflict(
conflictId: null == conflictId ? _self.conflictId : conflictId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ConflictType,existingRide: null == existingRide ? _self.existingRide : existingRide // ignore: cast_nullable_to_non_nullable
as Ride,newCandidate: null == newCandidate ? _self.newCandidate : newCandidate // ignore: cast_nullable_to_non_nullable
as MissedRideCandidate,
  ));
}

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideCopyWith<$Res> get existingRide {
  
  return $RideCopyWith<$Res>(_self.existingRide, (value) {
    return _then(_self.copyWith(existingRide: value));
  });
}/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MissedRideCandidateCopyWith<$Res> get newCandidate {
  
  return $MissedRideCandidateCopyWith<$Res>(_self.newCandidate, (value) {
    return _then(_self.copyWith(newCandidate: value));
  });
}
}

// dart format on
