import 'bike.dart';

abstract class BikeRepository {
  Future<Bike?> getCurrentBike();
  Future<void> saveBike(Bike bike);
  Future<void> updateBike(Bike bike);
}
