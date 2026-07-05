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
  }) = _Ride;

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
}

extension RideExtension on Ride {
  double get distance => endOdometer - startOdometer;
  int get batteryConsumed => batteryBefore - batteryAfter;
}
