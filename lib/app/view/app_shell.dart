import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/utils/responsive.dart';
import '../../shared/ui/volt_fab.dart';
import '../../shared/ui/offline_banner.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopOrTablet = context.isTablet || context.isDesktop;

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: Row(
              children: [
                if (isDesktopOrTablet)
                  NavigationRail(
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: _onTap,
                    labelType: NavigationRailLabelType.all,
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                      child: FloatingActionButton(
                        onPressed: () => showVoltQuickActionsMenu(context),
                        child: const Icon(LucideIcons.plus),
                      ),
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(LucideIcons.layoutDashboard),
                        label: Text('Dashboard'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(LucideIcons.bike),
                        label: Text('Rides'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(LucideIcons.zap),
                        label: Text('Charging'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(LucideIcons.barChart2),
                        label: Text('Analytics'),
                      ),
                    ],
                  ),
                if (isDesktopOrTablet) const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: navigationShell),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktopOrTablet
          ? null
          : NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onTap,
              destinations: const [
                NavigationDestination(
                  icon: Icon(LucideIcons.layoutDashboard),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(LucideIcons.bike),
                  label: 'Rides',
                ),
                NavigationDestination(
                  icon: Icon(LucideIcons.zap),
                  label: 'Charging',
                ),
                NavigationDestination(
                  icon: Icon(LucideIcons.barChart2),
                  label: 'Analytics',
                ),
              ],
            ),
      floatingActionButton: isDesktopOrTablet ? null : _buildFab(context),
    );
  }

  /// The Add button is context-aware: inside a section it jumps straight to that
  /// section's entry form; on the Dashboard it opens the global quick-actions menu.
  Widget? _buildFab(BuildContext context) {
    switch (navigationShell.currentIndex) {
      case 1: // Rides
        return VoltFloatingActionButton(
          onPressed: () => context.push('/rides/add'),
        );
      case 2: // Charging
        return VoltFloatingActionButton(
          onPressed: () => context.push('/charging/add'),
        );
      case 3: // Analytics — no create action
        return null;
      default: // Dashboard
        return VoltFloatingActionButton(
          onPressed: () => showVoltQuickActionsMenu(context),
        );
    }
  }
}
