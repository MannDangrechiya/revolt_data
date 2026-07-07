import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../rides/data/rides_provider.dart';
import '../../charging/data/charging_provider.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ridesAsync = ref.watch(ridesProvider);
    final chargingAsync = ref.watch(chargingLogsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Companion', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Revolt RV400 is ready.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildSummaryCard(context, ridesAsync, chargingAsync),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 36, 20, 20),
              child: Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _buildMenuCard(
                  context,
                  title: 'Rides',
                  icon: LucideIcons.bike,
                  color: const Color(0xFF3B82F6), // Modern Blue
                  route: '/rides',
                ),
                _buildMenuCard(
                  context,
                  title: 'Charging',
                  icon: LucideIcons.batteryCharging,
                  color: const Color(0xFF10B981), // Modern Green
                  route: '/charging',
                ),
                _buildMenuCard(
                  context,
                  title: 'Expenses',
                  icon: LucideIcons.wallet,
                  color: const Color(0xFFF59E0B), // Modern Orange
                  route: '/expenses',
                ),
                _buildMenuCard(
                  context,
                  title: 'Maintenance',
                  icon: LucideIcons.wrench,
                  color: const Color(0xFFEF4444), // Modern Red
                  route: '/maintenance',
                ),
                _buildMenuCard(
                  context,
                  title: 'Reminders',
                  icon: LucideIcons.bell,
                  color: const Color(0xFF8B5CF6), // Modern Purple
                  route: '/reminders',
                ),
                _buildMenuCard(
                  context,
                  title: 'Analytics',
                  icon: LucideIcons.barChart3,
                  color: const Color(0xFF14B8A6), // Modern Teal
                  route: '/analytics',
                ),
              ],
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    AsyncValue ridesAsync,
    AsyncValue chargingAsync,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryStat(
              context,
              'Total Rides',
              ridesAsync.maybeWhen(
                data: (rides) => rides.length.toString(),
                orElse: () => '-',
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.white.withValues(alpha: 0.3),
            ),
            _buildSummaryStat(
              context,
              'Total Charges',
              chargingAsync.maybeWhen(
                data: (logs) => logs.length.toString(),
                orElse: () => '-',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(BuildContext context, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: isDark ? 0.05 : 0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
