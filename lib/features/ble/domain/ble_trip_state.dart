import 'package:freezed_annotation/freezed_annotation.dart';
import '../../rides/domain/ride.dart';

part 'ble_trip_state.freezed.dart';
part 'ble_trip_state.g.dart';

enum BleTripStatus {
  @JsonValue('idle')
  idle,
  @JsonValue('riding')
  riding,
  @JsonValue('stopped')
  stopped,
}

@freezed
abstract class BleTripState with _$BleTripState {
  const factory BleTripState({
    @Default(BleTripStatus.idle) BleTripStatus status,
    DateTime? startTime,
    DateTime? endTime,
    @Default(0.0) double startOdometer,
    @Default(0.0) double currentOdometer,
    @Default(0.0) double distance,
    @Default(0) int durationSeconds,
    @Default(0.0) double currentSpeed,
    @Default(0.0) double averageSpeed,
    @Default(0.0) double maxSpeed,
    @Default(0) int startBattery,
    @Default(0) int currentBattery,
    @Default('Eco') String currentRideMode,
    Ride? lastSavedRide,
  }) = _BleTripState;

  factory BleTripState.fromJson(Map<String, dynamic> json) =>
      _$BleTripStateFromJson(json);
}
