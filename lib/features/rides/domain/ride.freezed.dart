// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ride {
  String get id;
  DateTime get date;
  double get startOdometer;
  double get endOdometer;
  int get batteryBefore;
  int get batteryAfter;
  RideMode get rideMode;
  RoadCondition get roadCondition;
  String? get notes;
  List<String> get photoPaths;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RideCopyWith<Ride> get copyWith =>
      _$RideCopyWithImpl<Ride>(this as Ride, _$identity);

  /// Serializes this Ride to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Ride &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startOdometer, startOdometer) ||
                other.startOdometer == startOdometer) &&
            (identical(other.endOdometer, endOdometer) ||
                other.endOdometer == endOdometer) &&
            (identical(other.batteryBefore, batteryBefore) ||
                other.batteryBefore == batteryBefore) &&
            (identical(other.batteryAfter, batteryAfter) ||
                other.batteryAfter == batteryAfter) &&
            (identical(other.rideMode, rideMode) ||
                other.rideMode == rideMode) &&
            (identical(other.roadCondition, roadCondition) ||
                other.roadCondition == roadCondition) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other.photoPaths, photoPaths));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      startOdometer,
      endOdometer,
      batteryBefore,
      batteryAfter,
      rideMode,
      roadCondition,
      notes,
      const DeepCollectionEquality().hash(photoPaths));

  @override
  String toString() {
    return 'Ride(id: $id, date: $date, startOdometer: $startOdometer, endOdometer: $endOdometer, batteryBefore: $batteryBefore, batteryAfter: $batteryAfter, rideMode: $rideMode, roadCondition: $roadCondition, notes: $notes, photoPaths: $photoPaths)';
  }
}

/// @nodoc
abstract mixin class $RideCopyWith<$Res> {
  factory $RideCopyWith(Ride value, $Res Function(Ride) _then) =
      _$RideCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      double startOdometer,
      double endOdometer,
      int batteryBefore,
      int batteryAfter,
      RideMode rideMode,
      RoadCondition roadCondition,
      String? notes,
      List<String> photoPaths});
}

/// @nodoc
class _$RideCopyWithImpl<$Res> implements $RideCopyWith<$Res> {
  _$RideCopyWithImpl(this._self, this._then);

  final Ride _self;
  final $Res Function(Ride) _then;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startOdometer = null,
    Object? endOdometer = null,
    Object? batteryBefore = null,
    Object? batteryAfter = null,
    Object? rideMode = null,
    Object? roadCondition = null,
    Object? notes = freezed,
    Object? photoPaths = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startOdometer: null == startOdometer
          ? _self.startOdometer
          : startOdometer // ignore: cast_nullable_to_non_nullable
              as double,
      endOdometer: null == endOdometer
          ? _self.endOdometer
          : endOdometer // ignore: cast_nullable_to_non_nullable
              as double,
      batteryBefore: null == batteryBefore
          ? _self.batteryBefore
          : batteryBefore // ignore: cast_nullable_to_non_nullable
              as int,
      batteryAfter: null == batteryAfter
          ? _self.batteryAfter
          : batteryAfter // ignore: cast_nullable_to_non_nullable
              as int,
      rideMode: null == rideMode
          ? _self.rideMode
          : rideMode // ignore: cast_nullable_to_non_nullable
              as RideMode,
      roadCondition: null == roadCondition
          ? _self.roadCondition
          : roadCondition // ignore: cast_nullable_to_non_nullable
              as RoadCondition,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoPaths: null == photoPaths
          ? _self.photoPaths
          : photoPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Ride].
