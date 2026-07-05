import 'package:go_router/go_router.dart';

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

final routerDelegate = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/rides',
      builder: (context, state) => const RidesScreen(),
    ),
    GoRoute(
      path: '/rides/add',
      builder: (context, state) => const RideEntryFormScreen(),
    ),
    GoRoute(
      path: '/charging',
      builder: (context, state) => const ChargingScreen(),
    ),
    GoRoute(
      path: '/charging/add',
      builder: (context, state) => const ChargeEntryFormScreen(),
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
      path: '/analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
  ],
);