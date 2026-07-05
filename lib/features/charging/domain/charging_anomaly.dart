class ChargingAnomaly {
  final String message;
  final bool isError; // If true, the entry should be blocked. If false, it's just a warning.

  ChargingAnomaly({required this.message, this.isError = true});

  static ChargingAnomaly? checkAnomaly({
    required double kwhAdded,
    required double durationMinutes,
    required int startBattery,
    required int endBattery,
    double maxBatteryCapacityKwh = 3.24, // Assumed Revolt RV400 capacity
    double maxChargingSpeedKw = 5.0, // Assumed maximum charger capacity
  }) {
    if (endBattery <= startBattery) {
      return ChargingAnomaly(message: 'End battery must be greater than start battery.', isError: true);
    }
    
    final batteryDelta = endBattery - startBattery;
    if (batteryDelta > 100) {
      return ChargingAnomaly(message: 'Battery percentage increase cannot exceed 100%.', isError: true);
    }

    if (kwhAdded > maxBatteryCapacityKwh) {
      return ChargingAnomaly(
        message: 'kWh added ($kwhAdded) exceeds total battery capacity ($maxBatteryCapacityKwh).',
        isError: true,
      );
    }

    if (durationMinutes <= 0) {
      return ChargingAnomaly(message: 'Duration must be greater than zero.', isError: true);
    }

    final speedKw = kwhAdded / (durationMinutes / 60);
    if (speedKw > maxChargingSpeedKw) {
      return ChargingAnomaly(
        message: 'Calculated charging speed (${speedKw.toStringAsFixed(1)} kW) exceeds mathematically possible max speed ($maxChargingSpeedKw kW). Check kWh or duration.',
        isError: true,
      );
    }

    return null; // No anomaly
  }
}
