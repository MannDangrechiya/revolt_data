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

class BikesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get brand => text()();
  TextColumn get model => text()();
  TextColumn get variant => text().nullable()();
  TextColumn get color => text()();
  TextColumn get registrationNumber => text()();
  TextColumn get vin => text().nullable()();
  TextColumn get motorNumber => text().nullable()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  TextColumn get dealer => text().nullable()();
  TextColumn get insurance => text().nullable()();
  TextColumn get warranty => text().nullable()();
  TextColumn get batteryWarranty => text().nullable()();
  RealColumn get batteryCapacity => real().nullable()();
  RealColumn get motorPower => real().nullable()();
  RealColumn get claimedRange => real().nullable()();
  RealColumn get topSpeed => real().nullable()();
  TextColumn get tyreInfo => text().nullable()();
  TextColumn get customNotes => text().nullable()();
  TextColumn get photoPath => text().nullable()();
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
  // New fields
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get durationMinutes => integer().nullable()();
  RealColumn get estimatedRemainingRange => real().nullable()();
  RealColumn get averageSpeed => real().nullable()();
  RealColumn get maxSpeed => real().nullable()();
  TextColumn get weather => text().nullable()();
  TextColumn get roadType => text().nullable()();
  IntColumn get passengerCount => integer().nullable()();
  TextColumn get ridePurpose => text().nullable()();
  TextColumn get startLocation => text().nullable()();
  TextColumn get endLocation => text().nullable()();
  TextColumn get routeNotes => text().nullable()();
  TextColumn get customTags => text().map(const StringListConverter()).withDefault(const Constant(''))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get bikeId => integer().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();

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
  // New fields
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get chargerType => text().nullable()();
  TextColumn get chargingMethod => text().nullable()();
  RealColumn get electricityPrice => real().nullable()();
  TextColumn get photoPaths => text().map(const StringListConverter()).withDefault(const Constant(''))();
  IntColumn get bikeId => integer().nullable()();
  TextColumn get providerName => text().nullable()();
  RealColumn get maxChargingPowerKw => real().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();

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
  // New fields
  TextColumn get description => text().nullable()();
  IntColumn get bikeId => integer().nullable()();

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
  // New fields
  TextColumn get serviceCenter => text().nullable()();
  TextColumn get partsReplaced => text().nullable()();
  RealColumn get labourCost => real().nullable()();
  BoolColumn get warrantyClaim => boolean().withDefault(const Constant(false))();
  TextColumn get technician => text().nullable()();
  TextColumn get invoicePhotoPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get nextServiceDueOdometer => real().nullable()();
  DateTimeColumn get nextServiceDueDate => dateTime().nullable()();
  
  // Trackable components
  BoolColumn get tyres => boolean().withDefault(const Constant(false))();
  BoolColumn get brakes => boolean().withDefault(const Constant(false))();
  BoolColumn get battery => boolean().withDefault(const Constant(false))();
  BoolColumn get suspension => boolean().withDefault(const Constant(false))();
  BoolColumn get motor => boolean().withDefault(const Constant(false))();
  BoolColumn get lights => boolean().withDefault(const Constant(false))();
  BoolColumn get horn => boolean().withDefault(const Constant(false))();
  BoolColumn get softwareUpdate => boolean().withDefault(const Constant(false))();
  BoolColumn get generalInspection => boolean().withDefault(const Constant(false))();
  
  IntColumn get bikeId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DocumentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get filePath => text()();
  DateTimeColumn get uploadDate => dateTime()();
  TextColumn get notes => text().nullable()();
  IntColumn get bikeId => integer().nullable()();
}

class RemindersTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  RealColumn get targetOdometer => real().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isNotified => boolean().withDefault(const Constant(false))();
  // New fields
  TextColumn get type => text().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get bikeId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BatteryHealthSnapshotsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get healthPercent => real()();
  RealColumn get rangeAtFullCharge => real()();
  IntColumn get bikeId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  BikesTable,
  RidesTable,
  ChargeLogsTable,
  ExpensesTable,
  MaintenanceLogsTable,
  DocumentsTable,
  RemindersTable,
  BatteryHealthSnapshotsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(bikesTable);
        await m.createTable(documentsTable);

        await m.addColumn(ridesTable, ridesTable.startTime);
        await m.addColumn(ridesTable, ridesTable.endTime);
        await m.addColumn(ridesTable, ridesTable.durationMinutes);
        await m.addColumn(ridesTable, ridesTable.estimatedRemainingRange);
        await m.addColumn(ridesTable, ridesTable.averageSpeed);
        await m.addColumn(ridesTable, ridesTable.maxSpeed);
        await m.addColumn(ridesTable, ridesTable.weather);
        await m.addColumn(ridesTable, ridesTable.roadType);
        await m.addColumn(ridesTable, ridesTable.passengerCount);
        await m.addColumn(ridesTable, ridesTable.ridePurpose);
        await m.addColumn(ridesTable, ridesTable.startLocation);
        await m.addColumn(ridesTable, ridesTable.endLocation);
        await m.addColumn(ridesTable, ridesTable.routeNotes);
        await m.addColumn(ridesTable, ridesTable.customTags);
        await m.addColumn(ridesTable, ridesTable.isFavorite);
        await m.addColumn(ridesTable, ridesTable.bikeId);

        await m.addColumn(chargeLogsTable, chargeLogsTable.startTime);
        await m.addColumn(chargeLogsTable, chargeLogsTable.endTime);
        await m.addColumn(chargeLogsTable, chargeLogsTable.chargerType);
        await m.addColumn(chargeLogsTable, chargeLogsTable.chargingMethod);
        await m.addColumn(chargeLogsTable, chargeLogsTable.electricityPrice);
        await m.addColumn(chargeLogsTable, chargeLogsTable.photoPaths);
        await m.addColumn(chargeLogsTable, chargeLogsTable.bikeId);

        await m.addColumn(expensesTable, expensesTable.description);
        await m.addColumn(expensesTable, expensesTable.bikeId);

        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.serviceCenter);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.partsReplaced);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.labourCost);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.warrantyClaim);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.technician);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.invoicePhotoPath);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.notes);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.nextServiceDueOdometer);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.nextServiceDueDate);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.tyres);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.brakes);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.battery);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.suspension);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.motor);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.lights);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.horn);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.softwareUpdate);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.generalInspection);
        await m.addColumn(maintenanceLogsTable, maintenanceLogsTable.bikeId);

        await m.addColumn(remindersTable, remindersTable.type);
        await m.addColumn(remindersTable, remindersTable.note);
        await m.addColumn(remindersTable, remindersTable.isActive);
        await m.addColumn(remindersTable, remindersTable.bikeId);
      }
      if (from < 3) {
        await m.createTable(batteryHealthSnapshotsTable);
      }
      if (from < 4) {
        await m.addColumn(chargeLogsTable, chargeLogsTable.providerName);
        await m.addColumn(chargeLogsTable, chargeLogsTable.maxChargingPowerKw);
      }
      if (from < 5) {
        await m.addColumn(ridesTable, ridesTable.source);
        await m.addColumn(chargeLogsTable, chargeLogsTable.source);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'revolt_data.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
