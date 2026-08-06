import 'dart:async';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revolt_data/features/dashboard/presentation/dashboard_screen.dart';
import 'package:revolt_data/features/dashboard/data/dashboard_provider.dart';
import 'package:revolt_data/features/dashboard/domain/dashboard_data.dart';
import 'package:revolt_data/features/bikes/data/bike_provider.dart';
import 'package:revolt_data/features/bikes/domain/bike.dart';
import 'package:revolt_data/core/widgets/skeleton_loader.dart';
import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/core/database/database_provider.dart';
import 'package:revolt_data/features/sync/data/sync_state_service.dart';
import 'package:revolt_data/features/sync/data/sync_history_log.dart';
import 'package:revolt_data/features/rides/data/rides_provider.dart';
import 'package:revolt_data/features/rides/domain/ride.dart';

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

class MockRidesNotifier extends Rides {
  @override
  Stream<List<Ride>> build() async* {
    yield [];
  }
}

class MockSyncHistoryLogService implements SyncHistoryLogService {
  @override
  Future<DateTime?> getLastSyncTime() async => null;

  @override
  Future<List<SyncLog>> getSyncHistory({int limit = 50}) async => [];

  @override
  Future<int> cleanupOldLogs() async => 0;

  @override
  Future<int> logSync({
    required String result,
    int ridesAdded = 0,
    int chargesAdded = 0,
    int conflictsResolved = 0,
    String? detailsJson,
  }) async => 0;
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('DashboardScreen Widget Tests', () {
    testWidgets('shows loading skeleton when data is loading', (tester) async {
      final prefs = await SharedPreferences.getInstance();
      final db = AppDatabase.forTesting(NativeDatabase.memory());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardDataProvider.overrideWith(
              () => MockDashboardDataNotifier(const AsyncValue.loading())
            ),
            databaseProvider.overrideWithValue(db),
            syncStateServiceProvider.overrideWith(
              (ref) async => SyncStateService(prefs),
            ),
            syncHistoryLogServiceProvider.overrideWithValue(
              MockSyncHistoryLogService(),
            ),
            ridesProvider.overrideWith(() => MockRidesNotifier()),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      expect(find.byType(ListSkeletonLoader), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(Duration.zero);
    });

    testWidgets('shows error state when data fails to load', (tester) async {
      final error = Exception('Failed to load dashboard data');
      final prefs = await SharedPreferences.getInstance();
      final db = AppDatabase.forTesting(NativeDatabase.memory());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardDataProvider.overrideWith(
              () => MockDashboardDataNotifier(AsyncValue.error(error, StackTrace.empty))
            ),
            databaseProvider.overrideWithValue(db),
            syncStateServiceProvider.overrideWith(
              (ref) async => SyncStateService(prefs),
            ),
            syncHistoryLogServiceProvider.overrideWithValue(
              MockSyncHistoryLogService(),
            ),
            ridesProvider.overrideWith(() => MockRidesNotifier()),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Failed to load dashboard data'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(Duration.zero);
    });
  });
}
