import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../features/rides/domain/ride.dart';
import '../../features/charging/domain/charge_log.dart';
import '../../features/expenses/domain/expense.dart';
import '../../features/maintenance/domain/maintenance_log.dart';

part 'app_database.g.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return fromDb.split('||');
  }

  @override
  String toSql(List<String> value) {
    return value.join('||');
  }
}

class RidesTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get startOdometer => real()();
  RealColumn get endOdometer => real()();
  IntColumn get batteryBefore => integer()();
  IntColumn get batteryAfter => integer()();
  IntColumn get rideMode => intEnum<RideMode>()();
  IntColumn get roadCondition => intEnum<RoadCondition>()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoPaths => text().map(const StringListConverter()).withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

class ChargeLogsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get durationMinutes => real()();
  RealColumn get kwhAdded => real()();
  RealColumn get cost => real()();
  IntColumn get paymentMethod => intEnum<PaymentMethod>()();
  IntColumn get locationType => intEnum<LocationType>()();
  IntColumn get startBattery => integer()();
  IntColumn get endBattery => integer()();
  TextColumn get locationName => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ExpensesTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get category => intEnum<ExpenseCategory>()();
  RealColumn get amount => real()();
  TextColumn get notes => text().nullable()();
  TextColumn get receiptPhotoPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MaintenanceLogsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get component => intEnum<MaintenanceComponent>()();
  TextColumn get description => text()();
  RealColumn get odometerReading => real()();
  RealColumn get cost => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class RemindersTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  RealColumn get targetOdometer => real().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isNotified => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [RidesTable, ChargeLogsTable, ExpensesTable, MaintenanceLogsTable, RemindersTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'revolt_data.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
