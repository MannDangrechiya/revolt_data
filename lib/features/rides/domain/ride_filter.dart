import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

import 'ride.dart';

part 'ride_filter.freezed.dart';

@freezed
abstract class RideFilter with _$RideFilter {
  const factory RideFilter({
    RideMode? rideMode,
    RoadCondition? roadCondition,
    DateTimeRange? dateRange,
    String? searchQuery,
    bool? isFavorite,
  }) = _RideFilter;
}
