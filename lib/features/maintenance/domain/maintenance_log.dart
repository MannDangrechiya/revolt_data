import 'package:freezed_annotation/freezed_annotation.dart';

part 'maintenance_log.freezed.dart';
part 'maintenance_log.g.dart';

enum MaintenanceComponent {
  @JsonValue('tires')
  tires,
  @JsonValue('brakes')
  brakes,
  @JsonValue('batteryPack')
  batteryPack,
  @JsonValue('suspension')
  suspension,
  @JsonValue('motorController')
  motorController,
  @JsonValue('other')
  other,
}

@freezed
abstract class MaintenanceLog with _$MaintenanceLog {
  const factory MaintenanceLog({
    required String id,
    required DateTime date,
    required MaintenanceComponent component,
    required String description,
    required double odometerReading,
    required double cost,
    String? serviceCenter,
    String? partsReplaced,
    double? labourCost,
    @Default(false) bool warrantyClaim,
    String? technician,
    String? invoicePhotoPath,
    String? notes,
    double? nextServiceDueOdometer,
    DateTime? nextServiceDueDate,
    @Default(false) bool tyres,
    @Default(false) bool brakes,
    @Default(false) bool battery,
    @Default(false) bool suspension,
    @Default(false) bool motor,
    @Default(false) bool lights,
    @Default(false) bool horn,
    @Default(false) bool softwareUpdate,
    @Default(false) bool generalInspection,
    int? bikeId,
  }) = _MaintenanceLog;

  factory MaintenanceLog.fromJson(Map<String, dynamic> json) => _$MaintenanceLogFromJson(json);
}
