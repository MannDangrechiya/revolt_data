// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'maintenance_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaintenanceLog {
  String get id;
  DateTime get date;
  MaintenanceComponent get component;
  String get description;
  double get odometerReading;
  double get cost;

  /// Create a copy of MaintenanceLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MaintenanceLogCopyWith<MaintenanceLog> get copyWith =>
      _$MaintenanceLogCopyWithImpl<MaintenanceLog>(
          this as MaintenanceLog, _$identity);

  /// Serializes this MaintenanceLog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MaintenanceLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.component, component) ||
                other.component == component) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.odometerReading, odometerReading) ||
                other.odometerReading == odometerReading) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, component, description, odometerReading, cost);

  @override
  String toString() {
    return 'MaintenanceLog(id: $id, date: $date, component: $component, description: $description, odometerReading: $odometerReading, cost: $cost)';
  }
}

/// @nodoc
abstract mixin class $MaintenanceLogCopyWith<$Res> {
  factory $MaintenanceLogCopyWith(
          MaintenanceLog value, $Res Function(MaintenanceLog) _then) =
      _$MaintenanceLogCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      MaintenanceComponent component,
      String description,
      double odometerReading,
      double cost});
}

/// @nodoc
class _$MaintenanceLogCopyWithImpl<$Res>
    implements $MaintenanceLogCopyWith<$Res> {
  _$MaintenanceLogCopyWithImpl(this._self, this._then);

  final MaintenanceLog _self;
  final $Res Function(MaintenanceLog) _then;

  /// Create a copy of MaintenanceLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? component = null,
    Object? description = null,
    Object? odometerReading = null,
    Object? cost = null,
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
      component: null == component
          ? _self.component
          : component // ignore: cast_nullable_to_non_nullable
              as MaintenanceComponent,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      odometerReading: null == odometerReading
          ? _self.odometerReading
          : odometerReading // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _self.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [MaintenanceLog].
extension MaintenanceLogPatterns on MaintenanceLog {
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
    TResult Function(_MaintenanceLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MaintenanceLog() when $default != null:
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
    TResult Function(_MaintenanceLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MaintenanceLog():
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
    TResult? Function(_MaintenanceLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MaintenanceLog() when $default != null:
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
    TResult Function(String id, DateTime date, MaintenanceComponent component,
            String description, double odometerReading, double cost)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MaintenanceLog() when $default != null:
        return $default(_that.id, _that.date, _that.component,
            _that.description, _that.odometerReading, _that.cost);
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
    TResult Function(String id, DateTime date, MaintenanceComponent component,
            String description, double odometerReading, double cost)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MaintenanceLog():
        return $default(_that.id, _that.date, _that.component,
            _that.description, _that.odometerReading, _that.cost);
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
    TResult? Function(String id, DateTime date, MaintenanceComponent component,
            String description, double odometerReading, double cost)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MaintenanceLog() when $default != null:
        return $default(_that.id, _that.date, _that.component,
            _that.description, _that.odometerReading, _that.cost);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MaintenanceLog implements MaintenanceLog {
  const _MaintenanceLog(
      {required this.id,
      required this.date,
      required this.component,
      required this.description,
      required this.odometerReading,
      required this.cost});
  factory _MaintenanceLog.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceLogFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final MaintenanceComponent component;
  @override
  final String description;
  @override
  final double odometerReading;
  @override
  final double cost;

  /// Create a copy of MaintenanceLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MaintenanceLogCopyWith<_MaintenanceLog> get copyWith =>
      __$MaintenanceLogCopyWithImpl<_MaintenanceLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MaintenanceLogToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MaintenanceLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.component, component) ||
                other.component == component) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.odometerReading, odometerReading) ||
                other.odometerReading == odometerReading) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, component, description, odometerReading, cost);

  @override
  String toString() {
    return 'MaintenanceLog(id: $id, date: $date, component: $component, description: $description, odometerReading: $odometerReading, cost: $cost)';
  }
}

/// @nodoc
abstract mixin class _$MaintenanceLogCopyWith<$Res>
    implements $MaintenanceLogCopyWith<$Res> {
  factory _$MaintenanceLogCopyWith(
          _MaintenanceLog value, $Res Function(_MaintenanceLog) _then) =
      __$MaintenanceLogCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      MaintenanceComponent component,
      String description,
      double odometerReading,
      double cost});
}

/// @nodoc
class __$MaintenanceLogCopyWithImpl<$Res>
    implements _$MaintenanceLogCopyWith<$Res> {
  __$MaintenanceLogCopyWithImpl(this._self, this._then);

  final _MaintenanceLog _self;
  final $Res Function(_MaintenanceLog) _then;

  /// Create a copy of MaintenanceLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? component = null,
    Object? description = null,
    Object? odometerReading = null,
    Object? cost = null,
  }) {
    return _then(_MaintenanceLog(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      component: null == component
          ? _self.component
          : component // ignore: cast_nullable_to_non_nullable
              as MaintenanceComponent,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      odometerReading: null == odometerReading
          ? _self.odometerReading
          : odometerReading // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _self.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
