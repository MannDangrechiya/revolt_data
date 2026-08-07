// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BleDeviceInfo {

 String get id; String get name; int get rssi; bool get isRevoltBike;
/// Create a copy of BleDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BleDeviceInfoCopyWith<BleDeviceInfo> get copyWith => _$BleDeviceInfoCopyWithImpl<BleDeviceInfo>(this as BleDeviceInfo, _$identity);

  /// Serializes this BleDeviceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleDeviceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rssi, rssi) || other.rssi == rssi)&&(identical(other.isRevoltBike, isRevoltBike) || other.isRevoltBike == isRevoltBike));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rssi,isRevoltBike);

@override
String toString() {
  return 'BleDeviceInfo(id: $id, name: $name, rssi: $rssi, isRevoltBike: $isRevoltBike)';
}


}

/// @nodoc
abstract mixin class $BleDeviceInfoCopyWith<$Res>  {
  factory $BleDeviceInfoCopyWith(BleDeviceInfo value, $Res Function(BleDeviceInfo) _then) = _$BleDeviceInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, int rssi, bool isRevoltBike
});




}
/// @nodoc
class _$BleDeviceInfoCopyWithImpl<$Res>
    implements $BleDeviceInfoCopyWith<$Res> {
  _$BleDeviceInfoCopyWithImpl(this._self, this._then);

  final BleDeviceInfo _self;
  final $Res Function(BleDeviceInfo) _then;

/// Create a copy of BleDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? rssi = null,Object? isRevoltBike = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rssi: null == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as int,isRevoltBike: null == isRevoltBike ? _self.isRevoltBike : isRevoltBike // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BleDeviceInfo].
extension BleDeviceInfoPatterns on BleDeviceInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BleDeviceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BleDeviceInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BleDeviceInfo value)  $default,){
final _that = this;
switch (_that) {
case _BleDeviceInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BleDeviceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BleDeviceInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int rssi,  bool isRevoltBike)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BleDeviceInfo() when $default != null:
return $default(_that.id,_that.name,_that.rssi,_that.isRevoltBike);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int rssi,  bool isRevoltBike)  $default,) {final _that = this;
switch (_that) {
case _BleDeviceInfo():
return $default(_that.id,_that.name,_that.rssi,_that.isRevoltBike);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int rssi,  bool isRevoltBike)?  $default,) {final _that = this;
switch (_that) {
case _BleDeviceInfo() when $default != null:
return $default(_that.id,_that.name,_that.rssi,_that.isRevoltBike);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BleDeviceInfo implements BleDeviceInfo {
  const _BleDeviceInfo({required this.id, required this.name, required this.rssi, this.isRevoltBike = true});
  factory _BleDeviceInfo.fromJson(Map<String, dynamic> json) => _$BleDeviceInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  int rssi;
@override@JsonKey() final  bool isRevoltBike;

/// Create a copy of BleDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BleDeviceInfoCopyWith<_BleDeviceInfo> get copyWith => __$BleDeviceInfoCopyWithImpl<_BleDeviceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BleDeviceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BleDeviceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rssi, rssi) || other.rssi == rssi)&&(identical(other.isRevoltBike, isRevoltBike) || other.isRevoltBike == isRevoltBike));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,rssi,isRevoltBike);

@override
String toString() {
  return 'BleDeviceInfo(id: $id, name: $name, rssi: $rssi, isRevoltBike: $isRevoltBike)';
}


}

/// @nodoc
abstract mixin class _$BleDeviceInfoCopyWith<$Res> implements $BleDeviceInfoCopyWith<$Res> {
  factory _$BleDeviceInfoCopyWith(_BleDeviceInfo value, $Res Function(_BleDeviceInfo) _then) = __$BleDeviceInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int rssi, bool isRevoltBike
});




}
/// @nodoc
class __$BleDeviceInfoCopyWithImpl<$Res>
    implements _$BleDeviceInfoCopyWith<$Res> {
  __$BleDeviceInfoCopyWithImpl(this._self, this._then);

  final _BleDeviceInfo _self;
  final $Res Function(_BleDeviceInfo) _then;

/// Create a copy of BleDeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? rssi = null,Object? isRevoltBike = null,}) {
  return _then(_BleDeviceInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rssi: null == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as int,isRevoltBike: null == isRevoltBike ? _self.isRevoltBike : isRevoltBike // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
