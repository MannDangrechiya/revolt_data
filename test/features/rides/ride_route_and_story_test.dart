import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/maintenance/presentation/rv400_care_guide_screen.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';
import 'package:revolt_data/features/rides/presentation/widgets/ride_route_map_widget.dart';
import 'package:revolt_data/features/rides/presentation/widgets/ride_story_sheet.dart';

void main() {
  group('Speed Heatmap & Replay Tests', () {
    test('getSpeedColor maps speed to correct color bands', () {
      // Eco Cruising (< 35 km/h) -> Green
      expect(RideRouteMapWidget.getSpeedColor(0.0), const Color(0xFF10B981));
      expect(RideRouteMapWidget.getSpeedColor(24.5), const Color(0xFF10B981));
      expect(RideRouteMapWidget.getSpeedColor(34.9), const Color(0xFF10B981));

      // Commute Pace (35 - 60 km/h) -> Amber / Orange
      expect(RideRouteMapWidget.getSpeedColor(35.0), const Color(0xFFF59E0B));
      expect(RideRouteMapWidget.getSpeedColor(48.0), const Color(0xFFF59E0B));
      expect(RideRouteMapWidget.getSpeedColor(60.0), const Color(0xFFF59E0B));

      // Sport / Top Speed (> 60 km/h) -> Red
      expect(RideRouteMapWidget.getSpeedColor(60.1), const Color(0xFFEF4444));
      expect(RideRouteMapWidget.getSpeedColor(85.0), const Color(0xFFEF4444));
    });

    testWidgets('RideRouteMapWidget renders empty state when polyline is null or empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RideRouteMapWidget(routePolylineJson: null),
          ),
        ),
      );

      expect(find.text('No GPS route breadcrumbs recorded for this ride'), findsOneWidget);
    });
  });

  group('RideStorySheet Unit & Widget Tests', () {
    final sampleRide = Ride(
      id: 'test-ride-01',
      date: DateTime(2026, 10, 16, 14, 30),
      startOdometer: 1000.0,
      endOdometer: 1040.0, // 40 km
      batteryBefore: 85,
      batteryAfter: 45, // 40% consumed
      rideMode: RideMode.sport,
      roadCondition: RoadCondition.smooth,
      durationMinutes: 45,
      averageSpeed: 42.0,
      maxSpeed: 75.0,
    );

    test('Computes kWh, savings and CO2 accurately for RV400 3.24 kWh pack', () {
      final sheet = RideStorySheet(ride: sampleRide);

      // 40% of 3.24 kWh = 1.296 kWh
      expect(sheet.kwhUsed, closeTo(1.296, 0.001));

      // Petrol 40 km / 40 km/L = 1.0 L * ₹105 = ₹105.0
      // EV cost 1.296 kWh * ₹8 = ₹10.368
      // Net Savings = ₹105 - ₹10.368 = ₹94.632
      expect(sheet.petrolSavingsInr, closeTo(94.63, 0.01));

      // CO2 avoided = 40 km * 0.12 kg/km = 4.8 kg
      expect(sheet.co2OffsetKg, closeTo(4.8, 0.001));

      final shareText = sheet.generateShareText();
      expect(shareText, contains('Revolt RV400'));
      expect(shareText, contains('SPORT'));
      expect(shareText, contains('40.0 km'));
      expect(shareText, contains('₹95'));
      expect(shareText, contains('4.80 kg CO₂'));
    });

    testWidgets('RideStorySheet renders visual stats card with mode badge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RideStorySheet(ride: sampleRide),
          ),
        ),
      );

      expect(find.text('REVOLT RV400'), findsOneWidget);
      expect(find.text('SPORT'), findsOneWidget);
      expect(find.text('40.0 KM'), findsOneWidget);
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('75 km/h'), findsOneWidget);
      expect(find.text('Share My Ride'), findsOneWidget);
      expect(find.text('Copy Text'), findsOneWidget);
    });
  });

  group('Rv400CareGuideScreen Widget Tests', () {
    testWidgets('Renders all five RV400 specific mechanical care sections', (tester) async {
      tester.view.physicalSize = const Size(1080, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Rv400CareGuideScreen(),
        ),
      );

      expect(find.text('Revolt RV400 Care Guide'), findsOneWidget);
      expect(find.text('1. Carbon Belt Drive Care'), findsOneWidget);
      expect(find.text('2. Tyre Pressure (PSI) Guide'), findsOneWidget);
      expect(find.text('3. CBS Brakes & Regen'), findsOneWidget);
      expect(find.text('4. 12V Auxiliary Battery Care'), findsOneWidget);
      expect(find.text('5. MCB Switch & Storage Rules'), findsOneWidget);

      // Verify authentic specifications
      expect(find.textContaining('5 to 8 mm'), findsOneWidget);
      expect(find.textContaining('NEVER use chain lube'), findsOneWidget);
      expect(find.textContaining('28 - 30 PSI'), findsOneWidget);
      expect(find.textContaining('34 - 36 PSI'), findsOneWidget);
      expect(find.textContaining('1.5 mm'), findsOneWidget);
    });
  });
}
