import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/theme_provider.dart';
import '../../../shared/ui/volt_app_bar.dart';
import '../../../shared/ui/volt_card.dart';
import '../../bikes/data/bike_provider.dart';
import '../data/data_export_service.dart';
import '../data/data_clear_service.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeProvider);
    final bikeAsync = ref.watch(currentBikeProvider);

    final bikeName = bikeAsync.asData?.value?.name ?? 'Revolt Rider';
    final bikeReg = bikeAsync.asData?.value?.registrationNumber ?? 'RV400';
    final avatarLetter = bikeName.isNotEmpty ? bikeName[0].toUpperCase() : 'R';

    return Scaffold(
      appBar: const VoltAppBar(title: 'Profile & Settings'),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- User Header ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      avatarLetter,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    bikeName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bikeReg,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- My Logs Section ---
          _buildSectionHeader('My Logs'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: VoltCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildNavTile(context, 'Rides', LucideIcons.bike, const Color(0xFF3B82F6), '/rides', isDark),
                    _divider(context),
                    _buildNavTile(context, 'Charging', LucideIcons.batteryCharging, const Color(0xFF10B981), '/charging', isDark),
                    _divider(context),
                    _buildNavTile(context, 'Expenses', LucideIcons.wallet, const Color(0xFFF59E0B), '/expenses', isDark),
                    _divider(context),
                    _buildNavTile(context, 'Maintenance', LucideIcons.wrench, const Color(0xFFEF4444), '/maintenance', isDark),
                    _divider(context),
                    _buildNavTile(context, 'Reminders', LucideIcons.bell, const Color(0xFF8B5CF6), '/reminders', isDark),
                    _divider(context),
                    _buildNavTile(context, 'Documents', LucideIcons.fileText, const Color(0xFF06B6D4), '/documents', isDark),
                  ],
                ),
              ),
            ),
          ),

          // --- Theme Section ---
          _buildSectionHeader('Appearance'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: VoltCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.indigo.withValues(alpha: isDark ? 0.2 : 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(LucideIcons.sun, color: Colors.indigo, size: 22),
                        ),
                        const SizedBox(width: 12),
                        const Text('Theme', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(LucideIcons.smartphone, size: 16)),
                          ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(LucideIcons.sun, size: 16)),
                          ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(LucideIcons.moon, size: 16)),
                        ],
                        selected: {themeMode},
                        onSelectionChanged: (newSelection) {
                          ref.read(themeProvider.notifier).setThemeMode(newSelection.first);
                        },
                        showSelectedIcon: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- Data Management Section ---
          _buildSectionHeader('Data'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: VoltCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal.withValues(alpha: isDark ? 0.2 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _isExporting
                            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(LucideIcons.download, color: Colors.teal, size: 22),
                      ),
                      title: const Text('Export My Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Download all data as JSON'),
                      trailing: const Icon(LucideIcons.chevronRight, size: 20),
                      onTap: _isExporting ? null : _handleExport,
                    ),
                    _divider(context),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: isDark ? 0.2 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(LucideIcons.bike, color: Theme.of(context).colorScheme.primary, size: 22),
                      ),
                      title: const Text('Bike Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Vehicle details & telemetry'),
                      trailing: const Icon(LucideIcons.chevronRight, size: 20),
                      onTap: () => context.push('/bike'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- About Section ---
          _buildSectionHeader('About'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: VoltCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        final version = snapshot.hasData
                            ? 'v${snapshot.data!.version}+${snapshot.data!.buildNumber}'
                            : 'Loading...';
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(LucideIcons.zap, color: Theme.of(context).colorScheme.onPrimaryContainer, size: 22),
                          ),
                          title: const Text('Revolt Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          subtitle: Text(version),
                        );
                      },
                    ),
                    _divider(context),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: isDark ? 0.2 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(LucideIcons.user, color: Colors.grey, size: 22),
                      ),
                      title: const Text('Developer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      subtitle: const Text('Built by Mann Dipakbhai Dangrechiya'),
                    ),
                    _divider(context),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: isDark ? 0.2 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(LucideIcons.folderGit2, color: Colors.grey, size: 22),
                      ),
                      title: const Text('GitHub', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      subtitle: const Text('MannDangrechiya/revolt_data'),
                      trailing: const Icon(LucideIcons.externalLink, size: 18),
                      onTap: () => _launchUrl('https://github.com/MannDangrechiya/revolt_data'),
                    ),
                    _divider(context),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: isDark ? 0.2 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(LucideIcons.mail, color: Colors.grey, size: 22),
                      ),
                      title: const Text('Support', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      subtitle: const Text('mann@revolt.dev'),
                      trailing: const Icon(LucideIcons.externalLink, size: 18),
                      onTap: () => _launchUrl('mailto:mann@revolt.dev'),
                    ),
                    _divider(context),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: isDark ? 0.2 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(LucideIcons.scale, color: Colors.grey, size: 22),
                      ),
                      title: const Text('Open Source Licenses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      trailing: const Icon(LucideIcons.chevronRight, size: 20),
                      onTap: () => showLicensePage(
                        context: context,
                        applicationName: 'Revolt Data',
                        applicationVersion: '2.1.0',
                        applicationLegalese: '© 2026 Mann Dipakbhai Dangrechiya\nrevolt_ble_sdk (MIT)',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- Danger Zone ---
          _buildSectionHeader('Danger Zone'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: VoltCard(
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: isDark ? 0.2 : 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.trash2, color: Colors.red, size: 22),
                  ),
                  title: const Text('Clear All Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red)),
                  subtitle: const Text('Deletes rides, charges, expenses, maintenance, reminders, and documents'),
                  trailing: const Icon(LucideIcons.chevronRight, size: 20, color: Colors.red),
                  onTap: _showClearDataDialog,
                ),
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  // --- Helpers ---

  Widget _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: title == 'Danger Zone' ? Colors.red : null,
          ),
        ),
      ),
    );
  }

  Widget _buildNavTile(BuildContext context, String title, IconData icon, Color color, String route, bool isDark) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isDark ? 0.2 : 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      trailing: const Icon(LucideIcons.chevronRight, size: 20),
      onTap: () {
        if (route == '/rides' || route == '/charging' || route == '/analytics' || route == '/') {
          context.go(route);
        } else {
          context.push(route);
        }
      },
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
    );
  }

  Future<void> _handleExport() async {
    setState(() => _isExporting = true);
    try {
      final filePath = await ref.read(exportAllDataProvider.future);
      if (mounted) {
        await SharePlus.instance.share(ShareParams(
          files: [XFile(filePath)],
          text: 'Revolt Data Export',
        ));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data exported successfully!'), backgroundColor: Colors.green),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will permanently delete all rides, charge logs, expenses, maintenance logs, reminders, and documents.\n\nYour bike profile and preferences will be kept.\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                await ref.read(clearAllDataProvider.future);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All data cleared successfully'), backgroundColor: Colors.green),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to clear data: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
            child: const Text('Delete Everything'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open link: $urlString')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
        );
      }
    }
  }
}
