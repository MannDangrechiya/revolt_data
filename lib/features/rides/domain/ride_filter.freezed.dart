// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RideFilter {
  RideMode? get rideMode;
  RoadCondition? get roadCondition;
  DateTimeRange? get dateRange;
  String? get searchQuery;

  /// Create a copy of RideFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RideFilterCopyWith<RideFilter> get copyWith =>
      _$RideFilterCopyWithImpl<RideFilter>(this as RideFilter, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RideFilter &&
            (identical(other.rideMode, rideMode) ||
                other.rideMode == rideMode) &&
            (identical(other.roadCondition, roadCondition) ||
                other.roadCondition == roadCondition) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, rideMode, roadCondition, dateRange, searchQuery);

  @override
  String toString() {
    return 'RideFilter(rideMode: $rideMode, roadCondition: $roadCondition, dateRange: $dateRange, searchQuery: $searchQuery)';
  }
}

/// @nodoc
abstract mixin class $RideFilterCopyWith<$Res> {
  factory $RideFilterCopyWith(
          RideFilter value, $Res Function(RideFilter) _then) =
      _$RideFilterCopyWithImpl;
  @useResult
  $Res call(
      {RideMode? rideMode,
      RoadCondition? roadCondition,
      DateTimeRange? dateRange,
      String? searchQuery});
}

/// @nodoc
class _$RideFilterCopyWithImpl<$Res> implements $RideFilterCopyWith<$Res> {
  _$RideFilterCopyWithImpl(this._self, this._then);

  final RideFilter _self;
  final $Res Function(RideFilter) _then;

  /// Create a copy of RideFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideMode = freezed,
    Object? roadCondition = freezed,
    Object? dateRange = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_self.copyWith(
      rideMode: freezed == rideMode
          ? _self.rideMode
          : rideMode // ignore: cast_nullable_to_non_nullable
              as RideMode?,
      roadCondition: freezed == roadCondition
          ? _self.roadCondition
          : roadCondition // ignore: cast_nullable_to_non_nullable
              as RoadCondition?,
      dateRange: freezed == dateRange
          ? _self.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RideFilter].
extension RideFilterPatterns on RideFilter {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RideFilter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RideFilter() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RideFilter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RideFilter():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RideFilter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RideFilter() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(RideMode? rideMode, RoadCondition? roadCondition,
            DateTimeRange? dateRange, String? searchQuery)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RideFilter() when $default != null:
        return $default(_that.rideMode, _that.roadCondition, _that.dateRange,
            _that.searchQuery);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(RideMode? rideMode, RoadCondition? roadCondition,
            DateTimeRange? dateRange, String? searchQuery)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RideFilter():
        return $default(_that.rideMode, _that.roadCondition, _that.dateRange,
            _that.searchQuery);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(RideMode? rideMode, RoadCondition? roadCondition,
            DateTimeRange? dateRange, String? searchQuery)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RideFilter() when $default != null:
        return $default(_that.rideMode, _that.roadCondition, _that.dateRange,
            _that.searchQuery);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RideFilter implements RideFilter {
  const _RideFilter(
      {this.rideMode, this.roadCondition, this.dateRange, this.searchQuery});

  @override
  final RideMode? rideMode;
  @override
  final RoadCondition? roadCondition;
  @override
  final DateTimeRange? dateRange;
  @override
  final String? searchQuery;

  /// Create a copy of RideFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RideFilterCopyWith<_RideFilter> get copyWith =>
      __$RideFilterCopyWithImpl<_RideFilter>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RideFilter &&
            (identical(other.rideMode, rideMode) ||
                other.rideMode == rideMode) &&
            (identical(other.roadCondition, roadCondition) ||
                other.roadCondition == roadCondition) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, rideMode, roadCondition, dateRange, searchQuery);

  @override
  String toString() {
    return 'RideFilter(rideMode: $rideMode, roadCondition: $roadCondition, dateRange: $dateRange, searchQuery: $searchQuery)';
  }
}

/// @nodoc
abstract mixin class _$RideFilterCopyWith<$Res>
    implements $RideFilterCopyWith<$Res> {
  factory _$RideFilterCopyWith(
          _RideFilter value, $Res Function(_RideFilter) _then) =
      __$RideFilterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {RideMode? rideMode,
      RoadCondition? roadCondition,
      DateTimeRange? dateRange,
      String? searchQuery});
}

/// @nodoc
class __$RideFilterCopyWithImpl<$Res> implements _$RideFilterCopyWith<$Res> {
  __$RideFilterCopyWithImpl(this._self, this._then);

  final _RideFilter _self;
  final $Res Function(_RideFilter) _then;

  /// Create a copy of RideFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rideMode = freezed,
    Object? roadCondition = freezed,
    Object? dateRange = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_RideFilter(
      rideMode: freezed == rideMode
          ? _self.rideMode
          : rideMode // ignore: cast_nullable_to_non_nullable
              as RideMode?,
      roadCondition: freezed == roadCondition
          ? _self.roadCondition
          : roadCondition // ignore: cast_nullable_to_non_nullable
              as RoadCondition?,
      dateRange: freezed == dateRange
          ? _self.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
