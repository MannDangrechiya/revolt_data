import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/charge_log.dart';
import '../domain/charging_anomaly.dart';

part 'charging_provider.g.dart';

@riverpod
class ChargingLogs extends _$ChargingLogs {
  @override
  Stream<List<ChargeLog>> build() {
    final db = ref.watch(databaseProvider);
    return db.select(db.chargeLogsTable).watch().map((rows) {
      final logs = rows.map((row) => row.toDomain()).toList();
      logs.sort((a, b) => b.date.compareTo(a.date));
      return logs;
    });
  }

  Future<void> addChargeLog(ChargeLog log) async {
    final db = ref.watch(databaseProvider);
    // Check for anomaly before adding
    final anomaly = ChargingAnomaly.checkAnomaly(
      kwhAdded: log.kwhAdded,
      durationMinutes: log.durationMinutes,
      startBattery: log.startBattery,
      endBattery: log.endBattery,
    );

    if (anomaly != null && anomaly.isError) {
      throw Exception(anomaly.message);
    }

    await db.into(db.chargeLogsTable).insert(log.toCompanion());
  }

  Future<void> removeChargeLog(String id) async {
    final db = ref.watch(databaseProvider);
    await (db.delete(db.chargeLogsTable)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
Future<double> totalChargingCost(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  return logs.fold<double>(0.0, (sum, log) => sum + log.cost);
}

@riverpod
Future<Map<LocationType, int>> chargingLocationDistribution(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  final distribution = <LocationType, int>{
    LocationType.home: 0,
    LocationType.public: 0,
    LocationType.work: 0,
  };
  
  for (final log in logs) {
    distribution[log.locationType] = (distribution[log.locationType] ?? 0) + 1;
  }
  return distribution;
}

@riverpod
Future<double> averageChargingSpeed(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  if (logs.isEmpty) return 0.0;
  
  final totalSpeed = logs.fold<double>(0.0, (sum, log) => sum + log.chargingSpeedKw);
  return totalSpeed / logs.length;
}
