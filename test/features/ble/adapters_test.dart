import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revolt_data/features/ble/data/adapters/obd_can_adapter.dart';
import 'package:revolt_data/features/ble/data/adapters/revolt_ble_adapter.dart';
import 'package:revolt_data/features/ble/data/adapters/smart_bms_adapter.dart';
import 'package:revolt_data/features/ble/data/adapters/standard_gatt_adapter.dart';
import 'package:revolt_data/features/ble/presentation/providers/ev_protocol_provider.dart';

void main() {
  group('Phase 3: Universal Multi-EV Protocol Layer Tests', () {
    test('RevoltBleAdapter parses ASCII LD packets and handles commands', () async {
      final adapter = RevoltBleAdapter();
      expect(adapter.vehicleBrand, 'Revolt Motors');
      expect(adapter.protocolName, 'Revolt RV400 ASCII BLE');

      // Test packet parsing
      const testLd = 'LD,82,72.4,12.5,34,42,48.0,19920.0,2,75.0,OK,1,98,23.0225,72.5714';
      final snapshot = adapter.ingestAsciiPacket(testLd);

      expect(snapshot, isNotNull);
      expect(snapshot!.batteryPercent, 82);
      expect(snapshot.batteryVoltage, 72.4);
      expect(snapshot.batteryCurrent, 12.5);
      expect(snapshot.batteryTemp, 34);
      expect(snapshot.motorTemp, 42);
      expect(snapshot.speed, 48.0);
      expect(snapshot.odometer, 19920.0);
      expect(snapshot.rideMode, 'Normal');

      // Test command validation
      expect(() => adapter.sendCommand('INVALID_CMD'), throwsArgumentError);
      adapter.dispose();
    });

    test('StandardGattAdapter (Ather / TVS) decodes 0x180F Battery & Navigation intents', () async {
      final adapter = StandardGattAdapter();
      expect(adapter.vehicleBrand, 'Ather / TVS');
      expect(adapter.protocolName, contains('0x180F'));

      // Ingest standard 1-byte battery level
      final snap1 = adapter.ingestBatteryLevel(78);
      expect(snap1.batteryPercent, 78);

      // Ingest structured standard GATT payload:
      // Byte 0: SOC = 85
      // Bytes 1-2: Voltage = 512 (51.2V in uint16 LE: 0x00, 0x02 = 512)
      // Bytes 3-4: Current = 150 (15.0A in int16 LE: 0x96, 0x00)
      // Byte 5: Temp = 35°C
      // Bytes 6-7: Speed = 450 (45.0 km/h in uint16 LE: 0xC2, 0x01)
      final payload = Uint8List.fromList([
        85,
        0x00, 0x02, // 512 -> 51.2 V
        0x96, 0x00, // 150 -> 15.0 A
        35,         // 35 °C
        0xC2, 0x01, // 450 -> 45.0 km/h
      ]);
      final snap2 = adapter.ingestGattPayload(payload);
      expect(snap2, isNotNull);
      expect(snap2!.batteryPercent, 85);
      expect(snap2.batteryVoltage, 51.2);
      expect(snap2.batteryCurrent, 15.0);
      expect(snap2.batteryTemp, 35);
      expect(snap2.speed, 45.0);

      // Send navigation cues
      await adapter.sendCommand('NAV:TURN_LEFT_200M');
      await adapter.sendCommand('NAV:ARRIVED');
      expect(adapter.sentNavIntents, contains('NAV:TURN_LEFT_200M'));
      expect(adapter.sentNavIntents, contains('NAV:ARRIVED'));

      adapter.dispose();
    });

    test('SmartBmsAdapter (Daly/JK BMS) decodes UART frames, cell mV, and controls balancer', () async {
      final adapter = SmartBmsAdapter();
      expect(adapter.vehicleBrand, contains('Daly'));
      expect(adapter.protocolName, contains('0xFFE0'));

      // Ingest Daly Frame 0x90:
      // Frame: [0xA5, 0x01, 0x90, 0x08, V_high, V_low, Acq_high, Acq_low, Curr_high, Curr_low, SOC_high, SOC_low, Checksum]
      // Voltage = 720 (72.0 V): 0x02, 0xD0
      // Current = 30150 ((30150 - 30000) / 10 = 15.0 A): 0x75, 0xC6
      // SOC = 800 (80.0%): 0x03, 0x20
      final frame90 = Uint8List.fromList([
        0xA5, 0x01, 0x90, 0x08,
        0x02, 0xD0, // 72.0 V
        0x02, 0xD0,
        0x75, 0xC6, // 15.0 A
        0x03, 0x20, // 80.0% SOC
        0x00,
      ]);
      final snap90 = adapter.ingestDalyFrame(frame90);
      expect(snap90, isNotNull);
      expect(snap90!.batteryPercent, 80);
      expect(snap90.batteryVoltage, 72.0);
      expect(snap90.batteryCurrent, 15.0);

      // Ingest Daly Frame 0x92 (Pack Temp Probe 1 = 36°C -> 36 + 40 = 76 = 0x4C)
      final frame92 = Uint8List.fromList([
        0xA5, 0x01, 0x92, 0x08,
        0x4C, 0x4C, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00,
        0x00,
      ]);
      final snap92 = adapter.ingestDalyFrame(frame92);
      expect(snap92?.batteryTemp, 36);

      // Ingest Daly Frame 0x93 (MOS & Balance state)
      final frame93 = Uint8List.fromList([
        0xA5, 0x01, 0x93, 0x08,
        0x03, // Both Charge (bit0) and Discharge (bit1) MOS enabled
        0x01, // Active balancer active
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00,
      ]);
      adapter.ingestDalyFrame(frame93);
      expect(adapter.isChargeMosEnabled, isTrue);
      expect(adapter.isDischargeMosEnabled, isTrue);
      expect(adapter.isBalancingActive, isTrue);

      // Test balance commands
      await adapter.sendCommand('BALANCE_OFF');
      expect(adapter.isBalancingActive, isFalse);
      await adapter.sendCommand('BALANCE_ON');
      expect(adapter.isBalancingActive, isTrue);

      // Ingest Daly Frame 0x95 (Cell millivolts chunk 1: Cells 1, 2, 3)
      // Cell 1 = 3600 mV (0x0E, 0x10), Cell 2 = 3605 mV (0x0E, 0x15), Cell 3 = 3598 mV (0x0E, 0x0E)
      final frame95 = Uint8List.fromList([
        0xA5, 0x01, 0x95, 0x08,
        0x01, // Frame seq 1
        0x0E, 0x10, // Cell 1: 3600 mV
        0x0E, 0x15, // Cell 2: 3605 mV
        0x0E, 0x0E, // Cell 3: 3598 mV
        0x00, // Padding
        0x00, // Checksum
      ]);
      adapter.ingestDalyFrame(frame95);
      expect(adapter.cellVoltagesMv.length, greaterThanOrEqualTo(3));
      expect(adapter.cellVoltagesMv[0], 3600);
      expect(adapter.cellVoltagesMv[1], 3605);
      expect(adapter.cellVoltagesMv[2], 3598);

      adapter.dispose();
    });

    test('ObdCanAdapter (ELM327 CAN) decodes RPM, speed, temps, DTCs and clears codes', () async {
      final adapter = ObdCanAdapter();
      expect(adapter.vehicleBrand, contains('OBD-II'));
      expect(adapter.protocolName, contains('ELM327'));

      // Test single-line speed response: 41 0D 3C -> 60 km/h
      final snap1 = adapter.ingestObdResponse('41 0D 3C');
      expect(snap1?.speed, 60.0);

      // Test multi-line stream:
      // 41 0C 1A F8 -> Motor RPM: ((0x1A * 256) + 0xF8) / 4 = 1726 RPM
      // 41 5C 5A -> Inverter Temp: 0x5A - 40 = 90 - 40 = 50 °C
      // 41 5B C8 -> Battery SOC: 200 * 100 / 255 = 78%
      // 43 01 0A 1F -> DTC: P0A1F
      const obdStream = '''
41 0C 1A F8
41 5C 5A
41 5B C8
43 01 0A 1F
''';
      final snap2 = adapter.ingestObdResponse(obdStream);
      expect(adapter.motorRpm, 1726);
      expect(snap2?.motorTemp, 50);
      expect(snap2?.batteryPercent, 78);
      expect(snap2?.faultCodes, contains('P0A1F'));

      // Clear trouble codes command '04'
      await adapter.sendCommand('04');
      final clearedSnap = adapter.ingestObdResponse('');
      expect(clearedSnap?.faultCodes, isEmpty);

      adapter.dispose();
    });

    test('Riverpod active protocol provider toggles adapters correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Default is Revolt RV400
      expect(container.read(activeEvProtocolTypeProvider), EvProtocolType.revoltBle);
      expect(container.read(evProtocolAdapterProvider).vehicleBrand, 'Revolt Motors');

      // Switch to Ather / TVS
      container.read(activeEvProtocolTypeProvider.notifier).setProtocol(EvProtocolType.standardGatt);
      expect(container.read(evProtocolAdapterProvider).vehicleBrand, 'Ather / TVS');

      // Switch to Daly / JK Smart BMS
      container.read(activeEvProtocolTypeProvider.notifier).setProtocol(EvProtocolType.smartBms);
      expect(container.read(evProtocolAdapterProvider).vehicleBrand, contains('Smart BMS'));

      // Switch to ELM327 OBD-II CAN
      container.read(activeEvProtocolTypeProvider.notifier).setProtocol(EvProtocolType.obdCan);
      expect(container.read(evProtocolAdapterProvider).vehicleBrand, contains('OBD-II'));
    });
  });
}
