import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Comprehensive Revolt RV400 owner mechanical care guide covering
/// carbon belt tensioning, tyre pressure matrices, CBS braking,
/// 12V auxiliary battery health, and MCB breaker safety rules.
class Rv400CareGuideScreen extends StatelessWidget {
  const Rv400CareGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('RV400 Care Guide'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Hero Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
                    : [const Color(0xFFF8FAFC), const Color(0xFFE2E8F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.wrench,
                    size: 28,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revolt RV400 Care Guide',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Essential preventive maintenance for maximum belt life, tyre range, and battery health.',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 1. Carbon Belt Drive Section
          _buildCareCard(
            context,
            icon: LucideIcons.circleDot,
            iconColor: Colors.deepOrange,
            title: '1. Carbon Belt Drive Care',
            subtitle: 'Gates / Continental high-tensile cogged belt',
            badgeText: 'Inspect Every 5,000 km',
            badgeColor: Colors.deepOrange,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBullet(
                  'Tension Check: Optimal belt deflection is 5 to 8 mm at the midpoint under approximately 4.5 kg finger load.',
                ),
                _buildBullet(
                  'Zero Lubrication: NEVER use chain lube, grease, engine oil, or WD-40. Petroleum solvents dissolve the belt\'s polyurethane matrix and destroy tensile fibers.',
                ),
                _buildBullet(
                  'Cleaning: Wash only with cold water and a soft nylon brush to dislodge road dust and mud grit.',
                ),
                _buildBullet(
                  'Symptom Guide: Squeaking under hard acceleration indicates a loose belt or pulley misalignment. Skipping teeth can damage the rear cogged sprocket.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. Tyre Pressure & Range Matrix Section
          _buildCareCard(
            context,
            icon: LucideIcons.gauge,
            iconColor: Colors.blueAccent,
            title: '2. Tyre Pressure (PSI) Guide',
            subtitle: 'Recommended cold inflation pressures',
            badgeText: 'Check Weekly',
            badgeColor: Colors.blueAccent,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Wheel Position', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Solo Rider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('With Pillion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                      Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Front (90/80-17)', style: TextStyle(fontSize: 13)),
                          Text('28 - 30 PSI', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('30 PSI', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rear (120/80-17)', style: TextStyle(fontSize: 13)),
                          Text('32 PSI', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('34 - 36 PSI', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildAlertBox(
                  context,
                  icon: LucideIcons.alertTriangle,
                  color: Colors.amber,
                  text: 'EV Range Warning: Rolling friction from under-inflated tyres (e.g. 24 PSI) can reduce RV400 real-world range by up to 18%!',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Combined Braking System (CBS) & Regenerative Braking
          _buildCareCard(
            context,
            icon: LucideIcons.disc,
            iconColor: Colors.purpleAccent,
            title: '3. CBS Brakes & Regen',
            subtitle: 'Dual 240mm hydraulic disc brakes',
            badgeText: 'Inspect Every 3,000 km',
            badgeColor: Colors.purpleAccent,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBullet(
                  'CBS Mechanism: Squeezing the left handlebar brake lever engages the rear caliper and simultaneously actuates the center piston of the front brake caliper.',
                ),
                _buildBullet(
                  'Pad Wear Limit: Inspect brake pads every 3,000 km. Replace pads immediately if friction material wears below 1.5 mm.',
                ),
                _buildBullet(
                  'Hydraulic Fluid: Inspect DOT 3 or DOT 4 brake fluid level in both master cylinder reservoirs. Flush and replace fluid every 10,000 km or 1 year.',
                ),
                _buildBullet(
                  'Regenerative Braking: Mild regenerative braking engages automatically when rolling the throttle closed or gently resting hands on brake levers.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 4. 12V Auxiliary Battery Maintenance
          _buildCareCard(
            context,
            icon: LucideIcons.batteryCharging,
            iconColor: Colors.green,
            title: '4. 12V Auxiliary Battery Care',
            subtitle: 'Powers ECU, 4G IoT SIM, lights & console',
            badgeText: 'Critical Tip',
            badgeColor: Colors.green,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBullet(
                  'Auxiliary Drain: The 12V 4Ah battery powers the cellular IoT telematics unit continuously even when the bike is parked.',
                ),
                _buildBullet(
                  'Idle Parking Risk: If the bike sits unridden for > 14 days, the 12V battery can discharge, preventing the bike from powering on even if the 72V main battery is at 100%.',
                ),
                _buildBullet(
                  'Prevention: Ride the bike at least once a week for 20 minutes, or flip the MCB switch OFF if away for more than 7 days.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 5. MCB Switch & Long-Term Storage
          _buildCareCard(
            context,
            icon: LucideIcons.shieldAlert,
            iconColor: Colors.teal,
            title: '5. MCB Switch & Storage Rules',
            subtitle: 'Main Circuit Breaker under tank lid',
            badgeText: 'Safety First',
            badgeColor: Colors.teal,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBullet(
                  'Location: The yellow/blue MCB switch is located under the faux fuel tank storage lid near the charging port.',
                ),
                _buildBullet(
                  'Water Washing: Always flip the MCB switch OFF before pressure washing or deep cleaning the motorcycle.',
                ),
                _buildBullet(
                  'Storage SOC: If storing the motorcycle for more than 10 days, leave the main battery at 50% to 60% SOC and switch the MCB OFF.',
                ),
                _buildAlertBox(
                  context,
                  icon: LucideIcons.info,
                  color: Colors.blue,
                  text: 'Never store the 72V battery at 0% or 100% in hot Indian summers. 50-60% preserves lithium cell chemistry longevity.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCareCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required Widget content,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 6, color: Colors.grey),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBox(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
