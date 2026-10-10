import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/vehicle_snapshot.dart';
import 'ble_charge_provider.dart';
import 'ble_connection_provider.dart';
import 'ble_trip_provider.dart';

part 'ble_debug_provider.g.dart';

/// Data model representing a logged BLE packet entry in the circular buffer.
class LoggedPacket {
  final DateTime timestamp;
  final String characteristicUuid;
  final PacketDirection direction;
  final Uint8List rawBytes;
  final String hexString;
  final String parsedJson;

  const LoggedPacket({
    required this.timestamp,
    required this.characteristicUuid,
    required this.direction,
    required this.rawBytes,
    required this.hexString,
    required this.parsedJson,
  });

  factory LoggedPacket.fromRawPacket(RawPacket packet) {
    var displayBytes = packet.value;
    
    // Redact PAIR token
    if (packet.direction == PacketDirection.write && packet.value.length >= 4) {
      final asciiStr = utf8.decode(packet.value, allowMalformed: true);
      if (asciiStr.startsWith('PAIR') && asciiStr.length > 4) {
         displayBytes = Uint8List.fromList([80, 65, 73, 82, 42, 42, 42, 42, 35]); // PAIR****#
      }
    }

    final hex = displayBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(' ');

    String parsedJsonStr = 'N/A';
    final snapshot = VehicleSnapshot.parseRawBytes(displayBytes);
    if (snapshot != null) {
      parsedJsonStr = const JsonEncoder.withIndent('  ').convert(snapshot.toJson());
    }

    return LoggedPacket(
      timestamp: packet.timestamp,
      characteristicUuid: packet.characteristicUuid,
      direction: packet.direction,
      rawBytes: displayBytes,
      hexString: hex,
      parsedJson: parsedJsonStr,
    );
  }

  factory LoggedPacket.simulated({
    required String label,
    required VehicleSnapshot snapshot,
  }) {
    final now = DateTime.now();
    final ldString =
        'LD,${snapshot.batteryPercent},${snapshot.batteryVoltage},${snapshot.batteryCurrent},${snapshot.batteryTemp},${snapshot.motorTemp},${snapshot.speed},${snapshot.tripDistance},${snapshot.odometer},${snapshot.rideMode},${snapshot.range},${snapshot.power},NONE,${snapshot.batteryHealth ?? 100},${snapshot.gpsCoords ?? "19.0760,72.8777"}';
    final bytes = Uint8List.fromList(utf8.encode(ldString));
    final hex = bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(' ');
    final jsonStr = const JsonEncoder.withIndent('  ').convert(snapshot.toJson());

    return LoggedPacket(
      timestamp: now,
      characteristicUuid: '00002a19-0000-1000-8000-00805f9b34fb',
      direction: PacketDirection.notify,
      rawBytes: bytes,
      hexString: '$label: $hex',
      parsedJson: jsonStr,
    );
  }
}

/// Circular buffer notifier holding up to 100 raw BLE packets.
@Riverpod(keepAlive: true)
class RawPacketLog extends _$RawPacketLog {
  StreamSubscription<RawPacket>? _sub;

  @override
  List<LoggedPacket> build() {
    final repo = ref.watch(bleRepositoryProvider);
    _sub?.cancel();
    _sub = repo.rawPacketStream.listen((packet) {
      addPacket(LoggedPacket.fromRawPacket(packet));
    });

    ref.onDispose(() {
      _sub?.cancel();
    });

    // Initialize empty packet log until live BLE packets arrive
    return [];
  }

  /// Adds a new packet to the circular buffer (max 100 entries).
  void addPacket(LoggedPacket packet) {
    final currentList = List<LoggedPacket>.from(state);
    currentList.add(packet);
    if (currentList.length > 100) {
      currentList.removeAt(0);
    }
    state = currentList;
  }

  /// Clears the packet log.
  void clear() {
    state = [];
  }
}

/// Service exposing debug actions for BLE hardware testing.
@Riverpod(keepAlive: true)
class BleDebugActions extends _$BleDebugActions {
  @override
  void build() {}

