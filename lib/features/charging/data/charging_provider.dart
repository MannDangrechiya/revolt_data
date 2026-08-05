import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../../bikes/data/bike_provider.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../domain/battery_health_snapshot.dart';
import '../domain/charge_log.dart';
import '../domain/charging_anomaly.dart';
import '../domain/charge_filter.dart';

part 'charging_provider.g.dart';

@riverpod
class ChargeFilterState extends _$ChargeFilterState {
  @override
  ChargeFilter build() => const ChargeFilter();

  void updateFilter(ChargeFilter filter) {
    state = filter;
  }
}

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

  Future<void> addChargeLog(ChargeLog log, {String source = 'manual'}) async {
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

    final logWithSource = log.copyWith(source: source);
    await db.into(db.chargeLogsTable).insert(logWithSource.toCompanion());

    final snapshot = ref.read(lastKnownVehicleSnapshotProvider);
    if (snapshot != null && snapshot.batteryHealth != null) {
      final health = snapshot.batteryHealth!.toDouble();
      final bike = await ref.read(currentBikeProvider.future);
      final claimedRange = bike?.claimedRange ?? 150.0;
      final rangeAtFullCharge = claimedRange * (health / 100.0);

      final healthSnapshot = BatteryHealthSnapshot(
        id: '${log.id}-health',
        date: log.date,
        healthPercent: health,
        rangeAtFullCharge: rangeAtFullCharge,
        bikeId: log.bikeId ?? bike?.id,
      );

      await db
          .into(db.batteryHealthSnapshotsTable)
          .insertOnConflictUpdate(healthSnapshot.toCompanion());
    }
  }

  Future<void> removeChargeLog(String id) async {
    final db = ref.watch(databaseProvider);
    await (db.delete(db.chargeLogsTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateChargeLog(ChargeLog log) async {
    final db = ref.watch(databaseProvider);
    final anomaly = ChargingAnomaly.checkAnomaly(
      kwhAdded: log.kwhAdded,
      durationMinutes: log.durationMinutes,
      startBattery: log.startBattery,
      endBattery: log.endBattery,
    );

    if (anomaly != null && anomaly.isError) {
      throw Exception(anomaly.message);
    }
    
    await db.update(db.chargeLogsTable).replace(log.toCompanion());
  }
}

@riverpod
Future<List<ChargeLog>> filteredChargeLogs(Ref ref) async {
  final logs = await ref.watch(chargingLogsProvider.future);
  final filter = ref.watch(chargeFilterStateProvider);

  return logs.where((log) {
    if (filter.locationType != null && log.locationType != filter.locationType) return false;
    if (filter.chargerType != null && log.chargerType != filter.chargerType) return false;
    if (filter.dateRange != null) {
      if (log.date.isBefore(filter.dateRange!.start) ||
          log.date.isAfter(filter.dateRange!.end.add(const Duration(days: 1)))) {
        return false;
      }
    }
    if (filter.searchQuery != null && filter.searchQuery!.trim().isNotEmpty) {
      final query = filter.searchQuery!.trim().toLowerCase();
      final notesMatch = log.notes?.toLowerCase().contains(query) ?? false;
      final locMatch = log.locationName?.toLowerCase().contains(query) ?? false;
      if (!notesMatch && !locMatch) return false;
    }
    return true;
  }).toList();
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

@riverpod
Future<ChargeLog?> chargeLogById(Ref ref, String id) async {
  final db = ref.watch(databaseProvider);
  final row = await (db.select(db.chargeLogsTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  return row?.toDomain();
}
