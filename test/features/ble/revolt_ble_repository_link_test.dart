import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';
import 'package:revolt_data/features/ble/data/revolt_ble_repository.dart';
import 'package:revolt_data/features/ble/domain/connection_state.dart';
import 'package:revolt_data/features/tracking/presentation/providers/gps_ride_provider.dart';

class _FakeClient extends Fake implements RevoltBleClient {
  final links = StreamController<BluetoothConnectionState>.broadcast();
  final reauth = StreamController<void>.broadcast();
  final packets = StreamController<RawPacket>.broadcast();

  @override
  Stream<BluetoothConnectionState> get connectionStateStream => links.stream;
  @override
  Stream<void> get reauthenticatedStream => reauth.stream;
  @override
  Stream<RawPacket> listen() => packets.stream;
  @override
  bool get isConnected => true;
  @override
  Future<void> connect([String? remoteId, dynamic deviceOverride]) async {}
  @override
  Future<int> requestMtu(int desiredMtu) async => desiredMtu;
  @override
  Future<bool> authenticate(String token, {Duration timeout = const Duration(seconds: 5)}) async => true;
  @override
  Future<void> requestTelemetry() async {}
  @override
  Future<void> disconnect() async {}
}

void main() {
  late _FakeClient client;
  late RevoltBleRepository repo;

  setUp(() async {
    client = _FakeClient();
    repo = RevoltBleRepository(client: client);
    await repo.connect('AA:BB');
    await repo.pair('token');
  });

  tearDown(() => repo.dispose());

  test('emits disconnected when the bike link drops while authenticated', () async {
    expect(repo.currentConnectionState, BleConnectionState.authenticated);
    final emitted = expectLater(
      repo.connectionStateStream,
      emits(BleConnectionState.disconnected),
    );
    client.links.add(BluetoothConnectionState.disconnected);
    await emitted;
    expect(repo.currentConnectionState, BleConnectionState.disconnected);
  });

  test('ignores connected link events', () async {
    client.links.add(BluetoothConnectionState.connected);
    await Future<void>.delayed(Duration.zero);
    expect(repo.currentConnectionState, BleConnectionState.authenticated);
  });

  test('returns to authenticated after SDK auto-reconnect re-pairs', () async {
    client.links.add(BluetoothConnectionState.disconnected);
    await Future<void>.delayed(Duration.zero);
    client.reauth.add(null);
    await Future<void>.delayed(Duration.zero);
    expect(repo.currentConnectionState, BleConnectionState.authenticated);
  });

  test('GPS-only ride battery estimate uses ~30 Wh/km of a 3.24 kWh pack', () {
    expect(GpsRideNotifier.estimateBatteryDropPercent(0), 0);
    expect(GpsRideNotifier.estimateBatteryDropPercent(10), 9);
  });
}
