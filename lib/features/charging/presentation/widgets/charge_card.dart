import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../domain/charge_log.dart';

class ChargeCard extends StatelessWidget {
  final ChargeLog log;
  final VoidCallback? onTap;

  const ChargeCard({super.key, required this.log, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMM d, yyyy').format(log.date),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  _buildLocationBadge(context, log.locationType),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric(
                    context,
                    icon: LucideIcons.zap,
                    label: 'Energy',
                    value: '${log.kwhAdded.toStringAsFixed(1)} kWh',
                  ),
                  _buildMetric(
                    context,
                    icon: LucideIcons.batteryCharging,
                    label: 'Battery',
                    value: '${log.startBattery}% → ${log.endBattery}%',
                  ),
                  _buildMetric(
                    context,
                    icon: LucideIcons.banknote,
                    label: 'Cost',
                    value: '₹${log.cost.toStringAsFixed(0)}',
                  ),
                ],
              ),
              if (log.locationName != null || log.chargerType != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${log.locationName ?? 'Unknown location'} ${log.chargerType != null ? '(${log.chargerType})' : ''}',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationBadge(BuildContext context, LocationType mode) {
    Color badgeColor;
    switch (mode) {
      case LocationType.home:
        badgeColor = Colors.green;
        break;
      case LocationType.work:
        badgeColor = Colors.blue;
        break;
      case LocationType.public:
        badgeColor = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        mode.name.toUpperCase(),
        style: TextStyle(
          color: badgeColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMetric(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(icon, color: colorScheme.secondary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
