import 'bike.dart';

abstract class BikeRepository {
  Future<Bike?> getCurrentBike();
  Future<Bike?> getBikeById(int id);
  Future<void> saveBike(Bike bike);
  Future<void> updateBike(Bike bike);
}
