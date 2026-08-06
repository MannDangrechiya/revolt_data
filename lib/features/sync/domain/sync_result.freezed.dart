// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncResult()';
}


}

/// @nodoc
class $SyncResultCopyWith<$Res>  {
$SyncResultCopyWith(SyncResult _, $Res Function(SyncResult) __);
}


/// Adds pattern-matching-related methods to [SyncResult].
extension SyncResultPatterns on SyncResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _NothingToSync value)?  nothingToSync,TResult Function( _SyncedSuccessfully value)?  syncedSuccessfully,TResult Function( _ConflictsDetected value)?  conflictsDetected,TResult Function( _MissedRidesDetected value)?  missedRidesDetected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NothingToSync() when nothingToSync != null:
return nothingToSync(_that);case _SyncedSuccessfully() when syncedSuccessfully != null:
return syncedSuccessfully(_that);case _ConflictsDetected() when conflictsDetected != null:
return conflictsDetected(_that);case _MissedRidesDetected() when missedRidesDetected != null:
return missedRidesDetected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _NothingToSync value)  nothingToSync,required TResult Function( _SyncedSuccessfully value)  syncedSuccessfully,required TResult Function( _ConflictsDetected value)  conflictsDetected,required TResult Function( _MissedRidesDetected value)  missedRidesDetected,}){
final _that = this;
switch (_that) {
case _NothingToSync():
return nothingToSync(_that);case _SyncedSuccessfully():
return syncedSuccessfully(_that);case _ConflictsDetected():
return conflictsDetected(_that);case _MissedRidesDetected():
return missedRidesDetected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _NothingToSync value)?  nothingToSync,TResult? Function( _SyncedSuccessfully value)?  syncedSuccessfully,TResult? Function( _ConflictsDetected value)?  conflictsDetected,TResult? Function( _MissedRidesDetected value)?  missedRidesDetected,}){
final _that = this;
switch (_that) {
case _NothingToSync() when nothingToSync != null:
return nothingToSync(_that);case _SyncedSuccessfully() when syncedSuccessfully != null:
return syncedSuccessfully(_that);case _ConflictsDetected() when conflictsDetected != null:
return conflictsDetected(_that);case _MissedRidesDetected() when missedRidesDetected != null:
return missedRidesDetected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  nothingToSync,TResult Function( int ridesAdded,  int chargesAdded)?  syncedSuccessfully,TResult Function( List<SyncConflict> conflicts)?  conflictsDetected,TResult Function( List<MissedRideCandidate> candidates)?  missedRidesDetected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NothingToSync() when nothingToSync != null:
return nothingToSync();case _SyncedSuccessfully() when syncedSuccessfully != null:
return syncedSuccessfully(_that.ridesAdded,_that.chargesAdded);case _ConflictsDetected() when conflictsDetected != null:
return conflictsDetected(_that.conflicts);case _MissedRidesDetected() when missedRidesDetected != null:
return missedRidesDetected(_that.candidates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  nothingToSync,required TResult Function( int ridesAdded,  int chargesAdded)  syncedSuccessfully,required TResult Function( List<SyncConflict> conflicts)  conflictsDetected,required TResult Function( List<MissedRideCandidate> candidates)  missedRidesDetected,}) {final _that = this;
switch (_that) {
case _NothingToSync():
return nothingToSync();case _SyncedSuccessfully():
return syncedSuccessfully(_that.ridesAdded,_that.chargesAdded);case _ConflictsDetected():
return conflictsDetected(_that.conflicts);case _MissedRidesDetected():
return missedRidesDetected(_that.candidates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  nothingToSync,TResult? Function( int ridesAdded,  int chargesAdded)?  syncedSuccessfully,TResult? Function( List<SyncConflict> conflicts)?  conflictsDetected,TResult? Function( List<MissedRideCandidate> candidates)?  missedRidesDetected,}) {final _that = this;
switch (_that) {
case _NothingToSync() when nothingToSync != null:
return nothingToSync();case _SyncedSuccessfully() when syncedSuccessfully != null:
return syncedSuccessfully(_that.ridesAdded,_that.chargesAdded);case _ConflictsDetected() when conflictsDetected != null:
return conflictsDetected(_that.conflicts);case _MissedRidesDetected() when missedRidesDetected != null:
return missedRidesDetected(_that.candidates);case _:
  return null;

}
}

}

/// @nodoc


class _NothingToSync implements SyncResult {
  const _NothingToSync();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NothingToSync);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncResult.nothingToSync()';
}


}




/// @nodoc


class _SyncedSuccessfully implements SyncResult {
  const _SyncedSuccessfully({required this.ridesAdded, required this.chargesAdded});
  

