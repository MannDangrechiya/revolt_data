enum CoachSeverity {
  info,
  warning,
  critical,
}

class BatteryCoachTip {
  final String tip;
  final CoachSeverity severity;
  final double confidence; // 0-100
  final DateTime lastUpdated;

  const BatteryCoachTip({
    required this.tip,
    required this.severity,
    required this.confidence,
    required this.lastUpdated,
  });
}

class RideCoachTip {
  final String tip;
  final CoachSeverity severity;
  final double confidence; // 0-100
  final DateTime lastUpdated;

  const RideCoachTip({
    required this.tip,
    required this.severity,
    required this.confidence,
    required this.lastUpdated,
  });
}

class ChargingCoachTip {
  final String tip;
  final CoachSeverity severity;
  final double confidence; // 0-100
  final DateTime lastUpdated;

  const ChargingCoachTip({
    required this.tip,
    required this.severity,
    required this.confidence,
    required this.lastUpdated,
  });
}

class MaintenanceCoachTip {
  final String tip;
  final CoachSeverity severity;
  final double confidence; // 0-100
  final DateTime lastUpdated;

  const MaintenanceCoachTip({
    required this.tip,
    required this.severity,
    required this.confidence,
    required this.lastUpdated,
  });
}

class RangePrediction {
  final double predictedRangeKm;
  final double lowEstimate;
  final double highEstimate;
  final double confidencePercent;
  final DateTime lastUpdated;

  const RangePrediction({
    required this.predictedRangeKm,
    required this.lowEstimate,
    required this.highEstimate,
    required this.confidencePercent,
    required this.lastUpdated,
  });
}
