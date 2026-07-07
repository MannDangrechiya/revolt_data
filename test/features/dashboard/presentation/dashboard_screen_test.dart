import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_data/features/dashboard/presentation/dashboard_screen.dart';
import 'package:revolt_data/features/dashboard/data/dashboard_provider.dart';
import 'package:revolt_data/features/dashboard/domain/dashboard_data.dart';
import 'package:revolt_data/features/bikes/data/bike_provider.dart';
import 'package:revolt_data/features/bikes/domain/bike.dart';
import 'package:revolt_data/core/widgets/skeleton_loader.dart';

class MockDashboardDataNotifier extends DashboardDataNotifier {
  final AsyncValue<DashboardData> customState;
  
  MockDashboardDataNotifier(this.customState);
  
  @override
  Stream<DashboardData> build() async* {
    if (customState.hasError) {
      throw customState.error!;
    }
    if (customState.hasValue) {
      yield customState.value!;
    }
    // if loading, stream just doesn't yield immediately or we simulate loading via state
  }
}

class MockCurrentBike extends CurrentBike {
  final AsyncValue<Bike?> customState;
  
  MockCurrentBike(this.customState);
  
  @override
  FutureOr<Bike?> build() {
    if (customState.hasError) throw customState.error!;
    return customState.value;
  }
}

void main() {
  group('DashboardScreen Widget Tests', () {
    testWidgets('shows loading skeleton when data is loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardDataProvider.overrideWith(
              () => MockDashboardDataNotifier(const AsyncValue.loading())
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Verify that ListSkeletonLoader is shown
      expect(find.byType(ListSkeletonLoader), findsOneWidget);
    });

    testWidgets('shows error state when data fails to load', (tester) async {
      final error = Exception('Failed to load dashboard data');
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardDataProvider.overrideWith(
              () => MockDashboardDataNotifier(AsyncValue.error(error, StackTrace.empty))
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify error text is displayed
      expect(find.textContaining('Failed to load dashboard data'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('shows dashboard data when successfully loaded', (tester) async {
      final dashboardData = DashboardData(
        currentOdometer: 1500.5,
        todayDistance: 15.0,
        weeklyDistance: 100.0,
        monthlyDistance: 450.0,
        totalDistance: 1500.5,
        totalCharges: 25,
        totalChargingCost: 1500.0,
        petrolSaved: 3750.0,
        co2Saved: 90.0,
        latestBatteryPercentage: 85,
      );

      final bike = Bike(
        id: 1,
        name: 'My RV400 Test',
        brand: 'Revolt',
        model: 'RV400',
        color: 'Black',
        registrationNumber: 'MH01AB1234',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardDataProvider.overrideWith(
              () => MockDashboardDataNotifier(AsyncValue.data(dashboardData))
            ),
            currentBikeProvider.overrideWith(
              () => MockCurrentBike(AsyncValue.data(bike))
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify Dashboard contents
      expect(find.text('My RV400 Test'), findsOneWidget); // Bike name
      expect(find.text('Welcome back!'), findsOneWidget);
      expect(find.text('1500.5'), findsOneWidget); // Odometer
      expect(find.text('85%'), findsOneWidget); // Battery
      expect(find.text('Quick Actions'), findsOneWidget);
      
      // Verify Menu Items exist
      expect(find.text('Rides'), findsOneWidget);
      expect(find.text('Charging'), findsOneWidget);
    });
  });
}
