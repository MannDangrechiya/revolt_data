import 'package:freezed_annotation/freezed_annotation.dart';

part 'battery_health_snapshot.freezed.dart';
part 'battery_health_snapshot.g.dart';

@freezed
abstract class BatteryHealthSnapshot with _$BatteryHealthSnapshot {
  const factory BatteryHealthSnapshot({
    required String id,
    required DateTime date,
    required double healthPercent,
    required double rangeAtFullCharge,
    int? bikeId,
  }) = _BatteryHealthSnapshot;

  factory BatteryHealthSnapshot.fromJson(Map<String, dynamic> json) =>
      _$BatteryHealthSnapshotFromJson(json);
}
