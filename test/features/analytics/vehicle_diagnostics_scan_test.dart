import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_data/features/analytics/presentation/vehicle_diagnostics_scan_screen.dart';

void main() {
  group('VehicleDiagnosticsScanScreen Widget Tests', () {
    testWidgets('Renders all 5 Revolt RV400 subsystems and self-check diagnostics scanner', (tester) async {
      tester.view.physicalSize = const Size(1080, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: VehicleDiagnosticsScanScreen(),
          ),
        ),
      );

      // Verify Header and Hero Health Card
      expect(find.text('Bike Diagnostics Scan'), findsOneWidget);
      expect(find.text('SYSTEM HEALTH STATUS'), findsOneWidget);
      expect(find.text('100% ALL SYSTEMS GO'), findsOneWidget);
      expect(find.text('Run Diagnostics Self-Check'), findsOneWidget);

      // Verify All 5 RV400 Subsystem Diagnostic Blocks
      expect(find.text('1. Battery Management System (BMS)'), findsOneWidget);
      expect(find.text('2. Motor Control Unit (MCU)'), findsOneWidget);
      expect(find.text('3. 4G IoT Telematics & GPS Lock'), findsOneWidget);
      expect(find.text('4. Safety & Braking Sensors'), findsOneWidget);
      expect(find.text('5. 12V Auxiliary Electricals'), findsOneWidget);

      // Verify Specific Subsystem Metrics
      expect(find.textContaining('Pack Voltage'), findsOneWidget);
      expect(find.textContaining('Motor Temp'), findsOneWidget);
      expect(find.textContaining('8+ Satellites'), findsOneWidget);
      expect(find.textContaining('Side-Stand Switch'), findsOneWidget);
      expect(find.textContaining('12.8 V (Optimal)'), findsOneWidget);
      expect(find.textContaining('MCB Main Breaker'), findsOneWidget);

      // Trigger Scan and verify state transition
      await tester.tap(find.text('Run Diagnostics Self-Check'));
      await tester.pump();
      expect(find.text('Scanning RV400 Subsystems...'), findsOneWidget);

      // Advance time for simulated scan
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();
      expect(find.text('Run Diagnostics Self-Check'), findsOneWidget);
    });
  });
}
