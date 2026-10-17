import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/adapters/obd_can_adapter.dart';
import '../../data/adapters/revolt_ble_adapter.dart';
import '../../data/adapters/smart_bms_adapter.dart';
import '../../data/adapters/standard_gatt_adapter.dart';
import '../../domain/ev_protocol_adapter.dart';
import 'ble_connection_provider.dart';

/// Supported EV communication protocol types across Revolt and universal EV ecosystems.
enum EvProtocolType {
  revoltBle(
    name: 'Revolt RV400 BLE',
    description: 'Proprietary ASCII BLE protocol for Revolt RV400',
    brand: 'Revolt Motors',
  ),
  standardGatt(
    name: 'Ather & TVS Standard GATT',
    description: 'Bluetooth SIG Battery Service (0x180F) & Navigation cues',
    brand: 'Ather / TVS',
  ),
  smartBms(
    name: 'Daly / JK Smart BMS',
    description: 'Universal Custom EV BMS UART telemetry & active cell balancer',
    brand: 'Universal Custom EV',
  ),
  obdCan(
    name: 'ELM327 OBD-II CAN',
    description: 'Diagnostic CAN bus telemetry, motor RPM, and inverter temps',
    brand: 'Universal OBD-II',
  );

  final String name;
  final String description;
  final String brand;

  const EvProtocolType({
    required this.name,
    required this.description,
    required this.brand,
  });
}

/// Notifier managing active EV protocol selection.
class ActiveEvProtocolNotifier extends Notifier<EvProtocolType> {
  @override
  EvProtocolType build() => EvProtocolType.revoltBle;

  void setProtocol(EvProtocolType protocol) {
    state = protocol;
  }
}

/// Provider managing the active EV protocol type selection (defaults to Revolt RV400).
final activeEvProtocolTypeProvider =
    NotifierProvider<ActiveEvProtocolNotifier, EvProtocolType>(
  ActiveEvProtocolNotifier.new,
);

/// Provider exposing the singleton instance of [StandardGattAdapter].
final standardGattAdapterProvider = Provider<StandardGattAdapter>((ref) {
  final adapter = StandardGattAdapter();
  ref.onDispose(() => adapter.dispose());
  return adapter;
});

/// Provider exposing the singleton instance of [SmartBmsAdapter].
final smartBmsAdapterProvider = Provider<SmartBmsAdapter>((ref) {
  final adapter = SmartBmsAdapter();
  ref.onDispose(() => adapter.dispose());
  return adapter;
});

/// Provider exposing the singleton instance of [ObdCanAdapter].
final obdCanAdapterProvider = Provider<ObdCanAdapter>((ref) {
  final adapter = ObdCanAdapter();
  ref.onDispose(() => adapter.dispose());
  return adapter;
});

/// Provider exposing the singleton instance of [RevoltBleAdapter] bound to [BleVehicleRepository].
final revoltBleAdapterProvider = Provider<RevoltBleAdapter>((ref) {
  final bleRepo = ref.watch(bleRepositoryProvider);
  final adapter = RevoltBleAdapter(bleRepo: bleRepo);
  ref.onDispose(() => adapter.dispose());
  return adapter;
});

/// Universal provider returning the active [EvProtocolAdapter] HAL according to user selection.
final evProtocolAdapterProvider = Provider<EvProtocolAdapter>((ref) {
  final activeType = ref.watch(activeEvProtocolTypeProvider);
  return switch (activeType) {
    EvProtocolType.revoltBle => ref.watch(revoltBleAdapterProvider),
    EvProtocolType.standardGatt => ref.watch(standardGattAdapterProvider),
    EvProtocolType.smartBms => ref.watch(smartBmsAdapterProvider),
    EvProtocolType.obdCan => ref.watch(obdCanAdapterProvider),
  };
});
