import 'package:flutter/material.dart';

import '../../domain/connection_state.dart';
import '../../domain/vehicle_snapshot.dart';

/// Badge displaying a colored status dot and descriptive label for [BleConnectionState] or [TelemetrySource].
class ConnectionStatusBadge extends StatelessWidget {
  final BleConnectionState? state;
  final TelemetrySource? source;

  const ConnectionStatusBadge({
    super.key,
    this.state,
    this.source,
  });

  const ConnectionStatusBadge.source({
    super.key,
    required TelemetrySource this.source,
  }) : state = null;

  @override
  Widget build(BuildContext context) {
    final (color, label) = _getProperties();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  (Color, String) _getProperties() {
    if (source != null) {
      return switch (source!) {
        TelemetrySource.ble => (Colors.teal, 'Live BLE'),
        TelemetrySource.cloud => (Colors.blue, 'Cloud Sync'),
        TelemetrySource.cached => (Colors.grey, 'Offline / Cached'),
      };
    }

    switch (state ?? BleConnectionState.disconnected) {
      case BleConnectionState.disconnected:
        return (Colors.grey, 'Disconnected');
      case BleConnectionState.scanning:
        return (Colors.blue, 'Scanning...');
      case BleConnectionState.connecting:
        return (Colors.amber, 'Connecting...');
      case BleConnectionState.connected:
        return (Colors.teal, 'Live BLE');
      case BleConnectionState.authenticating:
        return (Colors.orange, 'Authenticating...');
      case BleConnectionState.authenticated:
        return (Colors.teal, 'Live BLE');
      case BleConnectionState.error:
        return (Colors.red, 'Connection Error');
    }
  }
}
