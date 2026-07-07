import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  Future<void> addRide(Ride ride) async {
    addRideCalled = true;
    addedRide = ride;
  }
}

void main() {
  group('RideEntryFormScreen Widget Tests', () {
    testWidgets('validation fails on empty fields', (tester) async {
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

      // Tap the submit button (Save Ride)
      final submitButton = find.text('Save Ride');
      await tester.scrollUntilVisible(submitButton, 50.0);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsWidgets);
      expect(mockNotifier.addRideCalled, false);
    });

    testWidgets('validation fails when end odometer is less than start', (tester) async {
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

      await tester.enterText(find.bySemanticsLabel('Start Odometer*'), '100');
      await tester.enterText(find.bySemanticsLabel('End Odometer*'), '90');
      await tester.enterText(find.bySemanticsLabel('Battery Before (%)*'), '100');
      await tester.enterText(find.bySemanticsLabel('Battery After (%)*'), '90');

      final submitButton = find.text('Save Ride');
      await tester.scrollUntilVisible(submitButton, 50.0);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('End odometer must be greater than start odometer'), findsOneWidget);
      expect(mockNotifier.addRideCalled, false);
    });
  });
}
