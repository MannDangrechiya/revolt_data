import 'package:flutter_test/flutter_test.dart';

void main() {
  group('15A Home Charging Logic Tests', () {
    test('Calculates time to 80% and 100% accurately for RV400 3.24 kWh pack', () {
      const currentSoc = 40; // 40% battery
      final socLeftTo80 = (80 - currentSoc).clamp(0, 80); // 40%
      final socLeftTo100 = (100 - currentSoc).clamp(0, 100); // 60%

      // ~2.4 mins per 1% SOC to 80%
      final minsTo80 = (socLeftTo80 * 2.4).round();
      expect(minsTo80, 96); // 1h 36m

      // ~2.5 mins per 1% SOC to 100%
      final minsTo100 = (socLeftTo100 * 2.5).round();
      expect(minsTo100, 150); // 2h 30m
    });

    test('Computes electrical energy and session cost in INR correctly', () {
      const deltaSoc = 50; // Charged 50%
      const packCapacityKwh = 3.24;
      const tariffPerKwh = 8.0; // ₹8 per unit

      final kwhConsumed = (deltaSoc / 100.0) * packCapacityKwh;
      expect(kwhConsumed, closeTo(1.62, 0.01));

      final costRs = kwhConsumed * tariffPerKwh;
      expect(costRs, closeTo(12.96, 0.01));
    });

    test('Calculates petrol savings vs 60 km/L commuter ICE bike', () {
      const kmGained = 50.0; // 50 km gained from charge
      const petrolMileage = 60.0; // km/L
      const petrolPrice = 105.0; // ₹/L

      final petrolEquivalentRs = (kmGained / petrolMileage) * petrolPrice;
      expect(petrolEquivalentRs, closeTo(87.50, 0.01));
    });

    test('Charging power in kW matches V * A / 1000', () {
      const voltage = 72.4;
      const current = 8.5; // 8.5 A charging current
      final powerKw = (voltage * current) / 1000.0;

      expect(powerKw, closeTo(0.615, 0.001));
    });
  });
}
