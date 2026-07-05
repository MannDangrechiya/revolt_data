// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BatteryState {
  int get percentage;
  double get estimatedRange;

  /// Create a copy of BatteryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BatteryStateCopyWith<BatteryState> get copyWith =>
      _$BatteryStateCopyWithImpl<BatteryState>(
          this as BatteryState, _$identity);

  /// Serializes this BatteryState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BatteryState &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.estimatedRange, estimatedRange) ||
                other.estimatedRange == estimatedRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, percentage, estimatedRange);

  @override
  String toString() {
    return 'BatteryState(percentage: $percentage, estimatedRange: $estimatedRange)';
  }
}

/// @nodoc
abstract mixin class $BatteryStateCopyWith<$Res> {
  factory $BatteryStateCopyWith(
          BatteryState value, $Res Function(BatteryState) _then) =
      _$BatteryStateCopyWithImpl;
  @useResult
  $Res call({int percentage, double estimatedRange});
}

/// @nodoc
class _$BatteryStateCopyWithImpl<$Res> implements $BatteryStateCopyWith<$Res> {
  _$BatteryStateCopyWithImpl(this._self, this._then);

  final BatteryState _self;
  final $Res Function(BatteryState) _then;

  /// Create a copy of BatteryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? estimatedRange = null,
  }) {
    return _then(_self.copyWith(
      percentage: null == percentage
          ? _self.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedRange: null == estimatedRange
          ? _self.estimatedRange
          : estimatedRange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [BatteryState].
extension BatteryStatePatterns on BatteryState {
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
    TResult Function(_BatteryState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BatteryState() when $default != null:
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
    TResult Function(_BatteryState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatteryState():
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
    TResult? Function(_BatteryState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatteryState() when $default != null:
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
    TResult Function(int percentage, double estimatedRange)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BatteryState() when $default != null:
        return $default(_that.percentage, _that.estimatedRange);
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
    TResult Function(int percentage, double estimatedRange) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatteryState():
        return $default(_that.percentage, _that.estimatedRange);
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
    TResult? Function(int percentage, double estimatedRange)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BatteryState() when $default != null:
        return $default(_that.percentage, _that.estimatedRange);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BatteryState implements BatteryState {
  const _BatteryState({this.percentage = 0, this.estimatedRange = 0});
  factory _BatteryState.fromJson(Map<String, dynamic> json) =>
      _$BatteryStateFromJson(json);

  @override
  @JsonKey()
  final int percentage;
  @override
  @JsonKey()
  final double estimatedRange;

  /// Create a copy of BatteryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BatteryStateCopyWith<_BatteryState> get copyWith =>
      __$BatteryStateCopyWithImpl<_BatteryState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BatteryStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BatteryState &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.estimatedRange, estimatedRange) ||
                other.estimatedRange == estimatedRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, percentage, estimatedRange);

  @override
  String toString() {
    return 'BatteryState(percentage: $percentage, estimatedRange: $estimatedRange)';
  }
}

/// @nodoc
abstract mixin class _$BatteryStateCopyWith<$Res>
    implements $BatteryStateCopyWith<$Res> {
  factory _$BatteryStateCopyWith(
          _BatteryState value, $Res Function(_BatteryState) _then) =
      __$BatteryStateCopyWithImpl;
  @override
  @useResult
  $Res call({int percentage, double estimatedRange});
}

/// @nodoc
class __$BatteryStateCopyWithImpl<$Res>
    implements _$BatteryStateCopyWith<$Res> {
  __$BatteryStateCopyWithImpl(this._self, this._then);

  final _BatteryState _self;
  final $Res Function(_BatteryState) _then;

  /// Create a copy of BatteryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? percentage = null,
    Object? estimatedRange = null,
  }) {
    return _then(_BatteryState(
      percentage: null == percentage
          ? _self.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedRange: null == estimatedRange
          ? _self.estimatedRange
          : estimatedRange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$DashboardSummary {
// Current bike status
  double get currentOdometer; // Mileage statistics
  double get todayDistance;
  double get weeklyDistance;
  double get monthlyDistance; // Battery status
  BatteryState get battery; // Upcoming reminder
  String? get upcomingReminderTitle;
  DateTime? get upcomingReminderDate; // Recent activities
  List<DashboardActivity> get recentActivities;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardSummaryCopyWith<DashboardSummary> get copyWith =>
      _$DashboardSummaryCopyWithImpl<DashboardSummary>(
          this as DashboardSummary, _$identity);

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardSummary &&
            (identical(other.currentOdometer, currentOdometer) ||
                other.currentOdometer == currentOdometer) &&
            (identical(other.todayDistance, todayDistance) ||
                other.todayDistance == todayDistance) &&
            (identical(other.weeklyDistance, weeklyDistance) ||
                other.weeklyDistance == weeklyDistance) &&
            (identical(other.monthlyDistance, monthlyDistance) ||
                other.monthlyDistance == monthlyDistance) &&
            (identical(other.battery, battery) || other.battery == battery) &&
            (identical(other.upcomingReminderTitle, upcomingReminderTitle) ||
                other.upcomingReminderTitle == upcomingReminderTitle) &&
            (identical(other.upcomingReminderDate, upcomingReminderDate) ||
                other.upcomingReminderDate == upcomingReminderDate) &&
            const DeepCollectionEquality()
                .equals(other.recentActivities, recentActivities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentOdometer,
      todayDistance,
      weeklyDistance,
      monthlyDistance,
      battery,
      upcomingReminderTitle,
      upcomingReminderDate,
      const DeepCollectionEquality().hash(recentActivities));

  @override
  String toString() {
    return 'DashboardSummary(currentOdometer: $currentOdometer, todayDistance: $todayDistance, weeklyDistance: $weeklyDistance, monthlyDistance: $monthlyDistance, battery: $battery, upcomingReminderTitle: $upcomingReminderTitle, upcomingReminderDate: $upcomingReminderDate, recentActivities: $recentActivities)';
  }
}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res> {
  factory $DashboardSummaryCopyWith(
          DashboardSummary value, $Res Function(DashboardSummary) _then) =
      _$DashboardSummaryCopyWithImpl;
  @useResult
  $Res call(
      {double currentOdometer,
      double todayDistance,
      double weeklyDistance,
      double monthlyDistance,
      BatteryState battery,
      String? upcomingReminderTitle,
      DateTime? upcomingReminderDate,
      List<DashboardActivity> recentActivities});

  $BatteryStateCopyWith<$Res> get battery;
}

/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentOdometer = null,
    Object? todayDistance = null,
    Object? weeklyDistance = null,
    Object? monthlyDistance = null,
    Object? battery = null,
    Object? upcomingReminderTitle = freezed,
    Object? upcomingReminderDate = freezed,
    Object? recentActivities = null,
  }) {
    return _then(_self.copyWith(
      currentOdometer: null == currentOdometer
          ? _self.currentOdometer
          : currentOdometer // ignore: cast_nullable_to_non_nullable
              as double,
      todayDistance: null == todayDistance
          ? _self.todayDistance
          : todayDistance // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyDistance: null == weeklyDistance
          ? _self.weeklyDistance
          : weeklyDistance // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyDistance: null == monthlyDistance
          ? _self.monthlyDistance
          : monthlyDistance // ignore: cast_nullable_to_non_nullable
              as double,
      battery: null == battery
          ? _self.battery
          : battery // ignore: cast_nullable_to_non_nullable
              as BatteryState,
      upcomingReminderTitle: freezed == upcomingReminderTitle
          ? _self.upcomingReminderTitle
          : upcomingReminderTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      upcomingReminderDate: freezed == upcomingReminderDate
          ? _self.upcomingReminderDate
          : upcomingReminderDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recentActivities: null == recentActivities
          ? _self.recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<DashboardActivity>,
    ));
  }

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BatteryStateCopyWith<$Res> get battery {
    return $BatteryStateCopyWith<$Res>(_self.battery, (value) {
      return _then(_self.copyWith(battery: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DashboardSummary].
extension DashboardSummaryPatterns on DashboardSummary {
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
    TResult Function(_DashboardSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardSummary() when $default != null:
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
    TResult Function(_DashboardSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardSummary():
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
    TResult? Function(_DashboardSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardSummary() when $default != null:
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
            double currentOdometer,
            double todayDistance,
            double weeklyDistance,
            double monthlyDistance,
            BatteryState battery,
            String? upcomingReminderTitle,
            DateTime? upcomingReminderDate,
            List<DashboardActivity> recentActivities)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardSummary() when $default != null:
        return $default(
            _that.currentOdometer,
            _that.todayDistance,
            _that.weeklyDistance,
            _that.monthlyDistance,
            _that.battery,
            _that.upcomingReminderTitle,
            _that.upcomingReminderDate,
            _that.recentActivities);
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
            double currentOdometer,
            double todayDistance,
            double weeklyDistance,
            double monthlyDistance,
            BatteryState battery,
            String? upcomingReminderTitle,
            DateTime? upcomingReminderDate,
            List<DashboardActivity> recentActivities)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardSummary():
        return $default(
            _that.currentOdometer,
            _that.todayDistance,
            _that.weeklyDistance,
            _that.monthlyDistance,
            _that.battery,
            _that.upcomingReminderTitle,
            _that.upcomingReminderDate,
            _that.recentActivities);
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
            double currentOdometer,
            double todayDistance,
            double weeklyDistance,
            double monthlyDistance,
            BatteryState battery,
            String? upcomingReminderTitle,
            DateTime? upcomingReminderDate,
            List<DashboardActivity> recentActivities)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardSummary() when $default != null:
        return $default(
            _that.currentOdometer,
            _that.todayDistance,
            _that.weeklyDistance,
            _that.monthlyDistance,
            _that.battery,
            _that.upcomingReminderTitle,
            _that.upcomingReminderDate,
            _that.recentActivities);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardSummary implements DashboardSummary {
  const _DashboardSummary(
      {required this.currentOdometer,
      this.todayDistance = 0,
      this.weeklyDistance = 0,
      this.monthlyDistance = 0,
      required this.battery,
      this.upcomingReminderTitle,
      this.upcomingReminderDate,
      required final List<DashboardActivity> recentActivities})
      : _recentActivities = recentActivities;
  factory _DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);

// Current bike status
  @override
  final double currentOdometer;
// Mileage statistics
  @override
  @JsonKey()
  final double todayDistance;
  @override
  @JsonKey()
  final double weeklyDistance;
  @override
  @JsonKey()
  final double monthlyDistance;
// Battery status
  @override
  final BatteryState battery;
// Upcoming reminder
  @override
  final String? upcomingReminderTitle;
  @override
  final DateTime? upcomingReminderDate;
// Recent activities
  final List<DashboardActivity> _recentActivities;
// Recent activities
  @override
  List<DashboardActivity> get recentActivities {
    if (_recentActivities is EqualUnmodifiableListView)
      return _recentActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivities);
  }

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardSummaryCopyWith<_DashboardSummary> get copyWith =>
      __$DashboardSummaryCopyWithImpl<_DashboardSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardSummary &&
            (identical(other.currentOdometer, currentOdometer) ||
                other.currentOdometer == currentOdometer) &&
            (identical(other.todayDistance, todayDistance) ||
                other.todayDistance == todayDistance) &&
            (identical(other.weeklyDistance, weeklyDistance) ||
                other.weeklyDistance == weeklyDistance) &&
            (identical(other.monthlyDistance, monthlyDistance) ||
                other.monthlyDistance == monthlyDistance) &&
            (identical(other.battery, battery) || other.battery == battery) &&
            (identical(other.upcomingReminderTitle, upcomingReminderTitle) ||
                other.upcomingReminderTitle == upcomingReminderTitle) &&
            (identical(other.upcomingReminderDate, upcomingReminderDate) ||
                other.upcomingReminderDate == upcomingReminderDate) &&
            const DeepCollectionEquality()
                .equals(other._recentActivities, _recentActivities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentOdometer,
      todayDistance,
      weeklyDistance,
      monthlyDistance,
      battery,
      upcomingReminderTitle,
      upcomingReminderDate,
      const DeepCollectionEquality().hash(_recentActivities));

  @override
  String toString() {
    return 'DashboardSummary(currentOdometer: $currentOdometer, todayDistance: $todayDistance, weeklyDistance: $weeklyDistance, monthlyDistance: $monthlyDistance, battery: $battery, upcomingReminderTitle: $upcomingReminderTitle, upcomingReminderDate: $upcomingReminderDate, recentActivities: $recentActivities)';
  }
}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(
          _DashboardSummary value, $Res Function(_DashboardSummary) _then) =
      __$DashboardSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double currentOdometer,
      double todayDistance,
      double weeklyDistance,
      double monthlyDistance,
      BatteryState battery,
      String? upcomingReminderTitle,
      DateTime? upcomingReminderDate,
      List<DashboardActivity> recentActivities});

  @override
  $BatteryStateCopyWith<$Res> get battery;
}

/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentOdometer = null,
    Object? todayDistance = null,
    Object? weeklyDistance = null,
    Object? monthlyDistance = null,
    Object? battery = null,
    Object? upcomingReminderTitle = freezed,
    Object? upcomingReminderDate = freezed,
    Object? recentActivities = null,
  }) {
    return _then(_DashboardSummary(
      currentOdometer: null == currentOdometer
          ? _self.currentOdometer
          : currentOdometer // ignore: cast_nullable_to_non_nullable
              as double,
      todayDistance: null == todayDistance
          ? _self.todayDistance
          : todayDistance // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyDistance: null == weeklyDistance
          ? _self.weeklyDistance
          : weeklyDistance // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyDistance: null == monthlyDistance
          ? _self.monthlyDistance
          : monthlyDistance // ignore: cast_nullable_to_non_nullable
              as double,
      battery: null == battery
          ? _self.battery
          : battery // ignore: cast_nullable_to_non_nullable
              as BatteryState,
      upcomingReminderTitle: freezed == upcomingReminderTitle
          ? _self.upcomingReminderTitle
          : upcomingReminderTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      upcomingReminderDate: freezed == upcomingReminderDate
          ? _self.upcomingReminderDate
          : upcomingReminderDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recentActivities: null == recentActivities
          ? _self._recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<DashboardActivity>,
    ));
  }

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BatteryStateCopyWith<$Res> get battery {
    return $BatteryStateCopyWith<$Res>(_self.battery, (value) {
      return _then(_self.copyWith(battery: value));
    });
  }
}

/// @nodoc
mixin _$DashboardActivity {
  String get id;
  ActivityType get type;
  DateTime get date;
  String get title;
  String? get subtitle;
  double? get value;
  String? get valueUnit;

  /// Create a copy of DashboardActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DashboardActivityCopyWith<DashboardActivity> get copyWith =>
      _$DashboardActivityCopyWithImpl<DashboardActivity>(
          this as DashboardActivity, _$identity);

  /// Serializes this DashboardActivity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DashboardActivity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.valueUnit, valueUnit) ||
                other.valueUnit == valueUnit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, date, title, subtitle, value, valueUnit);

  @override
  String toString() {
    return 'DashboardActivity(id: $id, type: $type, date: $date, title: $title, subtitle: $subtitle, value: $value, valueUnit: $valueUnit)';
  }
}

/// @nodoc
abstract mixin class $DashboardActivityCopyWith<$Res> {
  factory $DashboardActivityCopyWith(
          DashboardActivity value, $Res Function(DashboardActivity) _then) =
      _$DashboardActivityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      ActivityType type,
      DateTime date,
      String title,
      String? subtitle,
      double? value,
      String? valueUnit});
}

