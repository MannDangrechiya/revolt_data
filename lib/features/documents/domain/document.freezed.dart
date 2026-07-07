// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Document {

 int? get id; String get name; String get category; String get filePath; DateTime get uploadDate; String? get notes; int? get bikeId;
/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentCopyWith<Document> get copyWith => _$DocumentCopyWithImpl<Document>(this as Document, _$identity);

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Document&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.uploadDate, uploadDate) || other.uploadDate == uploadDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,filePath,uploadDate,notes,bikeId);

@override
String toString() {
  return 'Document(id: $id, name: $name, category: $category, filePath: $filePath, uploadDate: $uploadDate, notes: $notes, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class $DocumentCopyWith<$Res>  {
  factory $DocumentCopyWith(Document value, $Res Function(Document) _then) = _$DocumentCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String category, String filePath, DateTime uploadDate, String? notes, int? bikeId
});




}
/// @nodoc
class _$DocumentCopyWithImpl<$Res>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._self, this._then);

  final Document _self;
  final $Res Function(Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? category = null,Object? filePath = null,Object? uploadDate = null,Object? notes = freezed,Object? bikeId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,uploadDate: null == uploadDate ? _self.uploadDate : uploadDate // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Document].
extension DocumentPatterns on Document {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Document value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Document value)  $default,){
final _that = this;
switch (_that) {
case _Document():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Document value)?  $default,){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String category,  String filePath,  DateTime uploadDate,  String? notes,  int? bikeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.filePath,_that.uploadDate,_that.notes,_that.bikeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String category,  String filePath,  DateTime uploadDate,  String? notes,  int? bikeId)  $default,) {final _that = this;
switch (_that) {
case _Document():
return $default(_that.id,_that.name,_that.category,_that.filePath,_that.uploadDate,_that.notes,_that.bikeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String category,  String filePath,  DateTime uploadDate,  String? notes,  int? bikeId)?  $default,) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.filePath,_that.uploadDate,_that.notes,_that.bikeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Document implements Document {
  const _Document({this.id, required this.name, required this.category, required this.filePath, required this.uploadDate, this.notes, this.bikeId});
  factory _Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String category;
@override final  String filePath;
@override final  DateTime uploadDate;
@override final  String? notes;
@override final  int? bikeId;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentCopyWith<_Document> get copyWith => __$DocumentCopyWithImpl<_Document>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Document&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.uploadDate, uploadDate) || other.uploadDate == uploadDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,filePath,uploadDate,notes,bikeId);

@override
String toString() {
  return 'Document(id: $id, name: $name, category: $category, filePath: $filePath, uploadDate: $uploadDate, notes: $notes, bikeId: $bikeId)';
}


}

/// @nodoc
abstract mixin class _$DocumentCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$DocumentCopyWith(_Document value, $Res Function(_Document) _then) = __$DocumentCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String category, String filePath, DateTime uploadDate, String? notes, int? bikeId
});




}
/// @nodoc
class __$DocumentCopyWithImpl<$Res>
    implements _$DocumentCopyWith<$Res> {
  __$DocumentCopyWithImpl(this._self, this._then);

  final _Document _self;
  final $Res Function(_Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? category = null,Object? filePath = null,Object? uploadDate = null,Object? notes = freezed,Object? bikeId = freezed,}) {
  return _then(_Document(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,uploadDate: null == uploadDate ? _self.uploadDate : uploadDate // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,bikeId: freezed == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
