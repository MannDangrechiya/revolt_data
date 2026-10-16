import 'dart:convert';

class AppConstants {
  /// Verified BLE pairing token for this bike's Revolt account (derived from
  /// Base64("$mobileNumber:$ecuImei").substring(0, 13) as verified from real MyRevolt app logs).
  static const String knownBlePairingToken = 'ODg2Njk0NTQzM';

  /// Default ECU IMEI and registered mobile number for this bike
  static const String defaultEcuImei = '864218069498106';
  static const String defaultMobileNumber = '8866945430';

  /// Computes the authentic Revolt 13-character BLE pairing token from the
  /// registered mobile number and ECU IMEI.
  static String deriveToken({
    required String mobileNumber,
    required String ecuImei,
  }) {
    final combined = '$mobileNumber:$ecuImei';
    final b64 = base64Encode(utf8.encode(combined));
    return b64.length >= 13 ? b64.substring(0, 13) : b64;
  }

  static const double defaultBatteryCapacityKwh = 3.24;
  static const double maxChargingSpeedKw = 5.0;
  static const double assumedTypicalChargingRateKw = 3.0;
  static const double petrolPricePerLitre = 100.0;
  static const double petrolMileageKmPerLitre = 40.0;
  static const double petrolCo2KgPerLitre = 2.3;
  static const double gridCo2KgPerKwh = 0.5;
  static const double dashboardPetrolCo2GramsPerKm = 60.0;
}
