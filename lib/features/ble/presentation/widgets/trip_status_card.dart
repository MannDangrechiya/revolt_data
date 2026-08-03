import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/ui/volt_card.dart';
import '../../domain/ble_trip_state.dart';

class TripStatusCard extends StatelessWidget {
  final BleTripState tripState;

  const TripStatusCard({
    super.key,
    required this.tripState,
  });

  String _formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (tripState.status == BleTripStatus.idle) {
      return const SizedBox.shrink();
    }

    final isRiding = tripState.status == BleTripStatus.riding;

    return VoltCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isRiding ? LucideIcons.navigation : LucideIcons.checkCircle2,
                    color: isRiding ? Colors.green : Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isRiding ? 'Live BLE Trip Tracking' : 'Trip Auto-Saved',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isRiding ? Colors.green : Colors.blue,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isRiding
                      ? Colors.green.withValues(alpha: 0.15)
                      : Colors.blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isRiding ? 'RIDING' : 'SAVED TO LOGBOOK',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isRiding ? Colors.green : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MetricItem(
                label: 'Distance',
                value: '${tripState.distance.toStringAsFixed(1)} km',
                icon: LucideIcons.mapPin,
              ),
              _MetricItem(
                label: 'Duration',
                value: _formatDuration(tripState.durationSeconds),
                icon: LucideIcons.clock,
              ),
              _MetricItem(
                label: isRiding ? 'Speed' : 'Avg Speed',
                value: isRiding
                    ? '${tripState.currentSpeed.toStringAsFixed(0)} km/h'
                    : '${tripState.averageSpeed.toStringAsFixed(0)} km/h',
                icon: LucideIcons.gauge,
              ),
              _MetricItem(
                label: 'Battery Drop',
                value: '${tripState.startBattery - tripState.currentBattery}%',
                icon: LucideIcons.batteryCharging,
              ),
            ],
          ),
          if (!isRiding && tripState.lastSavedRide != null) ...[
            const SizedBox(height: 12),
            Text(
              'Entry added to Rides table (Source: BLE)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MetricItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade700),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
