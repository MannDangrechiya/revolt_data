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

 String get id; DateTime get date; MaintenanceComponent get component; String get description; double get odometerReading; double get cost; String? get serviceCenter; String? get partsReplaced; double? get labourCost; bool get warrantyClaim; String? get technician; String? get invoicePhotoPath; String? get notes; double? get nextServiceDueOdometer; DateTime? get nextServiceDueDate; bool get tyres; bool get brakes; bool get battery; bool get suspension; bool get motor; bool get lights; bool get horn; bool get softwareUpdate; bool get generalInspection; int? get bikeId;
/// Create a copy of MaintenanceLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceLogCopyWith<MaintenanceLog> get copyWith => _$MaintenanceLogCopyWithImpl<MaintenanceLog>(this as MaintenanceLog, _$identity);

  /// Serializes this MaintenanceLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceLog&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.component, component) || other.component == component)&&(identical(other.description, description) || other.description == description)&&(identical(other.odometerReading, odometerReading) || other.odometerReading == odometerReading)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.serviceCenter, serviceCenter) || other.serviceCenter == serviceCenter)&&(identical(other.partsReplaced, partsReplaced) || other.partsReplaced == partsReplaced)&&(identical(other.labourCost, labourCost) || other.labourCost == labourCost)&&(identical(other.warrantyClaim, warrantyClaim) || other.warrantyClaim == warrantyClaim)&&(identical(other.technician, technician) || other.technician == technician)&&(identical(other.invoicePhotoPath, invoicePhotoPath) || other.invoicePhotoPath == invoicePhotoPath)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.nextServiceDueOdometer, nextServiceDueOdometer) || other.nextServiceDueOdometer == nextServiceDueOdometer)&&(identical(other.nextServiceDueDate, nextServiceDueDate) || other.nextServiceDueDate == nextServiceDueDate)&&(identical(other.tyres, tyres) || other.tyres == tyres)&&(identical(other.brakes, brakes) || other.brakes == brakes)&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.suspension, suspension) || other.suspension == suspension)&&(identical(other.motor, motor) || other.motor == motor)&&(identical(other.lights, lights) || other.lights == lights)&&(identical(other.horn, horn) || other.horn == horn)&&(identical(other.softwareUpdate, softwareUpdate) || other.softwareUpdate == softwareUpdate)&&(identical(other.generalInspection, generalInspection) || other.generalInspection == generalInspection)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,date,component,description,odometerReading,cost,serviceCenter,partsReplaced,labourCost,warrantyClaim,technician,invoicePhotoPath,notes,nextServiceDueOdometer,nextServiceDueDate,tyres,brakes,battery,suspension,motor,lights,horn,softwareUpdate,generalInspection,bikeId]);

