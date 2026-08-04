import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:revolt_data/core/database/app_database.dart';
import 'package:revolt_data/features/bikes/data/bike_repository_impl.dart';
import 'package:revolt_data/features/bikes/domain/bike.dart';

void main() {
  late AppDatabase database;
  late BikeRepositoryImpl repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = BikeRepositoryImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('BikeRepositoryImpl Tests', () {
    test('getCurrentBike returns null when no bike exists', () async {
      final bike = await repository.getCurrentBike();
      expect(bike, isNull);
    });

    test('saveBike inserts a bike into the database', () async {
      final newBike = const Bike(
        id: 0,
        name: 'My Volt',
        brand: 'Revolt',
        model: 'RV400',
        color: 'Black',
        registrationNumber: 'MH01AB1234',
      );

      await repository.saveBike(newBike);

      final bike = await repository.getCurrentBike();
      expect(bike, isNotNull);
      expect(bike!.name, 'My Volt');
    });

    test('updateBike updates an existing bike in the database', () async {
      // First insert
      await database.into(database.bikesTable).insert(
        const BikesTableCompanion(
          name: Value('Old Name'),
          brand: Value('Revolt'),
          model: Value('RV400'),
          color: Value('Black'),
          registrationNumber: Value('MH01AB1234'),
        )
      );

      var bike = await repository.getCurrentBike();
      expect(bike!.name, 'Old Name');

      // Update
      final updatedBike = bike.copyWith(name: 'New Name');
      await repository.updateBike(updatedBike);

      bike = await repository.getCurrentBike();
      expect(bike!.name, 'New Name');
    });
  });
}
