import 'dart:async';
import 'vehicle_snapshot.dart';

/// Hardware Abstraction Layer (HAL) interface enabling universal compatibility
/// across Revolt, Ather, TVS, Smart BMS (Daly/JK/JBD), and OBD-II CAN standards.
abstract class EvProtocolAdapter {
  /// Name of the EV manufacturer or ecosystem (e.g. 'Revolt Motors', 'Ather / TVS', 'Daly / JK Smart BMS', 'Universal OBD-II CAN').
  String get vehicleBrand;

  /// Technical protocol identifier (e.g. 'Revolt RV400 ASCII BLE', 'Bluetooth SIG GATT 0x180F', 'Smart BMS UART 0xFFE0', 'ELM327 OBD-II CAN').
  String get protocolName;

  /// Real-time stream of decoded vehicle telemetry snapshots.
  Stream<VehicleSnapshot> get telemetryStream;

  /// Sends a domain or raw protocol command to the vehicle/controller.
  Future<void> sendCommand(String command);

  /// Connects to a target vehicle/peripheral by [deviceId].
  Future<bool> connect(String deviceId);

  /// Gracefully disconnects and cancels active telemetry streams.
  Future<void> disconnect();
}
