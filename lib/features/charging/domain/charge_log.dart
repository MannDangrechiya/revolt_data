import 'package:freezed_annotation/freezed_annotation.dart';

part 'charge_log.freezed.dart';
part 'charge_log.g.dart';

enum PaymentMethod {
  @JsonValue('creditCard')
  creditCard,
  @JsonValue('rfidCard')
  rfidCard,
  @JsonValue('appWallet')
  appWallet,
  @JsonValue('cash')
  cash,
  @JsonValue('free')
  free,
}

enum LocationType {
  @JsonValue('home')
  home,
  @JsonValue('public')
  public,
  @JsonValue('work')
  work,
}

@freezed
abstract class ChargeLog with _$ChargeLog {
  const factory ChargeLog({
    required String id,
    required DateTime date,
    required double durationMinutes,
    required double kwhAdded,
    required double cost,
    required PaymentMethod paymentMethod,
    required LocationType locationType,
    required int startBattery,
    required int endBattery,
    String? locationName,
    String? notes,
    DateTime? startTime,
    DateTime? endTime,
    String? chargerType,
    String? chargingMethod,
    double? electricityPrice,
    @Default([]) List<String> photoPaths,
    int? bikeId,
  }) = _ChargeLog;

  factory ChargeLog.fromJson(Map<String, dynamic> json) => _$ChargeLogFromJson(json);
}

extension ChargeLogExtension on ChargeLog {
  double get chargingSpeedKw => kwhAdded / (durationMinutes / 60);
  int get batteryAdded => endBattery - startBattery;
}
