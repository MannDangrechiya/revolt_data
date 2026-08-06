import 'package:freezed_annotation/freezed_annotation.dart';

part 'gps_point.freezed.dart';
part 'gps_point.g.dart';

@freezed
abstract class GpsPoint with _$GpsPoint {
  const factory GpsPoint({
    required double latitude,
    required double longitude,
    required double speedKmh,
    required DateTime timestamp,
    required double accuracy,
  }) = _GpsPoint;

  factory GpsPoint.fromJson(Map<String, dynamic> json) =>
      _$GpsPointFromJson(json);
}
