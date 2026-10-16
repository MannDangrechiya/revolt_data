import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/view/app_shell.dart';
import '../features/rides/presentation/rides_screen.dart';
import '../features/rides/presentation/ride_entry_form_screen.dart';
import '../features/charging/presentation/charging_screen.dart';
import '../features/charging/presentation/charge_entry_form_screen.dart';
import '../features/expenses/presentation/expenses_screen.dart';
import '../features/expenses/presentation/expense_entry_form_screen.dart';
import '../features/maintenance/presentation/maintenance_screen.dart';
import '../features/maintenance/presentation/maintenance_entry_form_screen.dart';
import '../features/reminders/presentation/reminders_screen.dart';
import '../features/analytics/presentation/analytics_screen.dart';
import '../features/analytics/presentation/battery_analytics_screen.dart';
import '../features/analytics/presentation/efficiency_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/settings/presentation/profile_screen.dart';
import '../features/bikes/presentation/bike_profile_screen.dart';
import '../features/bikes/presentation/bike_edit_screen.dart';
import '../features/rides/presentation/ride_details_screen.dart';
import '../features/charging/presentation/charge_details_screen.dart';
import '../features/documents/presentation/documents_screen.dart';
import '../features/documents/presentation/document_add_screen.dart';
import '../features/documents/presentation/document_preview_screen.dart';
import '../features/reminders/presentation/reminder_add_edit_screen.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/analytics/presentation/statistics_screen.dart';
import '../features/ble/presentation/screens/device_status_screen.dart';
import '../features/ble/presentation/screens/device_scan_screen.dart';
import '../features/ble/presentation/screens/device_pair_screen.dart';
import '../features/ble/presentation/screens/ble_debug_screen.dart';
import '../features/notifications/presentation/notification_history_screen.dart';
import '../features/intelligence/presentation/coaches_screen.dart';
import '../features/dashboard/presentation/sound_studio_screen.dart';
import '../features/security/presentation/security_screen.dart';
import '../features/analytics/presentation/battery_diagnostics_screen.dart';
import '../features/intelligence/presentation/range_planner_screen.dart';
import '../features/charging/presentation/home_charging_screen.dart';
import '../features/settings/presentation/device_hub_screen.dart';
import '../features/maintenance/presentation/rv400_care_guide_screen.dart';

/// Helper function to build custom page transition with Curves.easeInOutCirc fade.
CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Primary GoRouter configuration for Revolt app navigation.
final routerDelegate = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Bottom navigation shell containing 4 main tab branches
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/rides',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const RidesScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'add',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const RideEntryFormScreen(),
                  ),
                ),
                GoRoute(
                  path: 'edit',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const RideEntryFormScreen(),
                  ),
                ),
                GoRoute(
                  path: 'edit/:id',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: RideEntryFormScreen(rideId: state.pathParameters['id']),
                  ),
                ),
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: RideDetailsScreen(rideId: id),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/ride/detail/:id',
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: RideDetailsScreen(rideId: id),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/charging',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const ChargingScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'add',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const ChargeEntryFormScreen(),
                  ),
                ),
                GoRoute(
                  path: 'edit',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const ChargeEntryFormScreen(),
                  ),
                ),
                GoRoute(
                  path: 'edit/:id',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: ChargeEntryFormScreen(logId: state.pathParameters['id']),
                  ),
                ),
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: ChargeDetailsScreen(chargeId: id),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/charging/detail/:id',
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: ChargeDetailsScreen(chargeId: id),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/analytics',
              builder: (context, state) => const AnalyticsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Top-level BLE device routes (overlay on top of shell with back navigation)
    GoRoute(
      path: '/device',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const DeviceStatusScreen(),
      ),
      routes: [
        GoRoute(
          path: 'debug',
          redirect: (context, state) {
            if (kReleaseMode) {
              return '/device';
            }
            return null;
          },
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const BleDebugScreen(),
          ),
        ),
        GoRoute(
          path: 'scan',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const DeviceScanScreen(),
          ),
        ),
        GoRoute(
          path: 'pair',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: DevicePairScreen(deviceId: state.uri.queryParameters['deviceId']),
          ),
        ),
        GoRoute(
          path: 'pair/:deviceId',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: DevicePairScreen(deviceId: state.pathParameters['deviceId']),
          ),
        ),
      ],
    ),

    // Additional top-level application feature routes
    GoRoute(
      path: '/battery-analytics',
      builder: (context, state) => const BatteryAnalyticsScreen(),
    ),
    GoRoute(
      path: '/efficiency',
      builder: (context, state) => const EfficiencyScreen(),
    ),
    GoRoute(
      path: '/expenses',
      builder: (context, state) => const ExpensesScreen(),
    ),
    GoRoute(
      path: '/expenses/add',
      builder: (context, state) => const ExpenseEntryFormScreen(),
    ),
    GoRoute(
      path: '/expenses/edit',
      builder: (context, state) => const ExpenseEntryFormScreen(),
    ),
    GoRoute(
      path: '/expenses/edit/:id',
      builder: (context, state) => ExpenseEntryFormScreen(expenseId: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/maintenance',
      builder: (context, state) => const MaintenanceScreen(),
    ),
    GoRoute(
      path: '/maintenance/add',
      builder: (context, state) => const MaintenanceEntryFormScreen(),
    ),
    GoRoute(
      path: '/maintenance/edit',
      builder: (context, state) => const MaintenanceEntryFormScreen(),
    ),
    GoRoute(
      path: '/maintenance/edit/:id',
      builder: (context, state) => MaintenanceEntryFormScreen(logId: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/maintenance/care-guide',
      builder: (context, state) => const Rv400CareGuideScreen(),
    ),
    GoRoute(
      path: '/reminders',
      builder: (context, state) => const RemindersScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const ReminderAddEditScreen(),
        ),
        GoRoute(
          path: 'edit',
          builder: (context, state) => const ReminderAddEditScreen(),
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) => ReminderAddEditScreen(reminderId: state.pathParameters['id']),
        ),
      ],
    ),
    GoRoute(
      path: '/documents',
      builder: (context, state) => const DocumentsScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const DocumentAddScreen(),
        ),
        GoRoute(
          path: 'preview',
          builder: (context, state) => DocumentPreviewScreen(documentId: state.uri.queryParameters['id'] ?? ''),
        ),
        GoRoute(
          path: 'preview/:id',
          builder: (context, state) => DocumentPreviewScreen(documentId: state.pathParameters['id']!),
        ),
      ],
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const StatisticsScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationHistoryScreen(),
    ),
    GoRoute(
      path: '/bike',
      builder: (context, state) => const BikeProfileScreen(),
    ),
    GoRoute(
      path: '/bike/edit',
      builder: (context, state) => const BikeEditScreen(),
    ),
    GoRoute(
      path: '/coaches',
      builder: (context, state) => const CoachesScreen(),
    ),
    GoRoute(
      path: '/sound-studio',
      builder: (context, state) => const SoundStudioScreen(),
    ),
    GoRoute(
      path: '/security',
      builder: (context, state) => const SecurityScreen(),
    ),
    GoRoute(
      path: '/battery-diagnostics',
      builder: (context, state) => const BatteryDiagnosticsScreen(),
    ),
    GoRoute(
      path: '/range-planner',
      builder: (context, state) => const RangePlannerScreen(),
    ),
    GoRoute(
      path: '/home-charging',
      builder: (context, state) => const HomeChargingScreen(),
    ),
    GoRoute(
      path: '/device-hub',
      builder: (context, state) => const DeviceHubScreen(),
    ),
  ],
);