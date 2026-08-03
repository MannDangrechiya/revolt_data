import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../data/dashboard_provider.dart';
import '../domain/dashboard_data.dart';
import '../../bikes/data/bike_provider.dart';
import '../../ble/domain/connection_state.dart';
import '../../ble/presentation/widgets/connection_status_badge.dart';
import '../../../shared/ui/volt_app_bar.dart';
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
                      _buildBatteryStatusCard(
                        context,
                        ref: ref,
                        data: data,
                        isConnected: isConnected,
                      ),
                      if (data.liveSnapshot != null &&
                          data.liveSnapshot!.faultCodes.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _buildFaultAlertCard(
                            context, data.liveSnapshot!.faultCodes),
                      ],
                      const SizedBox(height: 20),
                      _buildQuickStatsRow(context, data),

                      if (data.upcomingReminder != null) ...[
                        const SizedBox(height: 20),
                        _buildUpcomingReminder(context, data.upcomingReminder!),
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
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
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

  Widget _buildBatteryStatusCard(
    BuildContext context, {
    required WidgetRef ref,
    required DashboardData data,
    required bool isConnected,
  }) {
    final liveSnapshot = data.liveSnapshot;

    final batteryPercent = isConnected && liveSnapshot != null
        ? liveSnapshot.batteryPercent
        : data.latestBatteryPercentage;

    // Direct telemetry range when connected; manual log calculation without multiplier when disconnected.
    final rangeValue = isConnected && liveSnapshot != null
        ? liveSnapshot.range
        : batteryPercent.toDouble();

    final speedValue = isConnected && liveSnapshot != null
        ? liveSnapshot.speed
        : 0.0;

    Color batteryColor;
    if (batteryPercent > 50) {
      batteryColor = Colors.green;
    } else if (batteryPercent > 20) {
      batteryColor = Colors.orange;
    } else {
      batteryColor = Colors.red;
    }

    final borderColor = isConnected
        ? Colors.green
        : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2);

    final healthValue = liveSnapshot?.batteryHealth;
    final healthText = healthValue != null && healthValue > 0
        ? '$healthValue%'
        : (isConnected ? 'N/A' : 'Connect for health');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.5),
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
                  blurRadius: 14,
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
              Row(
                children: [
                  Text(
                    'Battery & Range',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isConnected
                        ? Container(
                            key: const ValueKey('live_chip'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.radio,
                                    size: 10, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'LIVE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            key: const ValueKey('est_chip'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'ESTIMATED',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              if (isConnected && liveSnapshot != null)
                Text(
                  'Mode: ${liveSnapshot.rideMode}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      AnimatedNumber(
                        value: batteryPercent,
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: batteryColor,
                          height: 1,
                        ),
                      ),
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: batteryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Battery Charge',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              if (isConnected)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedNumber(
                      value: speedValue,
                      suffix: ' km/h',
                      fractionDigits: 1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Live Speed',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedNumber(
                    value: rangeValue,
                    suffix: ' km',
                    fractionDigits: 0,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Est. Range',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          if (isConnected && liveSnapshot != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Batt: ${liveSnapshot.batteryTemp}°C  •  Motor: ${liveSnapshot.motorTemp}°C',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Health: $healthText',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Align(
              key: ValueKey(isConnected),
              alignment: Alignment.centerLeft,
              child: Text(
                isConnected
                    ? '• Connected to RV400 via BLE Telemetry Stream'
                    : '• Disconnected — Last updated from manual log history',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isConnected ? Colors.green : Colors.grey,
                ),
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
            color: Theme.of(context)
                .colorScheme
                .outlineVariant
                .withValues(alpha: 0.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
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