/// @nodoc
class _$DashboardActivityCopyWithImpl<$Res>
    implements $DashboardActivityCopyWith<$Res> {
  _$DashboardActivityCopyWithImpl(this._self, this._then);

  final DashboardActivity _self;
  final $Res Function(DashboardActivity) _then;

  /// Create a copy of DashboardActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? date = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? value = freezed,
    Object? valueUnit = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      valueUnit: freezed == valueUnit
          ? _self.valueUnit
          : valueUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DashboardActivity].
extension DashboardActivityPatterns on DashboardActivity {
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
    TResult Function(_DashboardActivity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardActivity() when $default != null:
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
    TResult Function(_DashboardActivity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardActivity():
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
    TResult? Function(_DashboardActivity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardActivity() when $default != null:
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
    TResult Function(String id, ActivityType type, DateTime date, String title,
            String? subtitle, double? value, String? valueUnit)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DashboardActivity() when $default != null:
        return $default(_that.id, _that.type, _that.date, _that.title,
            _that.subtitle, _that.value, _that.valueUnit);
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
    TResult Function(String id, ActivityType type, DateTime date, String title,
            String? subtitle, double? value, String? valueUnit)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardActivity():
        return $default(_that.id, _that.type, _that.date, _that.title,
            _that.subtitle, _that.value, _that.valueUnit);
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
    TResult? Function(String id, ActivityType type, DateTime date, String title,
            String? subtitle, double? value, String? valueUnit)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DashboardActivity() when $default != null:
        return $default(_that.id, _that.type, _that.date, _that.title,
            _that.subtitle, _that.value, _that.valueUnit);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DashboardActivity implements DashboardActivity {
  const _DashboardActivity(
      {required this.id,
      required this.type,
      required this.date,
      required this.title,
      this.subtitle,
      this.value,
      this.valueUnit});
  factory _DashboardActivity.fromJson(Map<String, dynamic> json) =>
      _$DashboardActivityFromJson(json);

  @override
  final String id;
  @override
  final ActivityType type;
  @override
  final DateTime date;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final double? value;
  @override
  final String? valueUnit;

  /// Create a copy of DashboardActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DashboardActivityCopyWith<_DashboardActivity> get copyWith =>
      __$DashboardActivityCopyWithImpl<_DashboardActivity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DashboardActivityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DashboardActivity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.valueUnit, valueUnit) ||
                other.valueUnit == valueUnit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, date, title, subtitle, value, valueUnit);

  @override
  String toString() {
    return 'DashboardActivity(id: $id, type: $type, date: $date, title: $title, subtitle: $subtitle, value: $value, valueUnit: $valueUnit)';
  }
}

/// @nodoc
abstract mixin class _$DashboardActivityCopyWith<$Res>
    implements $DashboardActivityCopyWith<$Res> {
  factory _$DashboardActivityCopyWith(
          _DashboardActivity value, $Res Function(_DashboardActivity) _then) =
      __$DashboardActivityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      ActivityType type,
      DateTime date,
      String title,
      String? subtitle,
      double? value,
      String? valueUnit});
}

/// @nodoc
class __$DashboardActivityCopyWithImpl<$Res>
    implements _$DashboardActivityCopyWith<$Res> {
  __$DashboardActivityCopyWithImpl(this._self, this._then);

  final _DashboardActivity _self;
  final $Res Function(_DashboardActivity) _then;

  /// Create a copy of DashboardActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? date = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? value = freezed,
    Object? valueUnit = freezed,
  }) {
    return _then(_DashboardActivity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      valueUnit: freezed == valueUnit
          ? _self.valueUnit
          : valueUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
