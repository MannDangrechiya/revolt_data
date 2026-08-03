import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride.freezed.dart';
part 'ride.g.dart';

enum RideMode {
  @JsonValue('eco')
  eco,
  @JsonValue('normal')
  normal,
  @JsonValue('sport')
  sport,
}

enum RoadCondition {
  @JsonValue('smooth')
  smooth,
  @JsonValue('average')
  average,
  @JsonValue('bad')
  bad,
}

@freezed
abstract class Ride with _$Ride {
  const factory Ride({
    required String id,
    required DateTime date,
    required double startOdometer,
    required double endOdometer,
    required int batteryBefore,
    required int batteryAfter,
    required RideMode rideMode,
    required RoadCondition roadCondition,
    String? notes,
    @Default([]) List<String> photoPaths,
    DateTime? startTime,
    DateTime? endTime,
    int? durationMinutes,
    double? estimatedRemainingRange,
    double? averageSpeed,
    double? maxSpeed,
    String? weather,
    String? roadType,
    int? passengerCount,
    String? ridePurpose,
    String? startLocation,
    String? endLocation,
    String? routeNotes,
    @Default([]) List<String> customTags,
    @Default(false) bool isFavorite,
    int? bikeId,
    @Default('manual') String source,
  }) = _Ride;

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
}

extension RideExtension on Ride {
  double get distance => endOdometer - startOdometer;
  int get batteryConsumed => batteryBefore - batteryAfter;
}
