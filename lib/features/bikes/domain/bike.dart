import 'package:freezed_annotation/freezed_annotation.dart';

part 'bike.freezed.dart';
part 'bike.g.dart';

@freezed
abstract class Bike with _$Bike {
  const factory Bike({
    int? id,
    required String name,
    required String brand,
    required String model,
    String? variant,
    required String color,
    required String registrationNumber,
    String? vin,
    String? motorNumber,
    DateTime? purchaseDate,
    double? purchasePrice,
    String? dealer,
    String? insurance,
    String? warranty,
    String? batteryWarranty,
    double? batteryCapacity,
    double? motorPower,
    double? claimedRange,
    double? topSpeed,
    String? tyreInfo,
    String? customNotes,
    String? photoPath,
  }) = _Bike;

  factory Bike.fromJson(Map<String, dynamic> json) => _$BikeFromJson(json);
}