 final  int ridesAdded;
 final  int chargesAdded;

/// Create a copy of SyncResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncedSuccessfullyCopyWith<_SyncedSuccessfully> get copyWith => __$SyncedSuccessfullyCopyWithImpl<_SyncedSuccessfully>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncedSuccessfully&&(identical(other.ridesAdded, ridesAdded) || other.ridesAdded == ridesAdded)&&(identical(other.chargesAdded, chargesAdded) || other.chargesAdded == chargesAdded));
}


@override
int get hashCode => Object.hash(runtimeType,ridesAdded,chargesAdded);

@override
String toString() {
  return 'SyncResult.syncedSuccessfully(ridesAdded: $ridesAdded, chargesAdded: $chargesAdded)';
}


}

/// @nodoc
abstract mixin class _$SyncedSuccessfullyCopyWith<$Res> implements $SyncResultCopyWith<$Res> {
  factory _$SyncedSuccessfullyCopyWith(_SyncedSuccessfully value, $Res Function(_SyncedSuccessfully) _then) = __$SyncedSuccessfullyCopyWithImpl;
@useResult
$Res call({
 int ridesAdded, int chargesAdded
});




}
/// @nodoc
class __$SyncedSuccessfullyCopyWithImpl<$Res>
    implements _$SyncedSuccessfullyCopyWith<$Res> {
  __$SyncedSuccessfullyCopyWithImpl(this._self, this._then);

  final _SyncedSuccessfully _self;
  final $Res Function(_SyncedSuccessfully) _then;

/// Create a copy of SyncResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ridesAdded = null,Object? chargesAdded = null,}) {
  return _then(_SyncedSuccessfully(
ridesAdded: null == ridesAdded ? _self.ridesAdded : ridesAdded // ignore: cast_nullable_to_non_nullable
as int,chargesAdded: null == chargesAdded ? _self.chargesAdded : chargesAdded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ConflictsDetected implements SyncResult {
  const _ConflictsDetected({required final  List<SyncConflict> conflicts}): _conflicts = conflicts;
  

 final  List<SyncConflict> _conflicts;
 List<SyncConflict> get conflicts {
  if (_conflicts is EqualUnmodifiableListView) return _conflicts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conflicts);
}


/// Create a copy of SyncResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConflictsDetectedCopyWith<_ConflictsDetected> get copyWith => __$ConflictsDetectedCopyWithImpl<_ConflictsDetected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConflictsDetected&&const DeepCollectionEquality().equals(other._conflicts, _conflicts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_conflicts));

@override
String toString() {
  return 'SyncResult.conflictsDetected(conflicts: $conflicts)';
}


}

/// @nodoc
abstract mixin class _$ConflictsDetectedCopyWith<$Res> implements $SyncResultCopyWith<$Res> {
  factory _$ConflictsDetectedCopyWith(_ConflictsDetected value, $Res Function(_ConflictsDetected) _then) = __$ConflictsDetectedCopyWithImpl;
@useResult
$Res call({
 List<SyncConflict> conflicts
});




}
/// @nodoc
class __$ConflictsDetectedCopyWithImpl<$Res>
    implements _$ConflictsDetectedCopyWith<$Res> {
  __$ConflictsDetectedCopyWithImpl(this._self, this._then);

  final _ConflictsDetected _self;
  final $Res Function(_ConflictsDetected) _then;

/// Create a copy of SyncResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conflicts = null,}) {
  return _then(_ConflictsDetected(
conflicts: null == conflicts ? _self._conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as List<SyncConflict>,
  ));
}


}

/// @nodoc


class _MissedRidesDetected implements SyncResult {
  const _MissedRidesDetected({required final  List<MissedRideCandidate> candidates}): _candidates = candidates;
  

 final  List<MissedRideCandidate> _candidates;
 List<MissedRideCandidate> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}


/// Create a copy of SyncResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissedRidesDetectedCopyWith<_MissedRidesDetected> get copyWith => __$MissedRidesDetectedCopyWithImpl<_MissedRidesDetected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissedRidesDetected&&const DeepCollectionEquality().equals(other._candidates, _candidates));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_candidates));

@override
String toString() {
  return 'SyncResult.missedRidesDetected(candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class _$MissedRidesDetectedCopyWith<$Res> implements $SyncResultCopyWith<$Res> {
  factory _$MissedRidesDetectedCopyWith(_MissedRidesDetected value, $Res Function(_MissedRidesDetected) _then) = __$MissedRidesDetectedCopyWithImpl;
@useResult
$Res call({
 List<MissedRideCandidate> candidates
});




}
/// @nodoc
class __$MissedRidesDetectedCopyWithImpl<$Res>
    implements _$MissedRidesDetectedCopyWith<$Res> {
  __$MissedRidesDetectedCopyWithImpl(this._self, this._then);

  final _MissedRidesDetected _self;
  final $Res Function(_MissedRidesDetected) _then;

/// Create a copy of SyncResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? candidates = null,}) {
  return _then(_MissedRidesDetected(
candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<MissedRideCandidate>,
  ));
}


}

// dart format on
