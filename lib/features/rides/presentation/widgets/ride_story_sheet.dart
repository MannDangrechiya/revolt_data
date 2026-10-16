import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/ride.dart';

/// Modal bottom sheet showcasing a visually styled "Ride Story" summary
/// for the Revolt RV400, computing petrol savings, carbon offsets, and
/// allowing one-tap social sharing or clipboard copying.
class RideStorySheet extends StatelessWidget {
  final Ride ride;

  const RideStorySheet({super.key, required this.ride});

  /// Computes energy consumed in kWh based on the RV400 3.24 kWh pack capacity.
  double get kwhUsed {
    final percent = ride.batteryConsumed.clamp(0, 100);
    return (percent / 100.0) * 3.24;
  }

  /// Estimates money saved in ₹ comparing EV charging cost against a 40 km/L petrol bike at ₹105/L.
  double get petrolSavingsInr {
    final distance = ride.distance.clamp(0.0, 500.0);
    final litresSaved = distance / 40.0;
    final petrolCost = litresSaved * 105.0;
    final evCost = kwhUsed * 8.0; // ₹8 per kWh standard residential AC tariff
    final netSavings = petrolCost - evCost;
    return netSavings > 0 ? netSavings : 0.0;
  }

  /// Calculates carbon CO2 prevented in kilograms (ICE bikes emit ~120g CO2 per km).
  double get co2OffsetKg {
    return (ride.distance.clamp(0.0, 500.0) * 0.12);
  }

  /// Generates the formatted text payload for sharing.
  String generateShareText() {
    final dateStr = DateFormat('EEE, d MMM yyyy').format(ride.date);
    final topSpeedStr = ride.maxSpeed != null ? '${ride.maxSpeed!.toStringAsFixed(0)} km/h' : 'N/A';
    final avgSpeedStr = ride.averageSpeed != null ? '${ride.averageSpeed!.toStringAsFixed(0)} km/h' : 'N/A';

    return '''⚡ My Revolt RV400 Ride Summary 🏍️
📅 $dateStr | Mode: ${ride.rideMode.name.toUpperCase()}
📍 Distance: ${ride.distance.toStringAsFixed(1)} km
⏱️ Duration: ${ride.durationMinutes ?? 0} mins
🚀 Speed: Top $topSpeedStr | Avg $avgSpeedStr
🔋 Battery Used: ${ride.batteryConsumed}% (~${kwhUsed.toStringAsFixed(2)} kWh)
💰 Money Saved: ₹${petrolSavingsInr.toStringAsFixed(0)} vs petrol bike
🌿 Green Footprint: ${co2OffsetKg.toStringAsFixed(2)} kg CO₂ avoided!
#RevoltMotors #RV400 #ElectricMotorcycle #CleanRide''';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Story Card Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                    : [const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag & Mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.zap, size: 16, color: Colors.amber),
                        const SizedBox(width: 6),
                        Text(
                          'REVOLT RV400',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getModeColor(ride.rideMode).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _getModeColor(ride.rideMode)),
                      ),
                      child: Text(
                        ride.rideMode.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _getModeColor(ride.rideMode),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Hero Distance
                Text(
                  '${ride.distance.toStringAsFixed(1)} KM',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(ride.date),
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 18),

                const Divider(height: 1),
                const SizedBox(height: 16),

                // 2x2 Key Highlights Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildStoryMetric(
                        context,
                        icon: LucideIcons.batteryMedium,
                        iconColor: Colors.blueAccent,
                        label: 'Battery & Pack',
                        value: '${ride.batteryConsumed}%',
                        sub: '~${kwhUsed.toStringAsFixed(2)} kWh used',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStoryMetric(
                        context,
                        icon: LucideIcons.gauge,
                        iconColor: Colors.orangeAccent,
                        label: 'Speed Stats',
                        value: '${ride.maxSpeed?.toStringAsFixed(0) ?? '--'} km/h',
                        sub: 'Avg ${ride.averageSpeed?.toStringAsFixed(0) ?? '--'} km/h',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStoryMetric(
                        context,
                        icon: LucideIcons.indianRupee,
                        iconColor: Colors.green,
                        label: 'Petrol Savings',
                        value: '₹${petrolSavingsInr.toStringAsFixed(0)}',
                        sub: 'vs ₹105/L ICE bike',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStoryMetric(
                        context,
                        icon: LucideIcons.leaf,
                        iconColor: const Color(0xFF10B981),
                        label: 'CO₂ Prevented',
                        value: '${co2OffsetKg.toStringAsFixed(2)} kg',
                        sub: 'Clean zero emissions',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Action Buttons: Share & Copy
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: generateShareText()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ride summary copied to clipboard!'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(LucideIcons.copy, size: 16),
                  label: const Text('Copy Text'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: () async {
                    await SharePlus.instance.share(
                      ShareParams(
                        text: generateShareText(),
                        subject: 'My Revolt RV400 Ride Summary',
                      ),
                    );
                  },
                  icon: const Icon(LucideIcons.share2, size: 16),
                  label: const Text('Share My Ride'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getModeColor(RideMode mode) {
    switch (mode) {
      case RideMode.eco:
        return const Color(0xFF10B981);
      case RideMode.normal:
        return const Color(0xFF3B82F6);
      case RideMode.sport:
        return const Color(0xFFEF4444);
    }
  }

  Widget _buildStoryMetric(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String sub,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            sub,
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
