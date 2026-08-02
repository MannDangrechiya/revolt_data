/// States of the Revolt RV400 BLE connection life cycle.
enum ConnectionState {
  disconnected,
  scanning,
  connecting,
  connected,
  authenticating,
  authenticated,
  error,
}

/// Convenience alias to avoid naming collisions with Flutter's built-in [ConnectionState].
typedef BleConnectionState = ConnectionState;
