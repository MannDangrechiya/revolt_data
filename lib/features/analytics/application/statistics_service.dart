import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/database_provider.dart';

part 'statistics_service.g.dart';

class StatisticsData {
  final double totalOwnershipCost;
  final double petrolSavings;
  final double co2SavedKg;
  final double longestRide;
  final double shortestRide;
  final double avgRideDistance;
  final int totalRideCount;
  final Map<int, double> monthlyExpenses;

  StatisticsData({
    required this.totalOwnershipCost,
    required this.petrolSavings,
    required this.co2SavedKg,
    required this.longestRide,
    required this.shortestRide,
    required this.avgRideDistance,
    required this.totalRideCount,
    required this.monthlyExpenses,
  });
}

@riverpod
Future<StatisticsData> statisticsService(Ref ref) async {
  final db = ref.read(databaseProvider);
  
  final rides = await db.select(db.ridesTable).get();
  final charges = await db.select(db.chargeLogsTable).get();
  final expenses = await db.select(db.expensesTable).get();
  final maintenance = await db.select(db.maintenanceLogsTable).get();

  // 1. Total Ownership Cost
  double totalCost = 0.0;
  for (var c in charges) { totalCost += c.cost; }
  for (var e in expenses) { totalCost += e.amount; }
  for (var m in maintenance) { totalCost += m.cost; }

  // 2. Rides Stats
  double totalDist = 0.0;
  double longest = 0.0;
  double shortest = double.infinity;
  
  for (var r in rides) {
    final dist = r.endOdometer - r.startOdometer;
    totalDist += dist;
    if (dist > longest) longest = dist;
    if (dist < shortest && dist > 0) shortest = dist;
  }
  if (shortest == double.infinity) shortest = 0.0;
  
  final avgDist = rides.isEmpty ? 0.0 : totalDist / rides.length;

  // 3. Savings vs Petrol & CO2
  final petrolPricePerLitre = AppConstants.petrolPricePerLitre; 
  final petrolMileage = AppConstants.petrolMileageKmPerLitre;
  final petrolUsedLiters = totalDist / petrolMileage;
  final expectedPetrolCost = petrolUsedLiters * petrolPricePerLitre;
  
  double totalElectricityCost = 0.0;
  double totalElectricityKwh = 0.0;
  for (var c in charges) {
    totalElectricityCost += c.cost;
    totalElectricityKwh += c.kwhAdded;
  }
  
  final petrolSavings = expectedPetrolCost - totalElectricityCost;
  
  // CO2: petrol emits petrolCo2KgPerLitre kg CO2/L, grid emits gridCo2KgPerKwh kg CO2/kWh
  final co2Petrol = petrolUsedLiters * AppConstants.petrolCo2KgPerLitre;
  final co2Ev = totalElectricityKwh * AppConstants.gridCo2KgPerKwh;
  final co2Saved = co2Petrol - co2Ev;

  // 4. Monthly Spending Chart Data
  final monthlyExpenses = <int, double>{};
  for (var c in charges) {
    final month = c.date.month;
    monthlyExpenses[month] = (monthlyExpenses[month] ?? 0.0) + c.cost;
  }
  for (var e in expenses) {
    final month = e.date.month;
    monthlyExpenses[month] = (monthlyExpenses[month] ?? 0.0) + e.amount;
  }
  for (var m in maintenance) {
    final month = m.date.month;
    monthlyExpenses[month] = (monthlyExpenses[month] ?? 0.0) + m.cost;
  }

  return StatisticsData(
    totalOwnershipCost: totalCost,
    petrolSavings: petrolSavings > 0 ? petrolSavings : 0.0,
    co2SavedKg: co2Saved > 0 ? co2Saved : 0.0,
    longestRide: longest,
    shortestRide: shortest,
    avgRideDistance: avgDist,
    totalRideCount: rides.length,
    monthlyExpenses: monthlyExpenses,
  );
}
