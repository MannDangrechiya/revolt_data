import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../data/dashboard_provider.dart';
import '../../bikes/data/bike_provider.dart';
import '../../ble/domain/connection_state.dart';
import '../../ble/presentation/widgets/connection_status_badge.dart';
import '../../../core/widgets/animated_number.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/error_retry_widget.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final bikeAsync = ref.watch(currentBikeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EV Companion',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
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
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        LucideIcons.chevronRight,
                                        size: 24,
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
                                ),
                              ),
                              AnimatedNumber(
                                value: data.currentOdometer,
                                suffix: ' km',
                                fractionDigits: 1,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildBatteryStatus(
                        context,
                        battery: data.latestBatteryPercentage,
                        isConnected: isConnected,
                        data: data,
                      ),
                      const SizedBox(height: 24),
                      _buildQuickStatsRow(context, data),

                      if (data.upcomingReminder != null) ...[
                        const SizedBox(height: 24),
                        _buildUpcomingReminder(context, data.upcomingReminder!),
                      ],

                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: 22,
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
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.2,
                  children: [
                    _buildSmallMenuCard(
                      context,
                      title: 'Connect Bike',
                      icon: LucideIcons.bluetooth,
                      color: const Color(0xFF2563EB),
                      route: '/device/scan',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Rides',
                      icon: LucideIcons.bike,
                      color: const Color(0xFF3B82F6),
                      route: '/rides',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Charging',
                      icon: LucideIcons.batteryCharging,
                      color: const Color(0xFF10B981),
                      route: '/charging',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Expenses',
                      icon: LucideIcons.wallet,
                      color: const Color(0xFFF59E0B),
                      route: '/expenses',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Maintenance',
                      icon: LucideIcons.wrench,
                      color: const Color(0xFFEF4444),
                      route: '/maintenance',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Reminders',
                      icon: LucideIcons.bell,
                      color: const Color(0xFF8B5CF6),
                      route: '/reminders',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Documents',
                      icon: LucideIcons.fileText,
                      color: const Color(0xFF6366F1),
                      route: '/documents',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Reports',
                      icon: LucideIcons.fileSpreadsheet,
                      color: const Color(0xFF06B6D4),
                      route: '/reports',
                    ),
                    _buildSmallMenuCard(
                      context,
                      title: 'Statistics',
                      icon: LucideIcons.pieChart,
                      color: const Color(0xFF14B8A6),
                      route: '/statistics',
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBatteryStatus(
    BuildContext context, {
    required int battery,
    required bool isConnected,
    required dynamic data,
  }) {
    final estRange = isConnected && data.liveSnapshot != null
        ? data.liveSnapshot.range.toStringAsFixed(0)
        : (battery * 1.5).toStringAsFixed(0);

    Color batteryColor;
    if (battery > 50) {
      batteryColor = Colors.green;
    } else if (battery > 20) {
      batteryColor = Colors.orange;
    } else {
      batteryColor = Colors.red;
    }

    final borderColor = isConnected
        ? Colors.green
        : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
          width: isConnected ? 2 : 1,
        ),
        boxShadow: isConnected
            ? [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.25),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Battery Status',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isConnected) ...[
                        const SizedBox(width: 6),
                        const Icon(LucideIcons.radio, size: 14, color: Colors.green),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      AnimatedNumber(
                        value: battery,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: batteryColor,
                          height: 1,
                        ),
                      ),
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: batteryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Est. Range',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedNumber(
                    value: double.parse(estRange),
                    suffix: ' km',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isConnected
                  ? '• Live BLE Telemetry Stream'
                  : '• Disconnected (Last updated from log history)',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isConnected ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsRow(BuildContext context, dynamic data) {
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
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
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

  Widget _buildUpcomingReminder(BuildContext context, dynamic reminder) {
    return Container(
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
        ],
      ),
    );
  }

  Widget _buildSmallMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
