import 'package:flutter/material.dart';

import '../../domain/connection_state.dart';

/// Badge displaying a colored status dot and descriptive label for [BleConnectionState].
class ConnectionStatusBadge extends StatelessWidget {
  final BleConnectionState state;

  const ConnectionStatusBadge({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final (color, label) = _getProperties(state);

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

  (Color, String) _getProperties(BleConnectionState state) {
    switch (state) {
      case BleConnectionState.disconnected:
        return (Colors.grey, 'Disconnected');
      case BleConnectionState.scanning:
        return (Colors.blue, 'Scanning...');
      case BleConnectionState.connecting:
        return (Colors.amber, 'Connecting...');
      case BleConnectionState.connected:
        return (Colors.teal, 'Connected');
      case BleConnectionState.authenticating:
        return (Colors.orange, 'Authenticating...');
      case BleConnectionState.authenticated:
        return (Colors.green, 'Authenticated');
      case BleConnectionState.error:
        return (Colors.red, 'Connection Error');
    }
  }
}
