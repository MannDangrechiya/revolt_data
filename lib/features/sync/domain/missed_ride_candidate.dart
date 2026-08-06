import 'package:freezed_annotation/freezed_annotation.dart';
import '../../tracking/domain/gps_point.dart';

part 'missed_ride_candidate.freezed.dart';
part 'missed_ride_candidate.g.dart';

@freezed
abstract class MissedRideCandidate with _$MissedRideCandidate {
  const factory MissedRideCandidate({
    required String id,
    required DateTime estimatedStartTime,
    required DateTime estimatedEndTime,
    required double odometerDeltaKm,
    required double? gpsDistanceKm,
    required double? gpsMaxSpeedKmh,
    required List<GpsPoint>? gpsRoute,
    required String confidence,
    required String dataSource,
  }) = _MissedRideCandidate;

  factory MissedRideCandidate.fromJson(Map<String, dynamic> json) =>
      _$MissedRideCandidateFromJson(json);
}
