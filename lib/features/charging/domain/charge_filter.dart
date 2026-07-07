import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

import 'charge_log.dart';

part 'charge_filter.freezed.dart';

@freezed
abstract class ChargeFilter with _$ChargeFilter {
  const factory ChargeFilter({
    LocationType? locationType,
    String? chargerType,
    DateTimeRange? dateRange,
    String? searchQuery,
  }) = _ChargeFilter;
}
