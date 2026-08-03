import 'package:freezed_annotation/freezed_annotation.dart';
import '../../charging/domain/charge_log.dart';

part 'ble_charge_state.freezed.dart';
part 'ble_charge_state.g.dart';

enum BleChargeStatus {
  @JsonValue('idle')
  idle,
  @JsonValue('charging')
  charging,
  @JsonValue('completed')
  completed,
}

@freezed
abstract class BleChargeState with _$BleChargeState {
  const factory BleChargeState({
    @Default(BleChargeStatus.idle) BleChargeStatus status,
    DateTime? startTime,
    DateTime? endTime,
    @Default(0) int startBattery,
    @Default(0) int currentBattery,
    @Default(0) int batteryGained,
    @Default(0.0) double kwhAdded,
    @Default(0) int durationSeconds,
    @Default(0) int peakBatteryTemp,
    @Default(0.0) double peakPowerKw,
    ChargeLog? lastSavedChargeLog,
  }) = _BleChargeState;

  factory BleChargeState.fromJson(Map<String, dynamic> json) =>
      _$BleChargeStateFromJson(json);
}
