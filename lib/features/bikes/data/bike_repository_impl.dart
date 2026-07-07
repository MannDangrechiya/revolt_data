import '../../../core/database/app_database.dart';
import '../../../core/database/database_mappers.dart';
import '../domain/bike.dart';
import '../domain/bike_repository.dart';

class BikeRepositoryImpl implements BikeRepository {
  final AppDatabase _db;

  BikeRepositoryImpl(this._db);

  @override
  Future<Bike?> getCurrentBike() async {
    final bikes = await _db.select(_db.bikesTable).get();
    if (bikes.isNotEmpty) {
      return bikes.first.toDomain();
    }
    return null;
  }

  @override
  Future<void> saveBike(Bike bike) async {
    await _db.into(_db.bikesTable).insert(bike.toCompanion());
  }

  @override
  Future<void> updateBike(Bike bike) async {
    await _db.update(_db.bikesTable).replace(bike.toCompanion());
  }
}
