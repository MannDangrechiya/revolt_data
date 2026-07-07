import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../domain/ride.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onFavoriteToggle;

  const RideCard({
    super.key,
    required this.ride,
    this.onTap,
    this.onLongPress,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: ride.isFavorite ? BorderSide(color: Colors.amber.withOpacity(0.5), width: 2) : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
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
                      Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMM d, yyyy - h:mm a').format(ride.date),
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (onFavoriteToggle != null)
                        InkWell(
                          onTap: onFavoriteToggle,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              ride.isFavorite ? Icons.star : Icons.star_border,
                              color: ride.isFavorite ? Colors.amber : Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      _buildModeBadge(context, ride.rideMode),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric(
                    context,
                    icon: Icons.route,
                    label: 'Distance',
                    value: '${ride.distance.toStringAsFixed(1)} km',
                  ),
                  _buildMetric(
                    context,
                    icon: Icons.battery_charging_full,
                    label: 'Battery',
                    value: '${ride.batteryConsumed}%',
                  ),
                  _buildMetric(
                    context,
                    icon: Icons.speed,
                    label: 'Condition',
                    value: ride.roadCondition.name.toUpperCase(),
                  ),
                ],
              ),
              if (ride.startLocation != null || ride.endLocation != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${ride.startLocation ?? 'Unknown'} → ${ride.endLocation ?? 'Unknown'}',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              if (ride.customTags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: ride.customTags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '#$tag',
                      style: TextStyle(fontSize: 10, color: colorScheme.onSecondaryContainer),
                    ),
                  )).toList(),
                ),
              ],
              if (ride.notes != null && ride.notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Divider(),
                Text(
                  ride.notes!,
                  style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeBadge(BuildContext context, RideMode mode) {
    Color badgeColor;
    switch (mode) {
      case RideMode.eco:
        badgeColor = Colors.green;
        break;
      case RideMode.normal:
        badgeColor = Colors.blue;
        break;
      case RideMode.sport:
        badgeColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withOpacity(0.5)),
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
