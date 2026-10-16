import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Smart Range Planner Logic Tests', () {
    test('Round-trip distance calculation doubles one-way km', () {
      const oneWayKm = 35.0;
      const isRoundTrip = true;
      final totalKm = isRoundTrip ? oneWayKm * 2 : oneWayKm;

      expect(totalKm, 70.0);
    });

    test('Mode-specific consumption rates project accurate SOC needed', () {
      const totalKm = 42.0;

      // Eco: 1.4 km/%
      final ecoSocNeeded = (totalKm / 1.4).round();
      expect(ecoSocNeeded, 30);

      // Normal: 1.0 km/%
      final normalSocNeeded = (totalKm / 1.0).round();
      expect(normalSocNeeded, 42);

      // Sport: 0.75 km/%
      final sportSocNeeded = (totalKm / 0.75).round();
      expect(sportSocNeeded, 56);
    });

    test('Feasibility categorization identifies Safe vs Eco-only vs Insufficient', () {
      String evaluateFeasibility(int currentSoc, int tripKm) {
        final normalSocNeeded = (tripKm / 1.0).round();
        final ecoSocNeeded = (tripKm / 1.4).round();

        final normalArrival = currentSoc - normalSocNeeded;
        final ecoArrival = currentSoc - ecoSocNeeded;

        if (normalArrival >= 15) return 'Safe';
        if (ecoArrival >= 10) return 'Eco-Only';
        return 'Insufficient';
      }

      // 80% battery, 40 km round-trip: normalArrival = 40% -> Safe
      expect(evaluateFeasibility(80, 40), 'Safe');

      // 50% battery, 45 km round-trip: normalArrival = 5%, ecoArrival = 50 - 32 = 18% -> Eco-Only
      expect(evaluateFeasibility(50, 45), 'Eco-Only');

      // 30% battery, 50 km round-trip: ecoArrival = 30 - 36 = -6% -> Insufficient
      expect(evaluateFeasibility(30, 50), 'Insufficient');
    });
  });
}
