// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reminder {
  String get id;
  String get title;
  String get body;
  DateTime? get targetDate;
  double? get targetOdometer;
  bool get isCompleted;
  bool get isNotified;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReminderCopyWith<Reminder> get copyWith =>
      _$ReminderCopyWithImpl<Reminder>(this as Reminder, _$identity);

  /// Serializes this Reminder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Reminder &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.targetOdometer, targetOdometer) ||
                other.targetOdometer == targetOdometer) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isNotified, isNotified) ||
                other.isNotified == isNotified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, targetDate,
      targetOdometer, isCompleted, isNotified);

  @override
  String toString() {
    return 'Reminder(id: $id, title: $title, body: $body, targetDate: $targetDate, targetOdometer: $targetOdometer, isCompleted: $isCompleted, isNotified: $isNotified)';
  }
}

/// @nodoc
abstract mixin class $ReminderCopyWith<$Res> {
  factory $ReminderCopyWith(Reminder value, $Res Function(Reminder) _then) =
      _$ReminderCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      DateTime? targetDate,
      double? targetOdometer,
      bool isCompleted,
      bool isNotified});
}

/// @nodoc
class _$ReminderCopyWithImpl<$Res> implements $ReminderCopyWith<$Res> {
  _$ReminderCopyWithImpl(this._self, this._then);

  final Reminder _self;
  final $Res Function(Reminder) _then;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? targetDate = freezed,
    Object? targetOdometer = freezed,
    Object? isCompleted = null,
    Object? isNotified = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: freezed == targetDate
          ? _self.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetOdometer: freezed == targetOdometer
          ? _self.targetOdometer
          : targetOdometer // ignore: cast_nullable_to_non_nullable
              as double?,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotified: null == isNotified
          ? _self.isNotified
          : isNotified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Reminder].
extension ReminderPatterns on Reminder {
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
    TResult Function(_Reminder value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Reminder() when $default != null:
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
    TResult Function(_Reminder value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Reminder():
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
    TResult? Function(_Reminder value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Reminder() when $default != null:
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
    TResult Function(String id, String title, String body, DateTime? targetDate,
            double? targetOdometer, bool isCompleted, bool isNotified)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Reminder() when $default != null:
        return $default(_that.id, _that.title, _that.body, _that.targetDate,
            _that.targetOdometer, _that.isCompleted, _that.isNotified);
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
    TResult Function(String id, String title, String body, DateTime? targetDate,
            double? targetOdometer, bool isCompleted, bool isNotified)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Reminder():
        return $default(_that.id, _that.title, _that.body, _that.targetDate,
            _that.targetOdometer, _that.isCompleted, _that.isNotified);
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
            String title,
            String body,
            DateTime? targetDate,
            double? targetOdometer,
            bool isCompleted,
            bool isNotified)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Reminder() when $default != null:
        return $default(_that.id, _that.title, _that.body, _that.targetDate,
            _that.targetOdometer, _that.isCompleted, _that.isNotified);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Reminder implements Reminder {
  const _Reminder(
      {required this.id,
      required this.title,
      required this.body,
      this.targetDate,
      this.targetOdometer,
      this.isCompleted = false,
      this.isNotified = false});
  factory _Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final DateTime? targetDate;
  @override
  final double? targetOdometer;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isNotified;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReminderCopyWith<_Reminder> get copyWith =>
      __$ReminderCopyWithImpl<_Reminder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReminderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Reminder &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.targetOdometer, targetOdometer) ||
                other.targetOdometer == targetOdometer) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isNotified, isNotified) ||
                other.isNotified == isNotified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, targetDate,
      targetOdometer, isCompleted, isNotified);

  @override
  String toString() {
    return 'Reminder(id: $id, title: $title, body: $body, targetDate: $targetDate, targetOdometer: $targetOdometer, isCompleted: $isCompleted, isNotified: $isNotified)';
  }
}

/// @nodoc
abstract mixin class _$ReminderCopyWith<$Res>
    implements $ReminderCopyWith<$Res> {
  factory _$ReminderCopyWith(_Reminder value, $Res Function(_Reminder) _then) =
      __$ReminderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      DateTime? targetDate,
      double? targetOdometer,
      bool isCompleted,
      bool isNotified});
}

/// @nodoc
class __$ReminderCopyWithImpl<$Res> implements _$ReminderCopyWith<$Res> {
  __$ReminderCopyWithImpl(this._self, this._then);

  final _Reminder _self;
  final $Res Function(_Reminder) _then;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? targetDate = freezed,
    Object? targetOdometer = freezed,
    Object? isCompleted = null,
    Object? isNotified = null,
  }) {
    return _then(_Reminder(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: freezed == targetDate
          ? _self.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetOdometer: freezed == targetOdometer
          ? _self.targetOdometer
          : targetOdometer // ignore: cast_nullable_to_non_nullable
              as double?,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotified: null == isNotified
          ? _self.isNotified
          : isNotified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
