import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_snapshot.freezed.dart';
part 'vehicle_snapshot.g.dart';

/// Immutable model representing real-time telemetry snapshot from the Revolt RV400.
@freezed
abstract class VehicleSnapshot with _$VehicleSnapshot {
  const factory VehicleSnapshot({
    required int battery,
    required double voltage,
    required double current,
    required int temp,
    required double speed,
    required double odo,
    required double range,
    required String mode,
    @Default([]) List<String> faults,
    DateTime? timestamp,
  }) = _VehicleSnapshot;

  factory VehicleSnapshot.fromJson(Map<String, dynamic> json) =>
      _$VehicleSnapshotFromJson(json);
}
