import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_device_info.freezed.dart';
part 'ble_device_info.g.dart';

/// Immutable model representing a discovered Bluetooth Low Energy device.
@freezed
abstract class BleDeviceInfo with _$BleDeviceInfo {
  const factory BleDeviceInfo({
    required String id,
    required String name,
    required int rssi,
    @Default(true) bool isRevoltBike,
  }) = _BleDeviceInfo;

  factory BleDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$BleDeviceInfoFromJson(json);
}
