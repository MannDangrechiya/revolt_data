import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/widgets/fade_slide_in.dart';

class _QuickAction {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const _QuickAction(this.title, this.icon, this.color, this.route);
}

const _quickActions = [
  _QuickAction('Riding Cockpit', LucideIcons.gauge, Color(0xFFF97316), '/cockpit'),
  _QuickAction('Battery Longevity', LucideIcons.batteryFull, Color(0xFF10B981), '/battery-health'),
  _QuickAction('RV400 Care Guide', LucideIcons.bookOpen, Color(0xFF0EA5E9), '/maintenance/care-guide'),
  _QuickAction('Range Planner', LucideIcons.route, Color(0xFF2563EB), '/range-planner'),
  _QuickAction('15A Charging', LucideIcons.plugZap, Color(0xFF059669), '/home-charging'),
  _QuickAction('Security Shield', LucideIcons.shieldCheck, Color(0xFF0D9488), '/security'),
  _QuickAction('Battery & BMS', LucideIcons.heartPulse, Color(0xFF10B981), '/battery-diagnostics'),
  _QuickAction('Bike Diagnostics', LucideIcons.stethoscope, Color(0xFF0284C7), '/diagnostics-scan'),
  _QuickAction('Sound Studio', LucideIcons.volume2, Color(0xFFE11D48), '/sound-studio'),
  _QuickAction('Device Hub', LucideIcons.cpu, Color(0xFF8B5CF6), '/device-hub'),
  _QuickAction('Connect Bike', LucideIcons.bluetooth, Color(0xFF3B82F6), '/device/scan'),
  _QuickAction('Rides', LucideIcons.bike, Color(0xFF2563EB), '/rides'),
  _QuickAction('Charging', LucideIcons.batteryCharging, Color(0xFF10B981), '/charging'),
  _QuickAction('Expenses', LucideIcons.wallet, Color(0xFFF59E0B), '/expenses'),
  _QuickAction('Maintenance', LucideIcons.wrench, Color(0xFFEF4444), '/maintenance'),
  _QuickAction('Reminders', LucideIcons.bell, Color(0xFF8B5CF6), '/reminders'),
  _QuickAction('Documents', LucideIcons.fileText, Color(0xFF6366F1), '/documents'),
  _QuickAction('Reports', LucideIcons.fileSpreadsheet, Color(0xFF06B6D4), '/reports'),
  _QuickAction('Statistics', LucideIcons.pieChart, Color(0xFF14B8A6), '/statistics'),
];

/// The dashboard's quick-actions grid. Returns a sliver directly so it can
/// be dropped straight into a CustomScrollView's `slivers:` list.
class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 2.2,
        children: [
          for (var i = 0; i < _quickActions.length; i++)
            FadeSlideIn(
              index: i,
              child: _buildMenuCard(context, _quickActions[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, _QuickAction action) {
    return InkWell(
      onTap: () {
        if (action.route == '/rides' || action.route == '/charging' || action.route == '/analytics' || action.route == '/') {
          context.go(action.route);
        } else {
          context.push(action.route);
        }
      },
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
              Icon(action.icon, color: action.color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  action.title,
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
