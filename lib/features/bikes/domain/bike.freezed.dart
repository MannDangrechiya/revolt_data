// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bike.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bike {

 int? get id; String get name; String get brand; String get model; String? get variant; String get color; String get registrationNumber; String? get vin; String? get motorNumber; DateTime? get purchaseDate; double? get purchasePrice; String? get dealer; String? get insurance; String? get warranty; String? get batteryWarranty; double? get batteryCapacity; double? get motorPower; double? get claimedRange; double? get topSpeed; String? get tyreInfo; String? get customNotes; String? get photoPath;
/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BikeCopyWith<Bike> get copyWith => _$BikeCopyWithImpl<Bike>(this as Bike, _$identity);

  /// Serializes this Bike to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bike&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.color, color) || other.color == color)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.motorNumber, motorNumber) || other.motorNumber == motorNumber)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.dealer, dealer) || other.dealer == dealer)&&(identical(other.insurance, insurance) || other.insurance == insurance)&&(identical(other.warranty, warranty) || other.warranty == warranty)&&(identical(other.batteryWarranty, batteryWarranty) || other.batteryWarranty == batteryWarranty)&&(identical(other.batteryCapacity, batteryCapacity) || other.batteryCapacity == batteryCapacity)&&(identical(other.motorPower, motorPower) || other.motorPower == motorPower)&&(identical(other.claimedRange, claimedRange) || other.claimedRange == claimedRange)&&(identical(other.topSpeed, topSpeed) || other.topSpeed == topSpeed)&&(identical(other.tyreInfo, tyreInfo) || other.tyreInfo == tyreInfo)&&(identical(other.customNotes, customNotes) || other.customNotes == customNotes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,brand,model,variant,color,registrationNumber,vin,motorNumber,purchaseDate,purchasePrice,dealer,insurance,warranty,batteryWarranty,batteryCapacity,motorPower,claimedRange,topSpeed,tyreInfo,customNotes,photoPath]);

