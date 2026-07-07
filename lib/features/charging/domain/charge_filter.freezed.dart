// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'charge_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChargeFilter {

 LocationType? get locationType; String? get chargerType; DateTimeRange? get dateRange; String? get searchQuery;
/// Create a copy of ChargeFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChargeFilterCopyWith<ChargeFilter> get copyWith => _$ChargeFilterCopyWithImpl<ChargeFilter>(this as ChargeFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChargeFilter&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.chargerType, chargerType) || other.chargerType == chargerType)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,locationType,chargerType,dateRange,searchQuery);

@override
String toString() {
  return 'ChargeFilter(locationType: $locationType, chargerType: $chargerType, dateRange: $dateRange, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $ChargeFilterCopyWith<$Res>  {
  factory $ChargeFilterCopyWith(ChargeFilter value, $Res Function(ChargeFilter) _then) = _$ChargeFilterCopyWithImpl;
@useResult
$Res call({
 LocationType? locationType, String? chargerType, DateTimeRange? dateRange, String? searchQuery
});




}
/// @nodoc
class _$ChargeFilterCopyWithImpl<$Res>
    implements $ChargeFilterCopyWith<$Res> {
  _$ChargeFilterCopyWithImpl(this._self, this._then);

  final ChargeFilter _self;
  final $Res Function(ChargeFilter) _then;

/// Create a copy of ChargeFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locationType = freezed,Object? chargerType = freezed,Object? dateRange = freezed,Object? searchQuery = freezed,}) {
  return _then(_self.copyWith(
locationType: freezed == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as LocationType?,chargerType: freezed == chargerType ? _self.chargerType : chargerType // ignore: cast_nullable_to_non_nullable
as String?,dateRange: freezed == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateTimeRange?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChargeFilter].
extension ChargeFilterPatterns on ChargeFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChargeFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChargeFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChargeFilter value)  $default,){
final _that = this;
switch (_that) {
case _ChargeFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChargeFilter value)?  $default,){
final _that = this;
switch (_that) {
case _ChargeFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocationType? locationType,  String? chargerType,  DateTimeRange? dateRange,  String? searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChargeFilter() when $default != null:
return $default(_that.locationType,_that.chargerType,_that.dateRange,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocationType? locationType,  String? chargerType,  DateTimeRange? dateRange,  String? searchQuery)  $default,) {final _that = this;
switch (_that) {
case _ChargeFilter():
return $default(_that.locationType,_that.chargerType,_that.dateRange,_that.searchQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocationType? locationType,  String? chargerType,  DateTimeRange? dateRange,  String? searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _ChargeFilter() when $default != null:
return $default(_that.locationType,_that.chargerType,_that.dateRange,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _ChargeFilter implements ChargeFilter {
  const _ChargeFilter({this.locationType, this.chargerType, this.dateRange, this.searchQuery});
  

@override final  LocationType? locationType;
@override final  String? chargerType;
@override final  DateTimeRange? dateRange;
@override final  String? searchQuery;

/// Create a copy of ChargeFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChargeFilterCopyWith<_ChargeFilter> get copyWith => __$ChargeFilterCopyWithImpl<_ChargeFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChargeFilter&&(identical(other.locationType, locationType) || other.locationType == locationType)&&(identical(other.chargerType, chargerType) || other.chargerType == chargerType)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,locationType,chargerType,dateRange,searchQuery);

@override
String toString() {
  return 'ChargeFilter(locationType: $locationType, chargerType: $chargerType, dateRange: $dateRange, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$ChargeFilterCopyWith<$Res> implements $ChargeFilterCopyWith<$Res> {
  factory _$ChargeFilterCopyWith(_ChargeFilter value, $Res Function(_ChargeFilter) _then) = __$ChargeFilterCopyWithImpl;
@override @useResult
$Res call({
 LocationType? locationType, String? chargerType, DateTimeRange? dateRange, String? searchQuery
});




}
/// @nodoc
class __$ChargeFilterCopyWithImpl<$Res>
    implements _$ChargeFilterCopyWith<$Res> {
  __$ChargeFilterCopyWithImpl(this._self, this._then);

  final _ChargeFilter _self;
  final $Res Function(_ChargeFilter) _then;

/// Create a copy of ChargeFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locationType = freezed,Object? chargerType = freezed,Object? dateRange = freezed,Object? searchQuery = freezed,}) {
  return _then(_ChargeFilter(
locationType: freezed == locationType ? _self.locationType : locationType // ignore: cast_nullable_to_non_nullable
as LocationType?,chargerType: freezed == chargerType ? _self.chargerType : chargerType // ignore: cast_nullable_to_non_nullable
as String?,dateRange: freezed == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateTimeRange?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
