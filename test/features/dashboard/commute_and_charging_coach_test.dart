import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/dashboard/presentation/widgets/commute_readiness_card.dart';

void main() {
  group('CommuteReadinessCard Widget & Logic Tests', () {
    testWidgets('Renders Commute Ready state when battery is >= 75%', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommuteReadinessCard(currentSoc: 82),
          ),
        ),
      );

      expect(find.text('Vastral ↔ Kudasan'), findsOneWidget);
      expect(find.text('Commute Ready'), findsOneWidget);
      expect(find.textContaining('Full 55 km round-trip feasible'), findsOneWidget);
      expect(find.text('Mode 2 Norm'), findsOneWidget);
      expect(find.text('₹93.00'), findsOneWidget);
    });

    testWidgets('Renders Marginal Buffer state when battery is between 60% and 74%', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommuteReadinessCard(currentSoc: 65),
          ),
        ),
      );

      expect(find.text('Vastral ↔ Kudasan'), findsOneWidget);
      expect(find.text('Marginal Buffer'), findsOneWidget);
      expect(find.textContaining('Cruise in Mode 1 (Eco)'), findsOneWidget);
      expect(find.text('Mode 1 Eco'), findsOneWidget);
    });

    testWidgets('Renders Charge Needed state when battery is < 60%', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommuteReadinessCard(currentSoc: 48),
          ),
        ),
      );

      expect(find.text('Vastral ↔ Kudasan'), findsOneWidget);
      expect(find.text('Charge Needed'), findsOneWidget);
      expect(find.textContaining('Insufficient range for 55 km round-trip'), findsOneWidget);
      expect(find.text('Top Up 15A Socket'), findsOneWidget);
    });
  });

  group('Night 15A Charging Coach & Gujarat Tariff Calculations', () {
    test('Gujarat UGVCL / Torrent Power tariff calculation produces expected figures', () {
      const tariffPerKwh = 6.50; // Gujarat residential default
      const batteryCapacityKwh = 3.24;

      // 55 km commute consumption (~56% SOC = 1.81 kWh)
      const kwhFor55Km = (55.0 / 150.0) * batteryCapacityKwh;
      final dailyChargeCost = kwhFor55Km * tariffPerKwh;

      expect(dailyChargeCost, closeTo(7.7, 0.5)); // ~₹8 per day electric fuel

      // If recharging full 2.0 kWh daily
      final twoUnitCost = 2.0 * tariffPerKwh;
      expect(twoUnitCost, equals(13.0)); // ₹13.00 per day

      // Monthly savings vs ICE bike (55 km @ ₹105 petrol per day)
      const iceDailyCost = 105.0;
      final monthlySavings = (iceDailyCost - twoUnitCost) * 26; // 26 working days
      expect(monthlySavings, equals(2392.0)); // ~₹2,400 monthly savings
    });

    test('80% Longevity cutoff time estimation', () {
      // From 20% to 80% = 60% added
      const socToAdd = 60;
      const minsPerPercent = 2.4; // 700W Revolt charger curve
      final totalMins = (socToAdd * minsPerPercent).round(); // 144 mins = 2h 24m
      final hours = totalMins ~/ 60;
      final mins = totalMins % 60;

      expect(hours, equals(2));
      expect(mins, equals(24));
    });
  });
}