@override
String toString() {
  return 'Bike(id: $id, name: $name, brand: $brand, model: $model, variant: $variant, color: $color, registrationNumber: $registrationNumber, vin: $vin, motorNumber: $motorNumber, purchaseDate: $purchaseDate, purchasePrice: $purchasePrice, dealer: $dealer, insurance: $insurance, warranty: $warranty, batteryWarranty: $batteryWarranty, batteryCapacity: $batteryCapacity, motorPower: $motorPower, claimedRange: $claimedRange, topSpeed: $topSpeed, tyreInfo: $tyreInfo, customNotes: $customNotes, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class $BikeCopyWith<$Res>  {
  factory $BikeCopyWith(Bike value, $Res Function(Bike) _then) = _$BikeCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String brand, String model, String? variant, String color, String registrationNumber, String? vin, String? motorNumber, DateTime? purchaseDate, double? purchasePrice, String? dealer, String? insurance, String? warranty, String? batteryWarranty, double? batteryCapacity, double? motorPower, double? claimedRange, double? topSpeed, String? tyreInfo, String? customNotes, String? photoPath
});




}
/// @nodoc
class _$BikeCopyWithImpl<$Res>
    implements $BikeCopyWith<$Res> {
  _$BikeCopyWithImpl(this._self, this._then);

  final Bike _self;
  final $Res Function(Bike) _then;

/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? brand = null,Object? model = null,Object? variant = freezed,Object? color = null,Object? registrationNumber = null,Object? vin = freezed,Object? motorNumber = freezed,Object? purchaseDate = freezed,Object? purchasePrice = freezed,Object? dealer = freezed,Object? insurance = freezed,Object? warranty = freezed,Object? batteryWarranty = freezed,Object? batteryCapacity = freezed,Object? motorPower = freezed,Object? claimedRange = freezed,Object? topSpeed = freezed,Object? tyreInfo = freezed,Object? customNotes = freezed,Object? photoPath = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: null == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String,vin: freezed == vin ? _self.vin : vin // ignore: cast_nullable_to_non_nullable
as String?,motorNumber: freezed == motorNumber ? _self.motorNumber : motorNumber // ignore: cast_nullable_to_non_nullable
as String?,purchaseDate: freezed == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,dealer: freezed == dealer ? _self.dealer : dealer // ignore: cast_nullable_to_non_nullable
as String?,insurance: freezed == insurance ? _self.insurance : insurance // ignore: cast_nullable_to_non_nullable
as String?,warranty: freezed == warranty ? _self.warranty : warranty // ignore: cast_nullable_to_non_nullable
as String?,batteryWarranty: freezed == batteryWarranty ? _self.batteryWarranty : batteryWarranty // ignore: cast_nullable_to_non_nullable
as String?,batteryCapacity: freezed == batteryCapacity ? _self.batteryCapacity : batteryCapacity // ignore: cast_nullable_to_non_nullable
as double?,motorPower: freezed == motorPower ? _self.motorPower : motorPower // ignore: cast_nullable_to_non_nullable
as double?,claimedRange: freezed == claimedRange ? _self.claimedRange : claimedRange // ignore: cast_nullable_to_non_nullable
as double?,topSpeed: freezed == topSpeed ? _self.topSpeed : topSpeed // ignore: cast_nullable_to_non_nullable
as double?,tyreInfo: freezed == tyreInfo ? _self.tyreInfo : tyreInfo // ignore: cast_nullable_to_non_nullable
as String?,customNotes: freezed == customNotes ? _self.customNotes : customNotes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Bike].
extension BikePatterns on Bike {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bike value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bike() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bike value)  $default,){
final _that = this;
switch (_that) {
case _Bike():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bike value)?  $default,){
final _that = this;
switch (_that) {
case _Bike() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String brand,  String model,  String? variant,  String color,  String registrationNumber,  String? vin,  String? motorNumber,  DateTime? purchaseDate,  double? purchasePrice,  String? dealer,  String? insurance,  String? warranty,  String? batteryWarranty,  double? batteryCapacity,  double? motorPower,  double? claimedRange,  double? topSpeed,  String? tyreInfo,  String? customNotes,  String? photoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bike() when $default != null:
return $default(_that.id,_that.name,_that.brand,_that.model,_that.variant,_that.color,_that.registrationNumber,_that.vin,_that.motorNumber,_that.purchaseDate,_that.purchasePrice,_that.dealer,_that.insurance,_that.warranty,_that.batteryWarranty,_that.batteryCapacity,_that.motorPower,_that.claimedRange,_that.topSpeed,_that.tyreInfo,_that.customNotes,_that.photoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String brand,  String model,  String? variant,  String color,  String registrationNumber,  String? vin,  String? motorNumber,  DateTime? purchaseDate,  double? purchasePrice,  String? dealer,  String? insurance,  String? warranty,  String? batteryWarranty,  double? batteryCapacity,  double? motorPower,  double? claimedRange,  double? topSpeed,  String? tyreInfo,  String? customNotes,  String? photoPath)  $default,) {final _that = this;
switch (_that) {
case _Bike():
return $default(_that.id,_that.name,_that.brand,_that.model,_that.variant,_that.color,_that.registrationNumber,_that.vin,_that.motorNumber,_that.purchaseDate,_that.purchasePrice,_that.dealer,_that.insurance,_that.warranty,_that.batteryWarranty,_that.batteryCapacity,_that.motorPower,_that.claimedRange,_that.topSpeed,_that.tyreInfo,_that.customNotes,_that.photoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String brand,  String model,  String? variant,  String color,  String registrationNumber,  String? vin,  String? motorNumber,  DateTime? purchaseDate,  double? purchasePrice,  String? dealer,  String? insurance,  String? warranty,  String? batteryWarranty,  double? batteryCapacity,  double? motorPower,  double? claimedRange,  double? topSpeed,  String? tyreInfo,  String? customNotes,  String? photoPath)?  $default,) {final _that = this;
switch (_that) {
case _Bike() when $default != null:
return $default(_that.id,_that.name,_that.brand,_that.model,_that.variant,_that.color,_that.registrationNumber,_that.vin,_that.motorNumber,_that.purchaseDate,_that.purchasePrice,_that.dealer,_that.insurance,_that.warranty,_that.batteryWarranty,_that.batteryCapacity,_that.motorPower,_that.claimedRange,_that.topSpeed,_that.tyreInfo,_that.customNotes,_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Bike implements Bike {
  const _Bike({this.id, required this.name, required this.brand, required this.model, this.variant, required this.color, required this.registrationNumber, this.vin, this.motorNumber, this.purchaseDate, this.purchasePrice, this.dealer, this.insurance, this.warranty, this.batteryWarranty, this.batteryCapacity, this.motorPower, this.claimedRange, this.topSpeed, this.tyreInfo, this.customNotes, this.photoPath});
  factory _Bike.fromJson(Map<String, dynamic> json) => _$BikeFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String brand;
@override final  String model;
@override final  String? variant;
@override final  String color;
@override final  String registrationNumber;
@override final  String? vin;
@override final  String? motorNumber;
@override final  DateTime? purchaseDate;
@override final  double? purchasePrice;
@override final  String? dealer;
@override final  String? insurance;
@override final  String? warranty;
@override final  String? batteryWarranty;
@override final  double? batteryCapacity;
@override final  double? motorPower;
@override final  double? claimedRange;
@override final  double? topSpeed;
@override final  String? tyreInfo;
@override final  String? customNotes;
@override final  String? photoPath;

/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BikeCopyWith<_Bike> get copyWith => __$BikeCopyWithImpl<_Bike>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BikeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bike&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.color, color) || other.color == color)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.vin, vin) || other.vin == vin)&&(identical(other.motorNumber, motorNumber) || other.motorNumber == motorNumber)&&(identical(other.purchaseDate, purchaseDate) || other.purchaseDate == purchaseDate)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.dealer, dealer) || other.dealer == dealer)&&(identical(other.insurance, insurance) || other.insurance == insurance)&&(identical(other.warranty, warranty) || other.warranty == warranty)&&(identical(other.batteryWarranty, batteryWarranty) || other.batteryWarranty == batteryWarranty)&&(identical(other.batteryCapacity, batteryCapacity) || other.batteryCapacity == batteryCapacity)&&(identical(other.motorPower, motorPower) || other.motorPower == motorPower)&&(identical(other.claimedRange, claimedRange) || other.claimedRange == claimedRange)&&(identical(other.topSpeed, topSpeed) || other.topSpeed == topSpeed)&&(identical(other.tyreInfo, tyreInfo) || other.tyreInfo == tyreInfo)&&(identical(other.customNotes, customNotes) || other.customNotes == customNotes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,brand,model,variant,color,registrationNumber,vin,motorNumber,purchaseDate,purchasePrice,dealer,insurance,warranty,batteryWarranty,batteryCapacity,motorPower,claimedRange,topSpeed,tyreInfo,customNotes,photoPath]);

