import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../data/dashboard_provider.dart';
import '../../bikes/data/bike_provider.dart';
import '../domain/dashboard_data.dart';
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
                                const Text(
                                  'Welcome back!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () => context.push('/bike'),
                                  child: Row(
                                    children: [
                                      Text(
                                        bikeName,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        LucideIcons.chevronRight,
                                        size: 28,
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
                        data.latestBatteryPercentage,
                        data.currentOdometer,
                      ),
                      const SizedBox(height: 24),
                      _buildQuickStatsRow(context, data),

                      if (data.upcomingReminder != null) ...[
                        const SizedBox(height: 24),
                        _buildUpcomingReminder(context, data.upcomingReminder!),
                      ],

                      const SizedBox(height: 32),
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Weekly Progress',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildChart(context, data),
                      const SizedBox(height: 32),
                      const Text(
                        'Lifetime Impact',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildImpactCards(context, data),
                      const SizedBox(height: 32),
                      if (data.recentActivities.isNotEmpty) ...[
                        const Text(
                          'Recent Activities',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildRecentActivities(context, data.recentActivities),
                      ],
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBatteryStatus(BuildContext context, int battery, double odo) {
    // Basic range estimation: RV400 approx 1.5 km per 1% battery on average
    final estRange = (battery * 1.5).toStringAsFixed(0);

    Color batteryColor;
    if (battery > 50) {
      batteryColor = Colors.green;
    } else if (battery > 20) {
      batteryColor = Colors.orange;
    } else {
      batteryColor = Colors.red;
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Battery Status',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
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
      width:
          (MediaQuery.of(context).size.width - 40 - 24) /
          3, // 40 padding, 24 space between
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.4),
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
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
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
          IconButton(
            icon: const Icon(LucideIcons.checkCircle),
            onPressed: () {
              // mark as done
            },
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
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withOpacity(0.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context, DashboardData data) {
    // Fake data for the chart since we don't have daily breakdown easily available right now
    // In a real app, the provider should supply a List of daily distances.
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.4),
        ),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100, // Hardcoded max for demo
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const titles = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  if (value.toInt() >= 0 && value.toInt() < titles.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        titles[value.toInt()],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            for (int i = 0; i < 7; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: i == 6
                        ? data.todayDistance
                        : (10.0 + (i * 5) % 30), // Fake past days, actual today
                    color: Theme.of(context).colorScheme.primary,
                    width: 16,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 100,
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactCards(BuildContext context, DashboardData data) {
    return Row(
      children: [
        Expanded(
          child: _buildImpactCard(
            context,
            'Petrol Saved',
            data.petrolSaved,
            ' L',
            '₹${(data.petrolSaved * 100).toStringAsFixed(0)}', // Approx ₹100/L
            LucideIcons.fuel,
            Colors.orange,
            1,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildImpactCard(
            context,
            'CO₂ Prevented',
            data.co2Saved,
            ' kg',
            'Trees saved',
            LucideIcons.leaf,
            Colors.green,
            1,
          ),
        ),
      ],
    );
  }

  Widget _buildImpactCard(
    BuildContext context,
    String title,
    num value,
    String suffix,
    String subtitle,
    IconData icon,
    Color color,
    int fractionDigits,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedNumber(
            value: value,
            prefix: title == 'Petrol Saved' ? '~' : null,
            suffix: suffix,
            fractionDigits: fractionDigits,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities(
    BuildContext context,
    List<RecentActivity> activities,
  ) {
    return Column(
      children: activities.map((activity) {
        IconData icon;
        Color color;
        if (activity.type == ActivityType.ride) {
          icon = LucideIcons.bike;
          color = Colors.blue;
        } else if (activity.type == ActivityType.charge) {
          icon = LucideIcons.batteryCharging;
          color = Colors.green;
        } else if (activity.type == ActivityType.maintenance) {
          icon = LucideIcons.wrench;
          color = Colors.red;
        } else {
          icon = LucideIcons.wallet;
          color = Colors.orange;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withOpacity(0.4),
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            title: Text(
              activity.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(activity.subtitle),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  activity.type == ActivityType.ride
                      ? '+${activity.value.toStringAsFixed(1)} km'
                      : '₹${activity.value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  DateFormat.MMMd().format(activity.date),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