@override
String toString() {
  return 'MaintenanceLog(id: $id, date: $date, component: $component, description: $description, odometerReading: $odometerReading, cost: $cost, serviceCenter: $serviceCenter, partsReplaced: $partsReplaced, labourCost: $labourCost, warrantyClaim: $warrantyClaim, technician: $technician, invoicePhotoPath: $invoicePhotoPath, notes: $notes, nextServiceDueOdometer: $nextServiceDueOdometer, nextServiceDueDate: $nextServiceDueDate, tyres: $tyres, brakes: $brakes, battery: $battery, suspension: $suspension, motor: $motor, lights: $lights, horn: $horn, softwareUpdate: $softwareUpdate, generalInspection: $generalInspection, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class $MaintenanceLogCopyWith<$Res>  {
  factory $MaintenanceLogCopyWith(MaintenanceLog value, $Res Function(MaintenanceLog) _then) = _$MaintenanceLogCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, MaintenanceComponent component, String description, double odometerReading, double cost, String? serviceCenter, String? partsReplaced, double? labourCost, bool warrantyClaim, String? technician, String? invoicePhotoPath, String? notes, double? nextServiceDueOdometer, DateTime? nextServiceDueDate, bool tyres, bool brakes, bool battery, bool suspension, bool motor, bool lights, bool horn, bool softwareUpdate, bool generalInspection, int? bikeId
});




}
/// @nodoc
class _$MaintenanceLogCopyWithImpl<$Res>
    implements $MaintenanceLogCopyWith<$Res> {
  _$MaintenanceLogCopyWithImpl(this._self, this._then);

  final MaintenanceLog _self;
  final $Res Function(MaintenanceLog) _then;

/// Create a copy of MaintenanceLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? component = null,Object? description = null,Object? odometerReading = null,Object? cost = null,Object? serviceCenter = freezed,Object? partsReplaced = freezed,Object? labourCost = freezed,Object? warrantyClaim = null,Object? technician = freezed,Object? invoicePhotoPath = freezed,Object? notes = freezed,Object? nextServiceDueOdometer = freezed,Object? nextServiceDueDate = freezed,Object? tyres = null,Object? brakes = null,Object? battery = null,Object? suspension = null,Object? motor = null,Object? lights = null,Object? horn = null,Object? softwareUpdate = null,Object? generalInspection = null,Object? bikeId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,component: null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as MaintenanceComponent,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,odometerReading: null == odometerReading ? _self.odometerReading : odometerReading // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,serviceCenter: freezed == serviceCenter ? _self.serviceCenter : serviceCenter // ignore: cast_nullable_to_non_nullable
as String?,partsReplaced: freezed == partsReplaced ? _self.partsReplaced : partsReplaced // ignore: cast_nullable_to_non_nullable
as String?,labourCost: freezed == labourCost ? _self.labourCost : labourCost // ignore: cast_nullable_to_non_nullable
as double?,warrantyClaim: null == warrantyClaim ? _self.warrantyClaim : warrantyClaim // ignore: cast_nullable_to_non_nullable
as bool,technician: freezed == technician ? _self.technician : technician // ignore: cast_nullable_to_non_nullable
as String?,invoicePhotoPath: freezed == invoicePhotoPath ? _self.invoicePhotoPath : invoicePhotoPath // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,nextServiceDueOdometer: freezed == nextServiceDueOdometer ? _self.nextServiceDueOdometer : nextServiceDueOdometer // ignore: cast_nullable_to_non_nullable
as double?,nextServiceDueDate: freezed == nextServiceDueDate ? _self.nextServiceDueDate : nextServiceDueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,tyres: null == tyres ? _self.tyres : tyres // ignore: cast_nullable_to_non_nullable
as bool,brakes: null == brakes ? _self.brakes : brakes // ignore: cast_nullable_to_non_nullable
as bool,battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as bool,suspension: null == suspension ? _self.suspension : suspension // ignore: cast_nullable_to_non_nullable
as bool,motor: null == motor ? _self.motor : motor // ignore: cast_nullable_to_non_nullable
as bool,lights: null == lights ? _self.lights : lights // ignore: cast_nullable_to_non_nullable
as bool,horn: null == horn ? _self.horn : horn // ignore: cast_nullable_to_non_nullable
as bool,softwareUpdate: null == softwareUpdate ? _self.softwareUpdate : softwareUpdate // ignore: cast_nullable_to_non_nullable
as bool,generalInspection: null == generalInspection ? _self.generalInspection : generalInspection // ignore: cast_nullable_to_non_nullable
as bool,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceLog value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceLog value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  MaintenanceComponent component,  String description,  double odometerReading,  double cost,  String? serviceCenter,  String? partsReplaced,  double? labourCost,  bool warrantyClaim,  String? technician,  String? invoicePhotoPath,  String? notes,  double? nextServiceDueOdometer,  DateTime? nextServiceDueDate,  bool tyres,  bool brakes,  bool battery,  bool suspension,  bool motor,  bool lights,  bool horn,  bool softwareUpdate,  bool generalInspection,  int? bikeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceLog() when $default != null:
return $default(_that.id,_that.date,_that.component,_that.description,_that.odometerReading,_that.cost,_that.serviceCenter,_that.partsReplaced,_that.labourCost,_that.warrantyClaim,_that.technician,_that.invoicePhotoPath,_that.notes,_that.nextServiceDueOdometer,_that.nextServiceDueDate,_that.tyres,_that.brakes,_that.battery,_that.suspension,_that.motor,_that.lights,_that.horn,_that.softwareUpdate,_that.generalInspection,_that.bikeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  MaintenanceComponent component,  String description,  double odometerReading,  double cost,  String? serviceCenter,  String? partsReplaced,  double? labourCost,  bool warrantyClaim,  String? technician,  String? invoicePhotoPath,  String? notes,  double? nextServiceDueOdometer,  DateTime? nextServiceDueDate,  bool tyres,  bool brakes,  bool battery,  bool suspension,  bool motor,  bool lights,  bool horn,  bool softwareUpdate,  bool generalInspection,  int? bikeId)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceLog():
return $default(_that.id,_that.date,_that.component,_that.description,_that.odometerReading,_that.cost,_that.serviceCenter,_that.partsReplaced,_that.labourCost,_that.warrantyClaim,_that.technician,_that.invoicePhotoPath,_that.notes,_that.nextServiceDueOdometer,_that.nextServiceDueDate,_that.tyres,_that.brakes,_that.battery,_that.suspension,_that.motor,_that.lights,_that.horn,_that.softwareUpdate,_that.generalInspection,_that.bikeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  MaintenanceComponent component,  String description,  double odometerReading,  double cost,  String? serviceCenter,  String? partsReplaced,  double? labourCost,  bool warrantyClaim,  String? technician,  String? invoicePhotoPath,  String? notes,  double? nextServiceDueOdometer,  DateTime? nextServiceDueDate,  bool tyres,  bool brakes,  bool battery,  bool suspension,  bool motor,  bool lights,  bool horn,  bool softwareUpdate,  bool generalInspection,  int? bikeId)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceLog() when $default != null:
return $default(_that.id,_that.date,_that.component,_that.description,_that.odometerReading,_that.cost,_that.serviceCenter,_that.partsReplaced,_that.labourCost,_that.warrantyClaim,_that.technician,_that.invoicePhotoPath,_that.notes,_that.nextServiceDueOdometer,_that.nextServiceDueDate,_that.tyres,_that.brakes,_that.battery,_that.suspension,_that.motor,_that.lights,_that.horn,_that.softwareUpdate,_that.generalInspection,_that.bikeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenanceLog implements MaintenanceLog {
  const _MaintenanceLog({required this.id, required this.date, required this.component, required this.description, required this.odometerReading, required this.cost, this.serviceCenter, this.partsReplaced, this.labourCost, this.warrantyClaim = false, this.technician, this.invoicePhotoPath, this.notes, this.nextServiceDueOdometer, this.nextServiceDueDate, this.tyres = false, this.brakes = false, this.battery = false, this.suspension = false, this.motor = false, this.lights = false, this.horn = false, this.softwareUpdate = false, this.generalInspection = false, this.bikeId});
  factory _MaintenanceLog.fromJson(Map<String, dynamic> json) => _$MaintenanceLogFromJson(json);

@override final  String id;
@override final  DateTime date;
@override final  MaintenanceComponent component;
@override final  String description;
@override final  double odometerReading;
@override final  double cost;
@override final  String? serviceCenter;
@override final  String? partsReplaced;
@override final  double? labourCost;
@override@JsonKey() final  bool warrantyClaim;
@override final  String? technician;
@override final  String? invoicePhotoPath;
@override final  String? notes;
@override final  double? nextServiceDueOdometer;
@override final  DateTime? nextServiceDueDate;
@override@JsonKey() final  bool tyres;
@override@JsonKey() final  bool brakes;
@override@JsonKey() final  bool battery;
@override@JsonKey() final  bool suspension;
@override@JsonKey() final  bool motor;
@override@JsonKey() final  bool lights;
@override@JsonKey() final  bool horn;
@override@JsonKey() final  bool softwareUpdate;
@override@JsonKey() final  bool generalInspection;
@override final  int? bikeId;

/// Create a copy of MaintenanceLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceLogCopyWith<_MaintenanceLog> get copyWith => __$MaintenanceLogCopyWithImpl<_MaintenanceLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceLog&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.component, component) || other.component == component)&&(identical(other.description, description) || other.description == description)&&(identical(other.odometerReading, odometerReading) || other.odometerReading == odometerReading)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.serviceCenter, serviceCenter) || other.serviceCenter == serviceCenter)&&(identical(other.partsReplaced, partsReplaced) || other.partsReplaced == partsReplaced)&&(identical(other.labourCost, labourCost) || other.labourCost == labourCost)&&(identical(other.warrantyClaim, warrantyClaim) || other.warrantyClaim == warrantyClaim)&&(identical(other.technician, technician) || other.technician == technician)&&(identical(other.invoicePhotoPath, invoicePhotoPath) || other.invoicePhotoPath == invoicePhotoPath)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.nextServiceDueOdometer, nextServiceDueOdometer) || other.nextServiceDueOdometer == nextServiceDueOdometer)&&(identical(other.nextServiceDueDate, nextServiceDueDate) || other.nextServiceDueDate == nextServiceDueDate)&&(identical(other.tyres, tyres) || other.tyres == tyres)&&(identical(other.brakes, brakes) || other.brakes == brakes)&&(identical(other.battery, battery) || other.battery == battery)&&(identical(other.suspension, suspension) || other.suspension == suspension)&&(identical(other.motor, motor) || other.motor == motor)&&(identical(other.lights, lights) || other.lights == lights)&&(identical(other.horn, horn) || other.horn == horn)&&(identical(other.softwareUpdate, softwareUpdate) || other.softwareUpdate == softwareUpdate)&&(identical(other.generalInspection, generalInspection) || other.generalInspection == generalInspection)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,date,component,description,odometerReading,cost,serviceCenter,partsReplaced,labourCost,warrantyClaim,technician,invoicePhotoPath,notes,nextServiceDueOdometer,nextServiceDueDate,tyres,brakes,battery,suspension,motor,lights,horn,softwareUpdate,generalInspection,bikeId]);

@override
String toString() {
  return 'MaintenanceLog(id: $id, date: $date, component: $component, description: $description, odometerReading: $odometerReading, cost: $cost, serviceCenter: $serviceCenter, partsReplaced: $partsReplaced, labourCost: $labourCost, warrantyClaim: $warrantyClaim, technician: $technician, invoicePhotoPath: $invoicePhotoPath, notes: $notes, nextServiceDueOdometer: $nextServiceDueOdometer, nextServiceDueDate: $nextServiceDueDate, tyres: $tyres, brakes: $brakes, battery: $battery, suspension: $suspension, motor: $motor, lights: $lights, horn: $horn, softwareUpdate: $softwareUpdate, generalInspection: $generalInspection, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceLogCopyWith<$Res> implements $MaintenanceLogCopyWith<$Res> {
  factory _$MaintenanceLogCopyWith(_MaintenanceLog value, $Res Function(_MaintenanceLog) _then) = __$MaintenanceLogCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, MaintenanceComponent component, String description, double odometerReading, double cost, String? serviceCenter, String? partsReplaced, double? labourCost, bool warrantyClaim, String? technician, String? invoicePhotoPath, String? notes, double? nextServiceDueOdometer, DateTime? nextServiceDueDate, bool tyres, bool brakes, bool battery, bool suspension, bool motor, bool lights, bool horn, bool softwareUpdate, bool generalInspection, int? bikeId
});




}
/// @nodoc
class __$MaintenanceLogCopyWithImpl<$Res>
    implements _$MaintenanceLogCopyWith<$Res> {
  __$MaintenanceLogCopyWithImpl(this._self, this._then);

  final _MaintenanceLog _self;
  final $Res Function(_MaintenanceLog) _then;

/// Create a copy of MaintenanceLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? component = null,Object? description = null,Object? odometerReading = null,Object? cost = null,Object? serviceCenter = freezed,Object? partsReplaced = freezed,Object? labourCost = freezed,Object? warrantyClaim = null,Object? technician = freezed,Object? invoicePhotoPath = freezed,Object? notes = freezed,Object? nextServiceDueOdometer = freezed,Object? nextServiceDueDate = freezed,Object? tyres = null,Object? brakes = null,Object? battery = null,Object? suspension = null,Object? motor = null,Object? lights = null,Object? horn = null,Object? softwareUpdate = null,Object? generalInspection = null,Object? bikeId = freezed,}) {
  return _then(_MaintenanceLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,component: null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as MaintenanceComponent,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,odometerReading: null == odometerReading ? _self.odometerReading : odometerReading // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,serviceCenter: freezed == serviceCenter ? _self.serviceCenter : serviceCenter // ignore: cast_nullable_to_non_nullable
as String?,partsReplaced: freezed == partsReplaced ? _self.partsReplaced : partsReplaced // ignore: cast_nullable_to_non_nullable
as String?,labourCost: freezed == labourCost ? _self.labourCost : labourCost // ignore: cast_nullable_to_non_nullable
as double?,warrantyClaim: null == warrantyClaim ? _self.warrantyClaim : warrantyClaim // ignore: cast_nullable_to_non_nullable
as bool,technician: freezed == technician ? _self.technician : technician // ignore: cast_nullable_to_non_nullable
as String?,invoicePhotoPath: freezed == invoicePhotoPath ? _self.invoicePhotoPath : invoicePhotoPath // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,nextServiceDueOdometer: freezed == nextServiceDueOdometer ? _self.nextServiceDueOdometer : nextServiceDueOdometer // ignore: cast_nullable_to_non_nullable
as double?,nextServiceDueDate: freezed == nextServiceDueDate ? _self.nextServiceDueDate : nextServiceDueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,tyres: null == tyres ? _self.tyres : tyres // ignore: cast_nullable_to_non_nullable
as bool,brakes: null == brakes ? _self.brakes : brakes // ignore: cast_nullable_to_non_nullable
as bool,battery: null == battery ? _self.battery : battery // ignore: cast_nullable_to_non_nullable
as bool,suspension: null == suspension ? _self.suspension : suspension // ignore: cast_nullable_to_non_nullable
as bool,motor: null == motor ? _self.motor : motor // ignore: cast_nullable_to_non_nullable
as bool,lights: null == lights ? _self.lights : lights // ignore: cast_nullable_to_non_nullable
as bool,horn: null == horn ? _self.horn : horn // ignore: cast_nullable_to_non_nullable
as bool,softwareUpdate: null == softwareUpdate ? _self.softwareUpdate : softwareUpdate // ignore: cast_nullable_to_non_nullable
as bool,generalInspection: null == generalInspection ? _self.generalInspection : generalInspection // ignore: cast_nullable_to_non_nullable
as bool,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
