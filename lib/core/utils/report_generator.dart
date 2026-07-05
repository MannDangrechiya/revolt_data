import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../features/charging/domain/charge_log.dart';
import '../../features/expenses/domain/expense.dart';
import '../../features/maintenance/domain/maintenance_log.dart';
import '../../features/rides/domain/ride.dart';

class ReportGeneratorService {
  static Future<void> generateAndShareCsv({
    required List<Ride> rides,
    required List<Expense> expenses,
    required List<MaintenanceLog> maintenanceLogs,
    required List<ChargeLog> chargingLogs,
  }) async {
    final List<List<dynamic>> rows = [];

    // Rides Section
    rows.add(['--- RIDES ---']);
    rows.add(['Date', 'Distance (km)', 'Mode', 'Start Odo', 'End Odo', 'Battery Consumed (%)']);
    for (final r in rides) {
      rows.add([r.date.toIso8601String(), r.distance, r.rideMode.name, r.startOdometer, r.endOdometer, (r.batteryBefore - r.batteryAfter)]);
    }
    
    rows.add([]); // empty row

    // Expenses Section
    rows.add(['--- EXPENSES ---']);
    rows.add(['Date', 'Category', 'Amount (\$)']);
    for (final e in expenses) {
      rows.add([e.date.toIso8601String(), e.category.name, e.amount]);
    }

    rows.add([]);

    // Maintenance Section
    rows.add(['--- MAINTENANCE ---']);
    rows.add(['Date', 'Component', 'Cost (\$)', 'Odometer', 'Description']);
    for (final m in maintenanceLogs) {
      rows.add([m.date.toIso8601String(), m.component.name, m.cost, m.odometerReading, m.description]);
    }

    final csvData = Csv().encode(rows);

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/voltlog_export.csv');
    await file.writeAsString(csvData);

    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: 'VoltLog CSV Export'));
  }

  static Future<void> generateAndSharePdf({
    required double totalDistance,
    required double totalExpenses,
    required int totalChargeCycles,
    required List<MaintenanceLog> maintenanceLogs,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('VoltLog - Vehicle Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Summary Overview', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Total Distance Logged: ${totalDistance.toStringAsFixed(1)} km', style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Total Operating Expenses: \$${totalExpenses.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Estimated Charge Cycles: $totalChargeCycles', style: const pw.TextStyle(fontSize: 14)),
              
              pw.SizedBox(height: 30),
              pw.Text('Recent Maintenance Logs', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              if (maintenanceLogs.isEmpty)
                pw.Text('No maintenance logs recorded.')
              else
                pw.TableHelper.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>['Date', 'Component', 'Cost', 'Odometer'],
                    ...maintenanceLogs.map((m) => [
                          m.date.toIso8601String().split('T')[0],
                          m.component.name.toUpperCase(),
                          '\$${m.cost.toStringAsFixed(2)}',
                          '${m.odometerReading} km',
                        ])
                  ],
                ),
            ],
          );
        },
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/voltlog_report.pdf');
    await file.writeAsBytes(await pdf.save());

    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: 'VoltLog PDF Report'));
  }
}
