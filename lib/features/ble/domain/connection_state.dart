/// States of the Revolt RV400 BLE connection life cycle.
enum BleConnectionState {
  disconnected,
  scanning,
  connecting,
  connected,
  authenticating,
  authenticated,
  error,
}
