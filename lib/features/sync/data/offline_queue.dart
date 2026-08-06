import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../rides/domain/ride.dart';

part 'offline_queue.g.dart';

/// Represents a record in the offline sync queue
class QueueItem {
  final String id;
  final String action;
  final String entityType;
  final String entityId;
  final String payloadJson;
  final DateTime createdAt;

  QueueItem({
    required this.id,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.payloadJson,
    required this.createdAt,
  });
}

class OfflineQueue {
  final AppDatabase _db;

  OfflineQueue(this._db);

  /// Adds a manual ride to the offline queue when no BLE/network is available.
  Future<int> addPendingRide(Ride ride) async {
    final rideJson = jsonEncode(ride.toJson());
    final companion = PendingRidesTableCompanion.insert(
      rideJson: rideJson,
      syncPending: const Value(true),
      createdAt: DateTime.now(),
    );
    return await _db.into(_db.pendingRidesTable).insert(companion);
  }

  /// Retrieves all rides that are pending sync.
  Future<List<Ride>> getPendingRides() async {
    final query = _db.select(_db.pendingRidesTable)
      ..where((t) => t.syncPending.equals(true));
    final rows = await query.get();

    final List<Ride> rides = [];
    for (final row in rows) {
      try {
        final map = jsonDecode(row.rideJson) as Map<String, dynamic>;
        rides.add(Ride.fromJson(map));
      } catch (_) {}
    }
    return rides;
  }

  /// Processes pending offline rides, checking for duplicate odometers.
  /// Inserts valid rides and marks them as synced (or removes them).
  Future<int> processPendingQueue({
    required List<Ride> existingRides,
    required Future<void> Function(Ride ride) insertRide,
  }) async {
    final pendingRows = await (_db.select(_db.pendingRidesTable)
          ..where((t) => t.syncPending.equals(true)))
        .get();

    int syncedCount = 0;

    for (final row in pendingRows) {
      try {
        final map = jsonDecode(row.rideJson) as Map<String, dynamic>;
        final ride = Ride.fromJson(map);

        // Check if odometer overlaps with any existing ride (within 0.5 km)
        final isDup = existingRides.any((existing) {
          final odoDiff = (ride.startOdometer - existing.startOdometer).abs();
          return odoDiff < 0.5;
        });

        if (!isDup) {
          await insertRide(ride);
          syncedCount++;
        }

        // Mark as synced
        await (_db.update(_db.pendingRidesTable)
              ..where((t) => t.id.equals(row.id)))
            .write(const PendingRidesTableCompanion(syncPending: Value(false)));
      } catch (_) {}
    }

    return syncedCount;
  }

  /// Clears all processed pending rides from database
  Future<void> clearProcessedRides() async {
    await (_db.delete(_db.pendingRidesTable)
          ..where((t) => t.syncPending.equals(false)))
        .go();
  }
}

@riverpod
OfflineQueue offlineQueue(Ref ref) {
  final db = ref.watch(databaseProvider);
  return OfflineQueue(db);
}
