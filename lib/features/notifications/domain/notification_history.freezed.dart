// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationHistory {

 String get id; String get title; String get body; DateTime get firedAt; String? get payload;
/// Create a copy of NotificationHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationHistoryCopyWith<NotificationHistory> get copyWith => _$NotificationHistoryCopyWithImpl<NotificationHistory>(this as NotificationHistory, _$identity);

  /// Serializes this NotificationHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.firedAt, firedAt) || other.firedAt == firedAt)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,firedAt,payload);

@override
String toString() {
  return 'NotificationHistory(id: $id, title: $title, body: $body, firedAt: $firedAt, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $NotificationHistoryCopyWith<$Res>  {
  factory $NotificationHistoryCopyWith(NotificationHistory value, $Res Function(NotificationHistory) _then) = _$NotificationHistoryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, DateTime firedAt, String? payload
});




}
/// @nodoc
class _$NotificationHistoryCopyWithImpl<$Res>
    implements $NotificationHistoryCopyWith<$Res> {
  _$NotificationHistoryCopyWithImpl(this._self, this._then);

  final NotificationHistory _self;
  final $Res Function(NotificationHistory) _then;

/// Create a copy of NotificationHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? firedAt = null,Object? payload = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,firedAt: null == firedAt ? _self.firedAt : firedAt // ignore: cast_nullable_to_non_nullable
as DateTime,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationHistory].
extension NotificationHistoryPatterns on NotificationHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationHistory value)  $default,){
final _that = this;
switch (_that) {
case _NotificationHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationHistory value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  DateTime firedAt,  String? payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationHistory() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.firedAt,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  DateTime firedAt,  String? payload)  $default,) {final _that = this;
switch (_that) {
case _NotificationHistory():
return $default(_that.id,_that.title,_that.body,_that.firedAt,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  DateTime firedAt,  String? payload)?  $default,) {final _that = this;
switch (_that) {
case _NotificationHistory() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.firedAt,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationHistory implements NotificationHistory {
  const _NotificationHistory({required this.id, required this.title, required this.body, required this.firedAt, this.payload});
  factory _NotificationHistory.fromJson(Map<String, dynamic> json) => _$NotificationHistoryFromJson(json);

@override final  String id;
@override final  String title;
@override final  String body;
@override final  DateTime firedAt;
@override final  String? payload;

/// Create a copy of NotificationHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationHistoryCopyWith<_NotificationHistory> get copyWith => __$NotificationHistoryCopyWithImpl<_NotificationHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.firedAt, firedAt) || other.firedAt == firedAt)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,firedAt,payload);

@override
String toString() {
  return 'NotificationHistory(id: $id, title: $title, body: $body, firedAt: $firedAt, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$NotificationHistoryCopyWith<$Res> implements $NotificationHistoryCopyWith<$Res> {
  factory _$NotificationHistoryCopyWith(_NotificationHistory value, $Res Function(_NotificationHistory) _then) = __$NotificationHistoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, DateTime firedAt, String? payload
});




}
/// @nodoc
class __$NotificationHistoryCopyWithImpl<$Res>
    implements _$NotificationHistoryCopyWith<$Res> {
  __$NotificationHistoryCopyWithImpl(this._self, this._then);

  final _NotificationHistory _self;
  final $Res Function(_NotificationHistory) _then;

/// Create a copy of NotificationHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? firedAt = null,Object? payload = freezed,}) {
  return _then(_NotificationHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,firedAt: null == firedAt ? _self.firedAt : firedAt // ignore: cast_nullable_to_non_nullable
as DateTime,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
