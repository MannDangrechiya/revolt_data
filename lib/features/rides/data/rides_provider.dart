import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/ride.dart';
import '../domain/ride_filter.dart';

part 'rides_provider.g.dart';

@riverpod
class RideFilterState extends _$RideFilterState {
  @override
  RideFilter build() => const RideFilter();

  void updateFilter(RideFilter filter) {
    state = filter;
  }
}

@riverpod
class Rides extends _$Rides {
  @override
  Stream<List<Ride>> build() {
    final db = ref.watch(databaseProvider);
    return db.select(db.ridesTable).watch().map(
      (rows) {
        final rides = rows.map((row) => row.toDomain()).toList();
        rides.sort((a, b) => b.date.compareTo(a.date));
        return rides;
      },
    );
  }

  Future<void> addRide(Ride ride) async {
    final db = ref.watch(databaseProvider);
    // Chronological validation
    final currentRides = await db.select(db.ridesTable).get();
    if (currentRides.isNotEmpty) {
      final latestEndOdo = currentRides.map((r) => r.endOdometer).reduce((a, b) => a > b ? a : b);
      if (ride.startOdometer < latestEndOdo) {
        throw Exception('Start odometer (${ride.startOdometer}) cannot be less than the latest log\'s end odometer ($latestEndOdo).');
      }
    }
    await db.into(db.ridesTable).insert(ride.toCompanion());
  }

  Future<void> removeRide(String id) async {
    final db = ref.watch(databaseProvider);
    await (db.delete(db.ridesTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateRide(Ride ride) async {
    final db = ref.watch(databaseProvider);
    await db.update(db.ridesTable).replace(ride.toCompanion());
  }

  Future<void> toggleFavorite(String id) async {
    final db = ref.watch(databaseProvider);
    final rideRow = await (db.select(db.ridesTable)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (rideRow != null) {
      final ride = rideRow.toDomain();
      await updateRide(ride.copyWith(isFavorite: !ride.isFavorite));
    }
  }

  Future<void> duplicateRide(String id) async {
    final db = ref.watch(databaseProvider);
    final rideRow = await (db.select(db.ridesTable)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (rideRow != null) {
      final ride = rideRow.toDomain();
      final newRide = ride.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        // Add specific duplicate logic if needed (e.g. resetting some fields)
      );
      await addRide(newRide);
    }
  }
}

@riverpod
Future<List<Ride>> filteredRides(Ref ref) async {
  final rides = await ref.watch(ridesProvider.future);
  final filter = ref.watch(rideFilterStateProvider);

  return rides.where((ride) {
    if (filter.rideMode != null && ride.rideMode != filter.rideMode) return false;
    if (filter.roadCondition != null && ride.roadCondition != filter.roadCondition) return false;
    if (filter.dateRange != null) {
      if (ride.date.isBefore(filter.dateRange!.start) ||
          ride.date.isAfter(filter.dateRange!.end.add(const Duration(days: 1)))) {
        return false;
      }
    }
    if (filter.searchQuery != null && filter.searchQuery!.trim().isNotEmpty) {
      final query = filter.searchQuery!.trim().toLowerCase();
      final notesMatch = ride.notes?.toLowerCase().contains(query) ?? false;
      final tagsMatch = ride.customTags.any((tag) => tag.toLowerCase().contains(query));
      final locationMatch = (ride.startLocation?.toLowerCase().contains(query) ?? false) ||
                            (ride.endLocation?.toLowerCase().contains(query) ?? false);
      if (!notesMatch && !tagsMatch && !locationMatch) return false;
    }
    if (filter.isFavorite != null && filter.isFavorite! && !ride.isFavorite) {
      return false;
    }
    return true;
  }).toList();
}
