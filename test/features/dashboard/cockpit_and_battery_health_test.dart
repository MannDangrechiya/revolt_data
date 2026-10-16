import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_data/features/analytics/presentation/battery_health_screen.dart';
import 'package:revolt_data/features/dashboard/presentation/riding_cockpit_screen.dart';

void main() {
  group('RidingCockpitScreen Widget Tests', () {
    testWidgets('Renders high-contrast OLED cockpit with speed, mode range and power meter', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RidingCockpitScreen(),
          ),
        ),
      );

      // Verify Cockpit UI elements
      expect(find.text('KM / H'), findsOneWidget);
      expect(find.text('ECO CRUISING'), findsOneWidget);
      expect(find.text('MODE 1 (ECO)'), findsOneWidget);
      expect(find.text('MODE 2 (NORM)'), findsOneWidget);
      expect(find.text('MODE 3 (SPORT)'), findsOneWidget);
      expect(find.text('BATTERY'), findsOneWidget);
      expect(find.text('PACK / MOTOR'), findsOneWidget);
      expect(find.text('SESSION TIME'), findsOneWidget);
      expect(find.text('ODOMETER'), findsOneWidget);
    });
  });

  group('BatteryHealthScreen Widget Tests', () {
    testWidgets('Renders SOH hero card, cycle counter, thermal zones and longevity tips', (tester) async {
      tester.view.physicalSize = const Size(1080, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BatteryHealthScreen(),
          ),
        ),
      );

      // Verify SOH Hero Card & Subtitle
      expect(find.text('STATE OF HEALTH (SOH)'), findsOneWidget);
      expect(find.text('OPTIMAL'), findsOneWidget);
      expect(find.textContaining('Ah remaining of original 45.0 Ah (3.24 kWh)'), findsOneWidget);

      // Verify Metrics Grid
      expect(find.text('Full Cycles'), findsOneWidget);
      expect(find.text('of ~1,500 rated cycles'), findsOneWidget);
      expect(find.text('Energy Used'), findsOneWidget);
      expect(find.text('Avg Efficiency'), findsOneWidget);
      expect(find.text('Pack Chemistry'), findsOneWidget);

      // Verify Thermal Zones
      expect(find.text('Thermal Operating History'), findsOneWidget);
      expect(find.text('Optimal Zone (20°C - 38°C)'), findsOneWidget);
      expect(find.text('Warm Zone (38°C - 45°C)'), findsOneWidget);
      expect(find.text('High Temp Alert (> 45°C)'), findsOneWidget);

      // Verify Longevity Protocols
      expect(find.text('RV400 Battery Longevity Protocols'), findsOneWidget);
      expect(find.text('Prevent Deep Discharges'), findsOneWidget);
      expect(find.text('Post-Ride Cool Down'), findsOneWidget);
      expect(find.text('Storage Strategy (50% - 60% SOC)'), findsOneWidget);
    });
  });
}
