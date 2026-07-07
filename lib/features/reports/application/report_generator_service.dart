import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

import '../../../core/database/database_provider.dart';
import '../../../core/database/app_database.dart';
import 'package:intl/intl.dart';

part 'report_generator_service.g.dart';

@riverpod
class ReportGeneratorService extends _$ReportGeneratorService {
  @override
  void build() {}

  Future<File> generatePdfReport(DateTime startDate, DateTime endDate, bool isDetailed) async {
    final db = ref.read(databaseProvider);
    
    // Fetch data
    final rides = await (db.select(db.ridesTable)
          ..where((t) => t.date.isBetweenValues(startDate, endDate)))
        .get();
    
    final charges = await (db.select(db.chargeLogsTable)
          ..where((t) => t.date.isBetweenValues(startDate, endDate)))
        .get();
        
    final expenses = await (db.select(db.expensesTable)
          ..where((t) => t.date.isBetweenValues(startDate, endDate)))
        .get();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildPdfHeader(startDate, endDate),
        build: (context) => [
          _buildSummarySection(rides, charges, expenses),
          pw.SizedBox(height: 20),
          if (isDetailed) ...[
            _buildDetailedRides(rides),
            pw.SizedBox(height: 20),
            _buildDetailedCharges(charges),
            pw.SizedBox(height: 20),
            _buildDetailedExpenses(expenses),
          ]
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Revolt_Report_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
  
  Future<File> generateExcelReport(DateTime startDate, DateTime endDate) async {
    final db = ref.read(databaseProvider);
    final rides = await (db.select(db.ridesTable)..where((t) => t.date.isBetweenValues(startDate, endDate))).get();
    final charges = await (db.select(db.chargeLogsTable)..where((t) => t.date.isBetweenValues(startDate, endDate))).get();
    final expenses = await (db.select(db.expensesTable)..where((t) => t.date.isBetweenValues(startDate, endDate))).get();

    final workbook = xlsio.Workbook();
    
    // Rides Sheet
    final ridesSheet = workbook.worksheets[0];
    ridesSheet.name = 'Rides';
    ridesSheet.getRangeByName('A1').setText('Date');
    ridesSheet.getRangeByName('B1').setText('Start Odo');
    ridesSheet.getRangeByName('C1').setText('End Odo');
    ridesSheet.getRangeByName('D1').setText('Distance');
    
    for (int i = 0; i < rides.length; i++) {
      final ride = rides[i];
      final row = i + 2;
      ridesSheet.getRangeByIndex(row, 1).setDateTime(ride.date);
      ridesSheet.getRangeByIndex(row, 2).setNumber(ride.startOdometer);
      ridesSheet.getRangeByIndex(row, 3).setNumber(ride.endOdometer);
      ridesSheet.getRangeByIndex(row, 4).setNumber(ride.endOdometer - ride.startOdometer);
    }
    
    // Charges Sheet
    final chargesSheet = workbook.worksheets.addWithName('Charges');
    chargesSheet.getRangeByName('A1').setText('Date');
    chargesSheet.getRangeByName('B1').setText('Units Added (kWh)');
    chargesSheet.getRangeByName('C1').setText('Cost');
    
    for (int i = 0; i < charges.length; i++) {
      final charge = charges[i];
      final row = i + 2;
      chargesSheet.getRangeByIndex(row, 1).setDateTime(charge.date);
      chargesSheet.getRangeByIndex(row, 2).setNumber(charge.kwhAdded);
      chargesSheet.getRangeByIndex(row, 3).setNumber(charge.cost);
    }
    
    // Expenses Sheet
    final expSheet = workbook.worksheets.addWithName('Expenses');
    expSheet.getRangeByName('A1').setText('Date');
    expSheet.getRangeByName('B1').setText('Category');
    expSheet.getRangeByName('C1').setText('Amount');
    expSheet.getRangeByName('D1').setText('Notes');
    
    for (int i = 0; i < expenses.length; i++) {
      final exp = expenses[i];
      final row = i + 2;
      expSheet.getRangeByIndex(row, 1).setDateTime(exp.date);
      expSheet.getRangeByIndex(row, 2).setText(exp.category.name);
      expSheet.getRangeByIndex(row, 3).setNumber(exp.amount);
      expSheet.getRangeByIndex(row, 4).setText(exp.notes ?? '');
    }

    final bytes = workbook.saveAsStream();
    workbook.dispose();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Revolt_Report_${DateFormat('yyyyMMdd').format(DateTime.now())}.xlsx');
    await file.writeAsBytes(bytes);
    return file;
  }

  pw.Widget _buildPdfHeader(DateTime startDate, DateTime endDate) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Revolt EV Logbook Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Text('Period: ${DateFormat.yMMMd().format(startDate)} to ${DateFormat.yMMMd().format(endDate)}'),
        pw.Divider(),
        pw.SizedBox(height: 16),
      ],
    );
  }

  pw.Widget _buildSummarySection(List<RidesTableData> rides, List<ChargeLogsTableData> charges, List<ExpensesTableData> expenses) {
    double totalDist = 0;
    for (var r in rides) {
      totalDist += (r.endOdometer - r.startOdometer);
    }
    double totalChargeCost = 0;
    double totalUnits = 0;
    for (var c in charges) {
      totalChargeCost += c.cost;
      totalUnits += c.kwhAdded;
    }
    double totalExpenses = 0;
    for (var e in expenses) {
      totalExpenses += e.amount;
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Summary', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            _buildTableRow('Total Rides', rides.length.toString()),
            _buildTableRow('Total Distance', '${totalDist.toStringAsFixed(1)} km'),
            _buildTableRow('Total Energy Added', '${totalUnits.toStringAsFixed(2)} kWh'),
            _buildTableRow('Charging Cost', '₹${totalChargeCost.toStringAsFixed(2)}'),
            _buildTableRow('Other Expenses', '₹${totalExpenses.toStringAsFixed(2)}'),
            _buildTableRow('Total Ownership Cost', '₹${(totalChargeCost + totalExpenses).toStringAsFixed(2)}', isBold: true),
          ],
        )
      ],
    );
  }

  pw.TableRow _buildTableRow(String label, String value, {bool isBold = false}) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(label, style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value, style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ),
      ]
    );
  }

  pw.Widget _buildDetailedRides(List<RidesTableData> rides) {
    if (rides.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Rides Detailed', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: ['Date', 'Start Odo', 'End Odo', 'Distance'].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(t, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))).toList(),
            ),
            ...rides.map((r) => pw.TableRow(
              children: [
                DateFormat('MM/dd/yy').format(r.date),
                r.startOdometer.toString(),
                r.endOdometer.toString(),
                (r.endOdometer - r.startOdometer).toStringAsFixed(1),
              ].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(t))).toList(),
            ))
          ]
        )
      ]
    );
  }

  pw.Widget _buildDetailedCharges(List<ChargeLogsTableData> charges) {
    if (charges.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Charges Detailed', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: ['Date', 'kWh', 'Cost'].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(t, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))).toList(),
            ),
            ...charges.map((c) => pw.TableRow(
              children: [
                DateFormat('MM/dd/yy').format(c.date),
                c.kwhAdded.toStringAsFixed(2),
                '₹${c.cost.toStringAsFixed(2)}',
              ].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(t))).toList(),
            ))
          ]
        )
      ]
    );
  }

  pw.Widget _buildDetailedExpenses(List<ExpensesTableData> expenses) {
    if (expenses.isEmpty) return pw.SizedBox();
    
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Expenses Detailed', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey100),
              children: ['Date', 'Category', 'Amount'].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(t, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))).toList(),
            ),
            ...expenses.map((e) => pw.TableRow(
              children: [
                DateFormat('MM/dd/yy').format(e.date),
                e.category.name,
                '₹${e.amount.toStringAsFixed(2)}',
              ].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(t))).toList(),
            ))
          ]
        )
      ]
    );
  }
}
