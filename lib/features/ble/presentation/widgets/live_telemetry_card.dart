import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../shared/ui/volt_card.dart';
import '../../domain/vehicle_snapshot.dart';

/// Card widget displaying live telemetry parameters in a structured grid.
class LiveTelemetryCard extends StatelessWidget {
  final VehicleSnapshot snapshot;

  const LiveTelemetryCard({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
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
                    LucideIcons.activity,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Live Telemetry',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Mode: ${snapshot.mode}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildTelemetryTile(
                context,
                icon: LucideIcons.battery,
                label: 'Battery',
                value: '${snapshot.battery}%',
                color: snapshot.battery > 20 ? Colors.green : Colors.red,
              ),
              _buildTelemetryTile(
                context,
                icon: LucideIcons.gauge,
                label: 'Speed',
                value: '${snapshot.speed.toStringAsFixed(1)} km/h',
                color: Colors.blue,
              ),
              _buildTelemetryTile(
                context,
                icon: LucideIcons.navigation,
                label: 'Est. Range',
                value: '${snapshot.range.toStringAsFixed(0)} km',
                color: Colors.teal,
              ),
              _buildTelemetryTile(
                context,
                icon: LucideIcons.zap,
                label: 'Voltage',
                value: '${snapshot.voltage.toStringAsFixed(1)} V',
                color: Colors.amber,
              ),
              _buildTelemetryTile(
                context,
                icon: LucideIcons.cpu,
                label: 'Current',
                value: '${snapshot.current.toStringAsFixed(1)} A',
                color: Colors.purple,
              ),
              _buildTelemetryTile(
                context,
                icon: LucideIcons.thermometer,
                label: 'Temperature',
                value: '${snapshot.temp} °C',
                color: snapshot.temp > 50 ? Colors.orange : Colors.blueGrey,
              ),
            ],
          ),
          if (snapshot.faults.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.alertTriangle,
                      color: Colors.red, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Faults: ${snapshot.faults.join(", ")}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTelemetryTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
