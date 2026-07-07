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
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/settings/presentation/profile_screen.dart';

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
              builder: (context, state) => const RidesScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const RideEntryFormScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/charging',
              builder: (context, state) => const ChargingScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const ChargeEntryFormScreen(),
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
      path: '/expenses',
      builder: (context, state) => const ExpensesScreen(),
    ),
    GoRoute(
      path: '/expenses/add',
      builder: (context, state) => const ExpenseEntryFormScreen(),
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
      path: '/reminders',
      builder: (context, state) => const RemindersScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);