import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../data/dashboard_provider.dart';
import '../../bikes/data/bike_provider.dart';
import '../../intelligence/data/intelligence_provider.dart';
import '../../intelligence/data/service_intelligence_provider.dart';
import '../../intelligence/data/range_prediction_provider.dart';
import '../../ble/domain/connection_state.dart';
import '../../../shared/ui/volt_app_bar.dart';
import '../../../shared/ui/error_widget.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/fade_slide_in.dart';

import 'widgets/dashboard_header.dart';
import 'widgets/battery_status_card.dart';
import 'widgets/dashboard_range_prediction_card.dart';
import 'widgets/dashboard_fault_alert_card.dart';
import 'widgets/dashboard_health_score_card.dart';
import 'widgets/dashboard_smart_alerts_card.dart';
import 'widgets/dashboard_service_intelligence_card.dart';
import 'widgets/dashboard_quick_stats_row.dart';
import 'widgets/dashboard_upcoming_reminder_card.dart';
import 'widgets/quick_actions_grid.dart';

import '../../tracking/domain/gps_tracking_state.dart';
import '../../tracking/presentation/providers/gps_ride_provider.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final bikeAsync = ref.watch(currentBikeProvider);
    final healthScoreAsync = ref.watch(healthScoreProvider);
    final smartAlertsAsync = ref.watch(smartAlertsProvider);
    final serviceIntelligenceAsync = ref.watch(serviceIntelligenceProvider);
    final rangePredictionAsync = ref.watch(rangePredictionProvider);
    final gpsState = ref.watch(gpsRideProvider);

    return Scaffold(
      appBar: VoltAppBar(
        title: 'EV Companion',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.sparkles),
            onPressed: () => context.push('/coaches'),
            tooltip: 'AI Coaches',
          ),
          IconButton(
            icon: const Icon(LucideIcons.bell),
            onPressed: () => context.push('/notifications'),
            tooltip: 'Notifications',
          ),
          IconButton(
            icon: const Icon(LucideIcons.bluetooth),
            onPressed: () => context.push('/device/scan'),
            tooltip: 'Connect Bike',
          ),
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: dashboardAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20.0),
          child: ListSkeletonLoader(itemCount: 4, itemHeight: 150),
        ),
        error: (err, stack) => VoltErrorWidget(
          message: err.toString(),
          onRetry: () => ref.refresh(dashboardDataProvider),
        ),
        data: (data) {
          final bikeName = bikeAsync.value?.name ?? 'My RV400';
          final isConnected =
              data.connectionStatus == BleConnectionState.connected ||
                  data.connectionStatus == BleConnectionState.authenticated;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (gpsState is GpsTrackingStateActive) ...[
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.gps_fixed, color: Colors.white, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tracking via GPS (BLE disconnected)',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Distance: ${gpsState.distanceKm.toStringAsFixed(2)} km | Speed: ${gpsState.currentSpeedKmh.toStringAsFixed(1)} km/h',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.orange.shade900,
                                ),
                                onPressed: () {
                                  ref.read(gpsRideProvider.notifier).finalizeGpsRide();
                                },
                                child: const Text('Stop Ride'),
                              ),
                            ],
                          ),
                        ),
                      ],
                      DashboardHeader(
                        bikeName: bikeName,
                        connectionStatus: data.connectionStatus,
                        currentOdometer: data.currentOdometer,
                      ),
                      const SizedBox(height: 20),
                      FadeSlideIn(
                        index: 0,
                        child: BatteryStatusCard(
                          data: data,
                          isConnected: isConnected,
                        ),
                      ),
                      if (rangePredictionAsync.hasValue) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 1,
                          child: DashboardRangePredictionCard(
                            prediction: rangePredictionAsync.value!,
                          ),
                        ),
                      ],
                      if (data.liveSnapshot != null &&
                          data.liveSnapshot!.faultCodes.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 1,
                          child: DashboardFaultAlertCard(
                            faultCodes: data.liveSnapshot!.faultCodes,
                          ),
                        ),
                      ],
                      if (healthScoreAsync.hasValue) ...[
                        const SizedBox(height: 20),
                        FadeSlideIn(
                          index: 2,
                          child: DashboardHealthScoreCard(
                            score: healthScoreAsync.value!,
                          ),
                        ),
                      ],
                      if (smartAlertsAsync.hasValue &&
                          smartAlertsAsync.value!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 3,
                          child: DashboardSmartAlertsCard(
                            alerts: smartAlertsAsync.value!,
                          ),
                        ),
                      ],
                      if (serviceIntelligenceAsync.hasValue) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 4,
                          child: DashboardServiceIntelligenceCard(
                            prediction: serviceIntelligenceAsync.value!,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      FadeSlideIn(
                        index: 5,
                        child: DashboardQuickStatsRow(data: data),
                      ),
                      if (data.upcomingReminder != null) ...[
                        const SizedBox(height: 20),
                        FadeSlideIn(
                          index: 6,
                          child: DashboardUpcomingReminderCard(
                            reminder: data.upcomingReminder!,
                          ),
                        ),
                      ],
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => context.push('/device/scan'),
                            icon: const Icon(LucideIcons.bluetooth, size: 16),
                            label: const Text('Connect Bike'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const QuickActionsGrid(),
              const SliverToBoxAdapter(child: SizedBox(height: 36)),
            ],
          );
        },
      ),
    );
  }
}
