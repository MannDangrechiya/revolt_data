import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:revolt_data/features/rides/presentation/ride_entry_form_screen.dart';
import 'package:revolt_data/features/rides/data/rides_provider.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';

class MockRidesNotifier extends Rides {
  bool addRideCalled = false;
  Ride? addedRide;

  @override
  Stream<List<Ride>> build() async* {
    yield [];
  }

  @override
  Future<void> addRide(Ride ride, {String source = 'manual'}) async {
    addRideCalled = true;
    addedRide = ride;
  }
}

void main() {
  group('RideEntryFormScreen Widget Tests', () {
    testWidgets('validation fails on empty fields', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      final mockNotifier = MockRidesNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ridesProvider.overrideWith(() => mockNotifier),
          ],
          child: const MaterialApp(
            home: RideEntryFormScreen(),
          ),
        ),
      );

      // Tap the AppBar submit button (check icon)
      await tester.tap(find.byIcon(LucideIcons.check));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsWidgets);
      expect(mockNotifier.addRideCalled, false);
    });

    testWidgets('validation fails when end odometer is less than start', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      final mockNotifier = MockRidesNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ridesProvider.overrideWith(() => mockNotifier),
          ],
          child: const MaterialApp(
            home: RideEntryFormScreen(),
          ),
        ),
      );

      await tester.enterText(find.bySemanticsLabel('Start Odo (km)*'), '100');
      await tester.enterText(find.bySemanticsLabel('End Odo (km)*'), '90');
      await tester.enterText(find.bySemanticsLabel('Battery Before (%)*'), '100');
      await tester.enterText(find.bySemanticsLabel('Battery After (%)*'), '90');

      final submitButton = find.byType(FilledButton);
      await tester.scrollUntilVisible(submitButton, 100.0, scrollable: find.byType(Scrollable).first);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('End odometer must be greater than start odometer'), findsOneWidget);
      expect(mockNotifier.addRideCalled, false);
    });
  });
}
