// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_engine_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncEngineState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncEngineState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEngineState()';
}


}

/// @nodoc
class $SyncEngineStateCopyWith<$Res>  {
$SyncEngineStateCopyWith(SyncEngineState _, $Res Function(SyncEngineState) __);
}


/// Adds pattern-matching-related methods to [SyncEngineState].
extension SyncEngineStatePatterns on SyncEngineState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Syncing value)?  syncing,TResult Function( _Success value)?  success,TResult Function( _NeedsConflictResolution value)?  needsConflictResolution,TResult Function( _NeedsReview value)?  needsReview,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Syncing() when syncing != null:
return syncing(_that);case _Success() when success != null:
return success(_that);case _NeedsConflictResolution() when needsConflictResolution != null:
return needsConflictResolution(_that);case _NeedsReview() when needsReview != null:
return needsReview(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Syncing value)  syncing,required TResult Function( _Success value)  success,required TResult Function( _NeedsConflictResolution value)  needsConflictResolution,required TResult Function( _NeedsReview value)  needsReview,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Syncing():
return syncing(_that);case _Success():
return success(_that);case _NeedsConflictResolution():
return needsConflictResolution(_that);case _NeedsReview():
return needsReview(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Syncing value)?  syncing,TResult? Function( _Success value)?  success,TResult? Function( _NeedsConflictResolution value)?  needsConflictResolution,TResult? Function( _NeedsReview value)?  needsReview,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Syncing() when syncing != null:
return syncing(_that);case _Success() when success != null:
return success(_that);case _NeedsConflictResolution() when needsConflictResolution != null:
return needsConflictResolution(_that);case _NeedsReview() when needsReview != null:
return needsReview(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  syncing,TResult Function( int ridesAdded,  int chargesAdded)?  success,TResult Function( List<SyncConflict> conflicts)?  needsConflictResolution,TResult Function( List<MissedRideCandidate> candidates)?  needsReview,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Syncing() when syncing != null:
return syncing();case _Success() when success != null:
return success(_that.ridesAdded,_that.chargesAdded);case _NeedsConflictResolution() when needsConflictResolution != null:
return needsConflictResolution(_that.conflicts);case _NeedsReview() when needsReview != null:
return needsReview(_that.candidates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  syncing,required TResult Function( int ridesAdded,  int chargesAdded)  success,required TResult Function( List<SyncConflict> conflicts)  needsConflictResolution,required TResult Function( List<MissedRideCandidate> candidates)  needsReview,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Syncing():
return syncing();case _Success():
return success(_that.ridesAdded,_that.chargesAdded);case _NeedsConflictResolution():
return needsConflictResolution(_that.conflicts);case _NeedsReview():
return needsReview(_that.candidates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  syncing,TResult? Function( int ridesAdded,  int chargesAdded)?  success,TResult? Function( List<SyncConflict> conflicts)?  needsConflictResolution,TResult? Function( List<MissedRideCandidate> candidates)?  needsReview,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Syncing() when syncing != null:
return syncing();case _Success() when success != null:
return success(_that.ridesAdded,_that.chargesAdded);case _NeedsConflictResolution() when needsConflictResolution != null:
return needsConflictResolution(_that.conflicts);case _NeedsReview() when needsReview != null:
return needsReview(_that.candidates);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements SyncEngineState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEngineState.idle()';
}


}




/// @nodoc


class _Syncing implements SyncEngineState {
  const _Syncing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Syncing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEngineState.syncing()';
}


}




/// @nodoc


class _Success implements SyncEngineState {
  const _Success({required this.ridesAdded, required this.chargesAdded});
  

 final  int ridesAdded;
 final  int chargesAdded;

/// Create a copy of SyncEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.ridesAdded, ridesAdded) || other.ridesAdded == ridesAdded)&&(identical(other.chargesAdded, chargesAdded) || other.chargesAdded == chargesAdded));
}


@override
int get hashCode => Object.hash(runtimeType,ridesAdded,chargesAdded);

@override
String toString() {
  return 'SyncEngineState.success(ridesAdded: $ridesAdded, chargesAdded: $chargesAdded)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SyncEngineStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 int ridesAdded, int chargesAdded
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SyncEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ridesAdded = null,Object? chargesAdded = null,}) {
  return _then(_Success(
ridesAdded: null == ridesAdded ? _self.ridesAdded : ridesAdded // ignore: cast_nullable_to_non_nullable
as int,chargesAdded: null == chargesAdded ? _self.chargesAdded : chargesAdded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _NeedsConflictResolution implements SyncEngineState {
  const _NeedsConflictResolution(final  List<SyncConflict> conflicts): _conflicts = conflicts;
  

 final  List<SyncConflict> _conflicts;
 List<SyncConflict> get conflicts {
  if (_conflicts is EqualUnmodifiableListView) return _conflicts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conflicts);
}


/// Create a copy of SyncEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeedsConflictResolutionCopyWith<_NeedsConflictResolution> get copyWith => __$NeedsConflictResolutionCopyWithImpl<_NeedsConflictResolution>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedsConflictResolution&&const DeepCollectionEquality().equals(other._conflicts, _conflicts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_conflicts));

@override
String toString() {
  return 'SyncEngineState.needsConflictResolution(conflicts: $conflicts)';
}


}

/// @nodoc
abstract mixin class _$NeedsConflictResolutionCopyWith<$Res> implements $SyncEngineStateCopyWith<$Res> {
  factory _$NeedsConflictResolutionCopyWith(_NeedsConflictResolution value, $Res Function(_NeedsConflictResolution) _then) = __$NeedsConflictResolutionCopyWithImpl;
@useResult
$Res call({
 List<SyncConflict> conflicts
});




}
/// @nodoc
class __$NeedsConflictResolutionCopyWithImpl<$Res>
    implements _$NeedsConflictResolutionCopyWith<$Res> {
  __$NeedsConflictResolutionCopyWithImpl(this._self, this._then);

  final _NeedsConflictResolution _self;
  final $Res Function(_NeedsConflictResolution) _then;

/// Create a copy of SyncEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? conflicts = null,}) {
  return _then(_NeedsConflictResolution(
null == conflicts ? _self._conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as List<SyncConflict>,
  ));
}


}

/// @nodoc


class _NeedsReview implements SyncEngineState {
  const _NeedsReview(final  List<MissedRideCandidate> candidates): _candidates = candidates;
  

 final  List<MissedRideCandidate> _candidates;
 List<MissedRideCandidate> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}


/// Create a copy of SyncEngineState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeedsReviewCopyWith<_NeedsReview> get copyWith => __$NeedsReviewCopyWithImpl<_NeedsReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedsReview&&const DeepCollectionEquality().equals(other._candidates, _candidates));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_candidates));

@override
String toString() {
  return 'SyncEngineState.needsReview(candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class _$NeedsReviewCopyWith<$Res> implements $SyncEngineStateCopyWith<$Res> {
  factory _$NeedsReviewCopyWith(_NeedsReview value, $Res Function(_NeedsReview) _then) = __$NeedsReviewCopyWithImpl;
@useResult
$Res call({
 List<MissedRideCandidate> candidates
});




}
/// @nodoc
class __$NeedsReviewCopyWithImpl<$Res>
    implements _$NeedsReviewCopyWith<$Res> {
  __$NeedsReviewCopyWithImpl(this._self, this._then);

  final _NeedsReview _self;
  final $Res Function(_NeedsReview) _then;

/// Create a copy of SyncEngineState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? candidates = null,}) {
  return _then(_NeedsReview(
null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<MissedRideCandidate>,
  ));
}


}

// dart format on
