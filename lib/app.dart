import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/router.dart' as router;
import 'features/ble/domain/ble_trip_state.dart';
import 'features/ble/presentation/providers/ble_session_coordinator.dart';
import 'features/ble/presentation/providers/ble_trip_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/tracking/domain/commute_schedule.dart';
import 'features/tracking/domain/gps_tracking_state.dart';
import 'features/tracking/presentation/providers/gps_ride_provider.dart';

class AppWidget extends ConsumerStatefulWidget {
  final String organization = "VoltLog Engineering";

  const AppWidget({super.key});

  @override
  ConsumerState<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends ConsumerState<AppWidget>
    with WidgetsBindingObserver {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  int? _lastPromptDayOfYear;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybePromptCommute());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _maybePromptCommute();
  }

  /// Offers (never forces) a commute ride when the app is opened in the
  /// morning window and nothing is being tracked. Shown once per day.
  void _maybePromptCommute() {
    final now = DateTime.now();
    final dayKey = now.year * 1000 + now.difference(DateTime(now.year)).inDays;
    if (_lastPromptDayOfYear == dayKey || !isInCommutePromptWindow(now)) return;

    final isTracking = ref.read(gpsRideProvider) is GpsTrackingStateActive;
    final tripStatus = ref.read(bleTripProvider).status;
    final isRiding = tripStatus == BleTripStatus.riding ||
        tripStatus == BleTripStatus.gpsHandoff;
    final messenger = _messengerKey.currentState;
    if (isTracking || isRiding || messenger == null) return;

    _lastPromptDayOfYear = dayKey;
    messenger.showMaterialBanner(
      MaterialBanner(
        content: const Text('Heading out? Start tracking your commute.'),
        leading: const Icon(Icons.two_wheeler),
        actions: [
          TextButton(
            onPressed: messenger.hideCurrentMaterialBanner,
            child: const Text('Dismiss'),
          ),
          FilledButton(
            onPressed: () {
              messenger.hideCurrentMaterialBanner();
              router.routerDelegate.push(kCommuteRoute);
            },
            child: const Text('Start Commute'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    ref.watch(bleSessionCoordinatorProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: _messengerKey,
      routerConfig: router.routerDelegate,
      title: widget.organization,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
    );
  }
}