@override
String toString() {
  return 'Bike(id: $id, name: $name, brand: $brand, model: $model, variant: $variant, color: $color, registrationNumber: $registrationNumber, vin: $vin, motorNumber: $motorNumber, purchaseDate: $purchaseDate, purchasePrice: $purchasePrice, dealer: $dealer, insurance: $insurance, warranty: $warranty, batteryWarranty: $batteryWarranty, batteryCapacity: $batteryCapacity, motorPower: $motorPower, claimedRange: $claimedRange, topSpeed: $topSpeed, tyreInfo: $tyreInfo, customNotes: $customNotes, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$BikeCopyWith<$Res> implements $BikeCopyWith<$Res> {
  factory _$BikeCopyWith(_Bike value, $Res Function(_Bike) _then) = __$BikeCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String brand, String model, String? variant, String color, String registrationNumber, String? vin, String? motorNumber, DateTime? purchaseDate, double? purchasePrice, String? dealer, String? insurance, String? warranty, String? batteryWarranty, double? batteryCapacity, double? motorPower, double? claimedRange, double? topSpeed, String? tyreInfo, String? customNotes, String? photoPath
});




}
/// @nodoc
class __$BikeCopyWithImpl<$Res>
    implements _$BikeCopyWith<$Res> {
  __$BikeCopyWithImpl(this._self, this._then);

  final _Bike _self;
  final $Res Function(_Bike) _then;

/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? brand = null,Object? model = null,Object? variant = freezed,Object? color = null,Object? registrationNumber = null,Object? vin = freezed,Object? motorNumber = freezed,Object? purchaseDate = freezed,Object? purchasePrice = freezed,Object? dealer = freezed,Object? insurance = freezed,Object? warranty = freezed,Object? batteryWarranty = freezed,Object? batteryCapacity = freezed,Object? motorPower = freezed,Object? claimedRange = freezed,Object? topSpeed = freezed,Object? tyreInfo = freezed,Object? customNotes = freezed,Object? photoPath = freezed,}) {
  return _then(_Bike(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,registrationNumber: null == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String,vin: freezed == vin ? _self.vin : vin // ignore: cast_nullable_to_non_nullable
as String?,motorNumber: freezed == motorNumber ? _self.motorNumber : motorNumber // ignore: cast_nullable_to_non_nullable
as String?,purchaseDate: freezed == purchaseDate ? _self.purchaseDate : purchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as double?,dealer: freezed == dealer ? _self.dealer : dealer // ignore: cast_nullable_to_non_nullable
as String?,insurance: freezed == insurance ? _self.insurance : insurance // ignore: cast_nullable_to_non_nullable
as String?,warranty: freezed == warranty ? _self.warranty : warranty // ignore: cast_nullable_to_non_nullable
as String?,batteryWarranty: freezed == batteryWarranty ? _self.batteryWarranty : batteryWarranty // ignore: cast_nullable_to_non_nullable
as String?,batteryCapacity: freezed == batteryCapacity ? _self.batteryCapacity : batteryCapacity // ignore: cast_nullable_to_non_nullable
as double?,motorPower: freezed == motorPower ? _self.motorPower : motorPower // ignore: cast_nullable_to_non_nullable
as double?,claimedRange: freezed == claimedRange ? _self.claimedRange : claimedRange // ignore: cast_nullable_to_non_nullable
as double?,topSpeed: freezed == topSpeed ? _self.topSpeed : topSpeed // ignore: cast_nullable_to_non_nullable
as double?,tyreInfo: freezed == tyreInfo ? _self.tyreInfo : tyreInfo // ignore: cast_nullable_to_non_nullable
as String?,customNotes: freezed == customNotes ? _self.customNotes : customNotes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
