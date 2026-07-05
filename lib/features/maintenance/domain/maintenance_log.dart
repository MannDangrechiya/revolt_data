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
  }) = _MaintenanceLog;

  factory MaintenanceLog.fromJson(Map<String, dynamic> json) => _$MaintenanceLogFromJson(json);
}
