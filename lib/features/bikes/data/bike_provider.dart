import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/database_provider.dart';
import '../domain/bike.dart';
import '../domain/bike_repository.dart';
import 'bike_repository_impl.dart';

part 'bike_provider.g.dart';

@riverpod
BikeRepository bikeRepository(BikeRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return BikeRepositoryImpl(db);
}

@riverpod
class CurrentBike extends _$CurrentBike {
  @override
  FutureOr<Bike?> build() async {
    final repo = ref.watch(bikeRepositoryProvider);
    return repo.getCurrentBike();
  }

  Future<void> saveBike(Bike bike) async {
    final repo = ref.watch(bikeRepositoryProvider);
    await repo.saveBike(bike);
    ref.invalidateSelf();
  }

  Future<void> updateBike(Bike bike) async {
    final repo = ref.watch(bikeRepositoryProvider);
    await repo.updateBike(bike);
    ref.invalidateSelf();
  }
}
