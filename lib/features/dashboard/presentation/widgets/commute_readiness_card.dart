import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Interactive commute reachability assistant for primary daily route:
/// Vastral ↔ Kudasan (55 km round-trip via SP Ring Road).
/// Evaluates live SOC, projects return percentage, recommends riding mode,
/// and computes daily electricity vs petrol financial savings.
class CommuteReadinessCard extends StatelessWidget {
  final int currentSoc;

  const CommuteReadinessCard({
    super.key,
    required this.currentSoc,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Status evaluation based on 55 km round-trip @ ~1.0% SOC per km in Mode 2
    final bool isReady = currentSoc >= 75;
    final bool isMarginal = currentSoc >= 60 && currentSoc < 75;
    final bool needsCharge = currentSoc < 60;

    final Color statusColor = isReady
        ? const Color(0xFF10B981) // Emerald Green
        : (isMarginal
            ? const Color(0xFFF59E0B) // Amber Orange
            : const Color(0xFFEF4444)); // Crimson Red

    final String statusTitle = isReady
        ? 'Commute Ready'
        : (isMarginal ? 'Marginal Buffer' : 'Charge Needed');

    final String statusSubtitle = isReady
        ? 'Full 55 km round-trip feasible. Estimated return battery ~${(currentSoc - 55).clamp(5, 40)}% SOC.'
        : (isMarginal
            ? 'Tight buffer (~${(currentSoc - 55).clamp(1, 15)}% return). Cruise in Mode 1 (Eco) on SP Ring Road.'
            : 'Insufficient range for 55 km round-trip (~56% SOC needed). Top up via 15A socket before leaving.');

    final String recommendedMode = isReady
        ? 'Mode 2 (Normal)'
        : (isMarginal ? 'Mode 1 (Eco on Ring Rd)' : 'Charge Prior to Departure');

    final int returnBatteryPercent = (currentSoc - 56).clamp(0, 100);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Route & Status Badge
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(LucideIcons.route, color: statusColor, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vastral ↔ Kudasan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              '55 km Daily • SP Ring Rd',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        statusTitle,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Advice banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isReady ? LucideIcons.shieldCheck : LucideIcons.alertTriangle,
                    color: statusColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      statusSubtitle,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.35,
                        color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Metrics Grid
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    label: 'RETURN BATTERY',
                    value: '$returnBatteryPercent%',
                    sub: 'At 7:30 PM arrival',
                    icon: LucideIcons.batteryCharging,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(
                    label: 'RECOMMENDED',
                    value: recommendedMode.contains('Mode 1') ? 'Mode 1 Eco' : 'Mode 2 Norm',
                    sub: 'Cruise speed: 45 km/h',
                    icon: LucideIcons.gauge,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(
                    label: 'DAILY SAVINGS',
                    value: '₹93.00',
                    sub: 'vs ₹105 ICE petrol',
                    icon: LucideIcons.trendingUp,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => context.push('/cockpit'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.gauge, size: 14),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Cockpit HUD',
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: needsCharge ? Colors.redAccent : const Color(0xFF0F766E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => context.push('/home-charging'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.zap, size: 14),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            needsCharge ? 'Top Up 15A' : '15A Night Coach',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required String sub,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 8.5,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
