import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/ui/volt_card.dart';
import '../../domain/ble_device_info.dart';

/// Card tile rendering a discovered BLE device result using VoltCard.
class ScanResultTile extends StatelessWidget {
  final BleDeviceInfo device;
  final VoidCallback onConnect;

  const ScanResultTile({
    super.key,
    required this.device,
    required this.onConnect,
  });

  String _getShortTag(String id) {
    final clean = id.replaceAll(':', '').replaceAll('-', '');
    if (clean.length >= 4) {
      return clean.substring(clean.length - 4).toUpperCase();
    }
    return clean.toUpperCase();
  }

  Color _getDeviceAccentColor(String id) {
    final hash = id.hashCode.abs();
    const palette = [
      Color(0xFF3B82F6), // Electric Blue
      Color(0xFF10B981), // Emerald
      Color(0xFF8B5CF6), // Purple
      Color(0xFFF59E0B), // Amber
      Color(0xFFEC4899), // Pink
      Color(0xFF06B6D4), // Cyan
      Color(0xFF6366F1), // Indigo
      Color(0xFF14B8A6), // Teal
    ];
    return palette[hash % palette.length];
  }

  (String label, IconData icon, Color color) _getSignalInfo(int rssi) {
    if (rssi >= -60) {
      return ('Strong', LucideIcons.wifi, Colors.green);
    } else if (rssi >= -75) {
      return ('Good', LucideIcons.wifiHigh, Colors.lightGreen.shade700);
    } else if (rssi >= -85) {
      return ('Fair', LucideIcons.wifiLow, Colors.amber.shade800);
    } else {
      return ('Weak', LucideIcons.wifiZero, Colors.red.shade600);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shortTag = _getShortTag(device.id);
    final accentColor = _getDeviceAccentColor(device.id);
    final (signalLabel, signalIcon, signalColor) = _getSignalInfo(device.rssi);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isBike = device.isRevoltBike;
    final deviceIcon = isBike ? LucideIcons.bike : LucideIcons.bluetooth;

    return VoltCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Dynamic Device Avatar with Signal Badge Dot
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (isBike ? accentColor : Colors.blueGrey)
                      .withValues(alpha: isDark ? 0.25 : 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: (isBike ? accentColor : Colors.blueGrey)
                        .withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  deviceIcon,
                  color: isBike ? accentColor : Colors.blueGrey,
                  size: 24,
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: signalColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          // Device Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        device.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: isDark ? 0.3 : 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '#$shortTag',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'ID: ${device.id}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    letterSpacing: 0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      signalIcon,
                      size: 14,
                      color: signalColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$signalLabel (${device.rssi} dBm)',
                      style: TextStyle(
                        fontSize: 12,
                        color: signalColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: onConnect,
            icon: const Icon(LucideIcons.link, size: 16),
            label: const Text('Connect'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