  /// Force-starts a trip and records a simulated BLE packet log.
  void forceTripStart() {
    assert(kDebugMode, 'forceTripStart only available in debug mode');
    if (!kDebugMode) return;

    ref.read(bleTripProvider.notifier).forceStart();

    final snapshot = VehicleSnapshot(
      batteryPercent: 85,
      batteryVoltage: 72.4,
      batteryCurrent: 12.5,
      batteryTemp: 32,
      motorTemp: 38,
      speed: 35.0,
      tripDistance: 0.0,
      odometer: 1250.0,
      rideMode: 'Eco',
      range: 85.0,
      power: 0.9,
      timestamp: DateTime.now(),
    );

    ref.read(rawPacketLogProvider.notifier).addPacket(
          LoggedPacket.simulated(
            label: 'FORCE_TRIP_START',
            snapshot: snapshot,
          ),
        );
  }

  /// Force-stops a trip and records a simulated BLE packet log.
  Future<void> forceTripStop() async {
    assert(kDebugMode, 'forceTripStop only available in debug mode');
    if (!kDebugMode) return;

    await ref.read(bleTripProvider.notifier).forceStop();

    final snapshot = VehicleSnapshot(
      batteryPercent: 84,
      batteryVoltage: 72.0,
      batteryCurrent: 0.0,
      batteryTemp: 31,
      motorTemp: 33,
      speed: 0.0,
      tripDistance: 3.2,
      odometer: 1253.2,
      rideMode: 'Eco',
      range: 84.0,
      power: 0.0,
      timestamp: DateTime.now(),
    );

    ref.read(rawPacketLogProvider.notifier).addPacket(
          LoggedPacket.simulated(
            label: 'FORCE_TRIP_STOP',
            snapshot: snapshot,
          ),
        );
  }

  /// Force-starts a charge session and records a simulated BLE packet log.
  void forceChargeStart() {
    assert(kDebugMode, 'forceChargeStart only available in debug mode');
    if (!kDebugMode) return;

    ref.read(bleChargeProvider.notifier).forceStart();

    final snapshot = VehicleSnapshot(
      batteryPercent: 40,
      batteryVoltage: 68.0,
      batteryCurrent: 5.0,
      batteryTemp: 28,
      motorTemp: 28,
      speed: 0.0,
      tripDistance: 0.0,
      odometer: 1250.0,
      rideMode: 'Eco',
      range: 40.0,
      power: 0.34,
      timestamp: DateTime.now(),
    );

    ref.read(rawPacketLogProvider.notifier).addPacket(
          LoggedPacket.simulated(
            label: 'FORCE_CHARGE_START',
            snapshot: snapshot,
          ),
        );
  }

  /// Force-stops a charge session and records a simulated BLE packet log.
  Future<void> forceChargeStop() async {
    assert(kDebugMode, 'forceChargeStop only available in debug mode');
    if (!kDebugMode) return;

    await ref.read(bleChargeProvider.notifier).forceStop();

    final snapshot = VehicleSnapshot(
      batteryPercent: 65,
      batteryVoltage: 76.5,
      batteryCurrent: 0.0,
      batteryTemp: 32,
      motorTemp: 28,
      speed: 0.0,
      tripDistance: 0.0,
      odometer: 1250.0,
      rideMode: 'Eco',
      range: 65.0,
      power: 0.0,
      timestamp: DateTime.now(),
    );

    ref.read(rawPacketLogProvider.notifier).addPacket(
          LoggedPacket.simulated(
            label: 'FORCE_CHARGE_STOP',
            snapshot: snapshot,
          ),
        );
  }

  /// Simulates BLE disconnection.
  Future<void> simulateDisconnect() async {
    assert(kDebugMode, 'simulateDisconnect only available in debug mode');
    if (!kDebugMode) return;

    await ref.read(bleRepositoryProvider).disconnect();
  }

  /// Clears the cached snapshot and packet log.
  Future<void> clearCache() async {
    assert(kDebugMode, 'clearCache only available in debug mode');
    if (!kDebugMode) return;

    await ref.read(bleRepositoryProvider).clearSnapshotCache();
    clearPacketLog();
  }

  /// Clears packet log buffer.
  void clearPacketLog() {
    assert(kDebugMode, 'clearPacketLog only available in debug mode');
    if (!kDebugMode) return;

    ref.read(rawPacketLogProvider.notifier).clear();
  }
}
