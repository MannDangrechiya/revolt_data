import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_mappers.dart';
import '../../../core/database/database_provider.dart';

part 'data_export_service.g.dart';

@riverpod
Future<String> exportAllData(Ref ref) async {
  final db = ref.read(databaseProvider);

  // Fetch all tables
  final rides = await db.select(db.ridesTable).get();
  final chargeLogs = await db.select(db.chargeLogsTable).get();
  final expenses = await db.select(db.expensesTable).get();
  final maintenanceLogs = await db.select(db.maintenanceLogsTable).get();
  final reminders = await db.select(db.remindersTable).get();
  final documents = await db.select(db.documentsTable).get();
  final bikes = await db.select(db.bikesTable).get();
  final batterySnapshots = await db.select(db.batteryHealthSnapshotsTable).get();

  final exportData = {
    'exportedAt': DateTime.now().toIso8601String(),
    'appName': 'Revolt Data',
    'version': '1.0.0',
    'rides': rides.map((r) => r.toDomain().toJson()).toList(),
    'chargeLogs': chargeLogs.map((r) => r.toDomain().toJson()).toList(),
    'expenses': expenses.map((r) => r.toDomain().toJson()).toList(),
    'maintenanceLogs': maintenanceLogs.map((r) => r.toDomain().toJson()).toList(),
    'reminders': reminders.map((r) => r.toDomain().toJson()).toList(),
    'documents': documents.map((r) => r.toDomain().toJson()).toList(),
    'bikes': bikes.map((r) => r.toDomain().toJson()).toList(),
    'batterySnapshots': batterySnapshots.map((r) => {
      'id': r.id,
      'date': r.date.toIso8601String(),
      'healthPercent': r.healthPercent,
      'rangeAtFullCharge': r.rangeAtFullCharge,
      'bikeId': r.bikeId,
    }).toList(),
  };

  final now = DateTime.now();
  final timestamp = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}';
  final fileName = 'revolt_export_$timestamp.json';

  final dir = await getApplicationDocumentsDirectory();
  final filePath = '${dir.path}/$fileName';
  final file = File(filePath);

  final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);
  await file.writeAsString(jsonString);

  debugPrint('Export saved to: $filePath');
  return filePath;
}
