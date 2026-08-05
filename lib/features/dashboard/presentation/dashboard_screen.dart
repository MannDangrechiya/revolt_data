import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../data/dashboard_provider.dart';
import '../domain/dashboard_data.dart';
import '../../bikes/data/bike_provider.dart';
import '../../reminders/data/reminders_provider.dart';
import '../../reminders/domain/reminder.dart';
import '../../intelligence/data/intelligence_provider.dart';
import '../../intelligence/data/service_intelligence_provider.dart';
import '../../ble/domain/connection_state.dart';
import '../../ble/presentation/widgets/connection_status_badge.dart';
import '../../../shared/ui/volt_app_bar.dart';
import '../../../core/widgets/animated_number.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/error_retry_widget.dart';
import '../../../core/widgets/fade_slide_in.dart';
import 'widgets/battery_status_card.dart';
import 'widgets/quick_actions_grid.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final bikeAsync = ref.watch(currentBikeProvider);
    final healthScoreAsync = ref.watch(healthScoreProvider);
    final smartAlertsAsync = ref.watch(smartAlertsProvider);
    final serviceIntelligenceAsync = ref.watch(serviceIntelligenceProvider);

    return Scaffold(
      appBar: VoltAppBar(
        title: 'EV Companion',
        actions: [
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
        error: (err, stack) => ErrorRetryWidget(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Welcome back!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => context.push('/device'),
                                      child: ConnectionStatusBadge(
                                        state: data.connectionStatus,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () => context.push('/bike'),
                                  child: Row(
                                    children: [
                                      Text(
                                        bikeName,
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(
                                        LucideIcons.chevronRight,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'ODO',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              AnimatedNumber(
                                value: data.currentOdometer,
                                suffix: ' km',
                                fractionDigits: 1,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      FadeSlideIn(
                        index: 0,
                        child: BatteryStatusCard(
                          data: data,
                          isConnected: isConnected,
                        ),
                      ),
                      if (data.liveSnapshot != null &&
                          data.liveSnapshot!.faultCodes.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 1,
                          child: _buildFaultAlertCard(
                              context, data.liveSnapshot!.faultCodes),
                        ),
                      ],
                      if (healthScoreAsync.hasValue) ...[
                        const SizedBox(height: 20),
                        FadeSlideIn(
                          index: 2,
                          child: _buildHealthScoreCard(
                              context, healthScoreAsync.value!),
                        ),
                      ],
                      if (smartAlertsAsync.hasValue &&
                          smartAlertsAsync.value!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 3,
                          child:
                              _buildSmartAlerts(context, smartAlertsAsync.value!),
                        ),
                      ],
                      if (serviceIntelligenceAsync.hasValue) ...[
                        const SizedBox(height: 12),
                        FadeSlideIn(
                          index: 4,
                          child: _buildServiceIntelligenceCard(
                              context, serviceIntelligenceAsync.value!),
                        ),
                      ],
                      const SizedBox(height: 20),
                      FadeSlideIn(
                        index: 5,
                        child: _buildQuickStatsRow(context, data),
                      ),

                      if (data.upcomingReminder != null) ...[
                        const SizedBox(height: 20),
                        FadeSlideIn(
                          index: 6,
                          child: _buildUpcomingReminder(
                              context, ref, data.upcomingReminder!),
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

  Widget _buildFaultAlertCard(BuildContext context, List<String> faultCodes) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.alertTriangle, color: Colors.red, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle Fault Warning',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Fault codes reported: ${faultCodes.join(", ")}',
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScoreCard(BuildContext context, int score) {
    final color = score >= 80
        ? Colors.green
        : score >= 50
            ? Colors.orange
            : Colors.red;
    final subtitle = score >= 80
        ? 'Excellent condition'
        : score >= 50
            ? 'Needs attention'
            : 'Check your bike soon';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.heartPulse, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle Health Score',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          AnimatedNumber(
            value: score,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartAlerts(BuildContext context, List<String> alerts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alerts
          .map((alert) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.lightbulb, color: Colors.blue, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        alert,
                        style: const TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildServiceIntelligenceCard(BuildContext context, String prediction) {
    final isOverdue = prediction.contains('overdue');
    final color = isOverdue ? Colors.red : Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wrench, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              prediction,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsRow(BuildContext context, DashboardData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatBox(context, 'Today', data.todayDistance, ' km', 1),
        _buildStatBox(context, 'Week', data.weeklyDistance, ' km', 1),
        _buildStatBox(context, 'Month', data.monthlyDistance, ' km', 1),
      ],
    );
  }

  Widget _buildStatBox(
    BuildContext context,
    String label,
    num value,
    String suffix,
    int fractionDigits,
  ) {
    return Container(
      width: (MediaQuery.of(context).size.width - 40 - 24) / 3,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedNumber(
            value: value,
            suffix: suffix,
            fractionDigits: fractionDigits,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingReminder(
      BuildContext context, WidgetRef ref, Reminder reminder) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () =>
          ref.read(remindersProvider.notifier).markCompleted(reminder.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.bellRing, color: Colors.orange),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reminder.targetDate != null
                        ? 'Due: ${DateFormat.yMMMd().format(reminder.targetDate!)}'
                        : 'Due at: ${reminder.targetOdometer} km',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.checkCircle,
              color: Colors.orange.withValues(alpha: 0.5),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