extension RidePatterns on Ride {
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
    TResult Function(_Ride value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Ride() when $default != null:
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
    TResult Function(_Ride value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Ride():
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
    TResult? Function(_Ride value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Ride() when $default != null:
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
    TResult Function(
            String id,
            DateTime date,
            double startOdometer,
            double endOdometer,
            int batteryBefore,
            int batteryAfter,
            RideMode rideMode,
            RoadCondition roadCondition,
            String? notes,
            List<String> photoPaths)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Ride() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.startOdometer,
            _that.endOdometer,
            _that.batteryBefore,
            _that.batteryAfter,
            _that.rideMode,
            _that.roadCondition,
            _that.notes,
            _that.photoPaths);
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
    TResult Function(
            String id,
            DateTime date,
            double startOdometer,
            double endOdometer,
            int batteryBefore,
            int batteryAfter,
            RideMode rideMode,
            RoadCondition roadCondition,
            String? notes,
            List<String> photoPaths)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Ride():
        return $default(
            _that.id,
            _that.date,
            _that.startOdometer,
            _that.endOdometer,
            _that.batteryBefore,
            _that.batteryAfter,
            _that.rideMode,
            _that.roadCondition,
            _that.notes,
            _that.photoPaths);
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
    TResult? Function(
            String id,
            DateTime date,
            double startOdometer,
            double endOdometer,
            int batteryBefore,
            int batteryAfter,
            RideMode rideMode,
            RoadCondition roadCondition,
            String? notes,
            List<String> photoPaths)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Ride() when $default != null:
        return $default(
            _that.id,
            _that.date,
            _that.startOdometer,
            _that.endOdometer,
            _that.batteryBefore,
            _that.batteryAfter,
            _that.rideMode,
            _that.roadCondition,
            _that.notes,
            _that.photoPaths);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Ride implements Ride {
  const _Ride(
      {required this.id,
      required this.date,
      required this.startOdometer,
      required this.endOdometer,
      required this.batteryBefore,
      required this.batteryAfter,
      required this.rideMode,
      required this.roadCondition,
      this.notes,
      final List<String> photoPaths = const []})
      : _photoPaths = photoPaths;
  factory _Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final double startOdometer;
  @override
  final double endOdometer;
  @override
  final int batteryBefore;
  @override
  final int batteryAfter;
  @override
  final RideMode rideMode;
  @override
  final RoadCondition roadCondition;
  @override
  final String? notes;
  final List<String> _photoPaths;
  @override
  @JsonKey()
  List<String> get photoPaths {
    if (_photoPaths is EqualUnmodifiableListView) return _photoPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoPaths);
  }

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RideCopyWith<_Ride> get copyWith =>
      __$RideCopyWithImpl<_Ride>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RideToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ride &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startOdometer, startOdometer) ||
                other.startOdometer == startOdometer) &&
            (identical(other.endOdometer, endOdometer) ||
                other.endOdometer == endOdometer) &&
            (identical(other.batteryBefore, batteryBefore) ||
                other.batteryBefore == batteryBefore) &&
            (identical(other.batteryAfter, batteryAfter) ||
                other.batteryAfter == batteryAfter) &&
            (identical(other.rideMode, rideMode) ||
                other.rideMode == rideMode) &&
            (identical(other.roadCondition, roadCondition) ||
                other.roadCondition == roadCondition) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoPaths, _photoPaths));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      startOdometer,
      endOdometer,
      batteryBefore,
      batteryAfter,
      rideMode,
      roadCondition,
      notes,
      const DeepCollectionEquality().hash(_photoPaths));

  @override
  String toString() {
    return 'Ride(id: $id, date: $date, startOdometer: $startOdometer, endOdometer: $endOdometer, batteryBefore: $batteryBefore, batteryAfter: $batteryAfter, rideMode: $rideMode, roadCondition: $roadCondition, notes: $notes, photoPaths: $photoPaths)';
  }
}

/// @nodoc
abstract mixin class _$RideCopyWith<$Res> implements $RideCopyWith<$Res> {
  factory _$RideCopyWith(_Ride value, $Res Function(_Ride) _then) =
      __$RideCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      double startOdometer,
      double endOdometer,
      int batteryBefore,
      int batteryAfter,
      RideMode rideMode,
      RoadCondition roadCondition,
      String? notes,
      List<String> photoPaths});
}

/// @nodoc
class __$RideCopyWithImpl<$Res> implements _$RideCopyWith<$Res> {
  __$RideCopyWithImpl(this._self, this._then);

  final _Ride _self;
  final $Res Function(_Ride) _then;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startOdometer = null,
    Object? endOdometer = null,
    Object? batteryBefore = null,
    Object? batteryAfter = null,
    Object? rideMode = null,
    Object? roadCondition = null,
    Object? notes = freezed,
    Object? photoPaths = null,
  }) {
    return _then(_Ride(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startOdometer: null == startOdometer
          ? _self.startOdometer
          : startOdometer // ignore: cast_nullable_to_non_nullable
              as double,
      endOdometer: null == endOdometer
          ? _self.endOdometer
          : endOdometer // ignore: cast_nullable_to_non_nullable
              as double,
      batteryBefore: null == batteryBefore
          ? _self.batteryBefore
          : batteryBefore // ignore: cast_nullable_to_non_nullable
              as int,
      batteryAfter: null == batteryAfter
          ? _self.batteryAfter
          : batteryAfter // ignore: cast_nullable_to_non_nullable
              as int,
      rideMode: null == rideMode
          ? _self.rideMode
          : rideMode // ignore: cast_nullable_to_non_nullable
              as RideMode,
      roadCondition: null == roadCondition
          ? _self.roadCondition
          : roadCondition // ignore: cast_nullable_to_non_nullable
              as RoadCondition,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoPaths: null == photoPaths
          ? _self._photoPaths
          : photoPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
