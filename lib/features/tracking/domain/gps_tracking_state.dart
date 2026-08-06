import 'package:freezed_annotation/freezed_annotation.dart';
import 'gps_point.dart';

part 'gps_tracking_state.freezed.dart';

@freezed
sealed class GpsTrackingState with _$GpsTrackingState {
  const factory GpsTrackingState.idle() = GpsTrackingStateIdle;
  const factory GpsTrackingState.active({
    required DateTime startTime,
    required double startOdometer,
    required List<GpsPoint> route,
    required double distanceKm,
    required double maxSpeedKmh,
    required double currentSpeedKmh,
    required int durationSeconds,
  }) = GpsTrackingStateActive;
  const factory GpsTrackingState.finalizing() = GpsTrackingStateFinalizing;
  const factory GpsTrackingState.completed({
    required List<GpsPoint> route,
    required double totalDistanceKm,
    required double maxSpeedKmh,
    required Duration duration,
    required DateTime startTime,
    required DateTime endTime,
  }) = GpsTrackingStateCompleted;
}
