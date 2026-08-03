import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/ui/volt_card.dart';
import '../../domain/ble_charge_state.dart';

class ChargingStatusCard extends StatelessWidget {
  final BleChargeState chargeState;

  const ChargingStatusCard({
    super.key,
    required this.chargeState,
  });

  String _formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (chargeState.status == BleChargeStatus.idle) {
      return const SizedBox.shrink();
    }

    final isCharging = chargeState.status == BleChargeStatus.charging;

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
                    isCharging ? LucideIcons.batteryCharging : LucideIcons.checkCircle2,
                    color: isCharging ? Colors.amber.shade700 : Colors.teal,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isCharging ? 'Live BLE Charging' : 'Charge Log Auto-Saved',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isCharging ? Colors.amber.shade800 : Colors.teal,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCharging
                      ? Colors.amber.withValues(alpha: 0.15)
                      : Colors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isCharging ? 'CHARGING' : 'SAVED TO LOGBOOK',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isCharging ? Colors.amber.shade800 : Colors.teal,
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
                label: 'Gained',
                value: '+${chargeState.batteryGained}%',
                icon: LucideIcons.battery,
              ),
              _MetricItem(
                label: 'Energy',
                value: '${chargeState.kwhAdded.toStringAsFixed(2)} kWh',
                icon: LucideIcons.zap,
              ),
              _MetricItem(
                label: 'Duration',
                value: _formatDuration(chargeState.durationSeconds),
                icon: LucideIcons.clock,
              ),
              _MetricItem(
                label: 'Peak Temp',
                value: '${chargeState.peakBatteryTemp}°C',
                icon: LucideIcons.thermometer,
              ),
            ],
          ),
          if (!isCharging && chargeState.lastSavedChargeLog != null) ...[
            const SizedBox(height: 12),
            Text(
              'Entry added to Charge Logs table (Source: BLE)',
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
