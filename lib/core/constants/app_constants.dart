class AppConstants {
  /// Verified BLE pairing token for this bike's Revolt account (captured via
  /// HCI snoop log — the bike replied ACCEPTED). Not a fixed factory PIN;
  /// account-specific tokens like this can change if re-issued by Revolt.
  static const String knownBlePairingToken = 'ODg2Njk0NTQzM';

  static const double defaultBatteryCapacityKwh = 3.24;
  static const double maxChargingSpeedKw = 5.0;
  static const double assumedTypicalChargingRateKw = 3.0;
  static const double petrolPricePerLitre = 100.0;
  static const double petrolMileageKmPerLitre = 40.0;
  static const double petrolCo2KgPerLitre = 2.3;
  static const double gridCo2KgPerKwh = 0.5;
  static const double dashboardPetrolCo2GramsPerKm = 60.0;
}
