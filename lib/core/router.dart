import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/view/app_shell.dart';
import '../features/rides/presentation/rides_screen.dart';
import '../features/rides/presentation/ride_entry_form_screen.dart';
import '../features/charging/presentation/charging_screen.dart';
import '../features/charging/presentation/charge_entry_form_screen.dart';
import '../features/expenses/presentation/expenses_screen.dart';
import '../features/expenses/presentation/expense_entry_form_screen.dart';
import '../features/expenses/domain/expense.dart';
import '../features/maintenance/presentation/maintenance_screen.dart';
import '../features/maintenance/presentation/maintenance_entry_form_screen.dart';
import '../features/maintenance/domain/maintenance_log.dart';
import '../features/reminders/presentation/reminders_screen.dart';
import '../features/analytics/presentation/analytics_screen.dart';
import '../features/analytics/presentation/battery_analytics_screen.dart';
import '../features/analytics/presentation/efficiency_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/settings/presentation/profile_screen.dart';
import '../features/bikes/presentation/bike_profile_screen.dart';
import '../features/bikes/presentation/bike_edit_screen.dart';
import '../features/rides/presentation/ride_details_screen.dart';
import '../features/rides/domain/ride.dart';
import '../features/charging/presentation/charge_details_screen.dart';
import '../features/charging/domain/charge_log.dart';
import '../features/documents/presentation/documents_screen.dart';
import '../features/documents/presentation/document_add_screen.dart';
import '../features/documents/presentation/document_preview_screen.dart';
import '../features/documents/domain/document.dart';
import '../features/reminders/presentation/reminder_add_edit_screen.dart';
import '../features/reminders/domain/reminder.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/analytics/presentation/statistics_screen.dart';
import '../features/ble/presentation/screens/device_status_screen.dart';
import '../features/ble/presentation/screens/device_scan_screen.dart';
import '../features/ble/presentation/screens/device_pair_screen.dart';

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

final routerDelegate = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
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
              pageBuilder: (context, state) => buildPageWithDefaultTransition(context: context, state: state, child: const RidesScreen()),
              routes: [
                GoRoute(
                  path: 'add',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(context: context, state: state, child: const RideEntryFormScreen()),
                ),
                GoRoute(
                  path: 'edit',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(context: context, state: state, child: RideEntryFormScreen(ride: state.extra as Ride?)),
                ),
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id'];
                    final ride = state.extra as Ride?;
                    return buildPageWithDefaultTransition(context: context, state: state, child: RideDetailsScreen(ride: ride!, rideId: id));
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/charging',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(context: context, state: state, child: const ChargingScreen()),
              routes: [
                GoRoute(
                  path: 'add',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(context: context, state: state, child: const ChargeEntryFormScreen()),
                ),
                GoRoute(
                  path: 'edit',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(context: context, state: state, child: ChargeEntryFormScreen(log: state.extra as ChargeLog?)),
                ),
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) {
                     final id = state.pathParameters['id'];
                     final log = state.extra as ChargeLog?;
                     return buildPageWithDefaultTransition(context: context, state: state, child: ChargeDetailsScreen(log: log!, chargeId: id));
                  },
                ),
              ],
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
    GoRoute(
      path: '/device',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const DeviceStatusScreen(),
      ),
      routes: [
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
            child: DevicePairScreen(deviceId: state.extra as String?),
          ),
        ),
      ],
    ),
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
      builder: (context, state) => ExpenseEntryFormScreen(expense: state.extra as Expense?),
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
      builder: (context, state) => MaintenanceEntryFormScreen(log: state.extra as MaintenanceLog?),
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
          builder: (context, state) => ReminderAddEditScreen(reminder: state.extra as Reminder),
        ),
      ]
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
          builder: (context, state) => DocumentPreviewScreen(document: state.extra as Document),
        ),
      ]
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
      path: '/bike',
      builder: (context, state) => const BikeProfileScreen(),
    ),
    GoRoute(
      path: '/bike/edit',
      builder: (context, state) => const BikeEditScreen(),
    ),
  ],
);