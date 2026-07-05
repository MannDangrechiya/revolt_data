import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/report_generator.dart';
import '../../charging/data/battery_health_provider.dart';
import '../../charging/data/charging_provider.dart';
import '../../expenses/data/expenses_provider.dart';
import '../../maintenance/data/maintenance_provider.dart';
import '../../rides/data/rides_provider.dart';
import '../../rides/domain/ride.dart';
import 'widgets/efficiency_chart.dart';
import 'widgets/expense_breakdown_chart.dart';
import 'widgets/monthly_mileage_chart.dart';

class AnalyticsScreen extends HookConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Export as PDF',
            onPressed: () async {
              try {
                final rides = await ref.read(ridesProvider.future);
                final totalDistance = rides.fold(0.0, (sum, r) => sum + r.distance);
                final totalExpenses = await ref.read(totalExpensesProvider.future);
                final totalChargeCycles = await ref.read(totalChargeCyclesProvider.future);
                final maintenanceLogs = await ref.read(maintenanceLogsProvider.future);

                await ReportGeneratorService.generateAndSharePdf(
                  totalDistance: totalDistance,
                  totalExpenses: totalExpenses,
                  totalChargeCycles: totalChargeCycles,
                  maintenanceLogs: maintenanceLogs,
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to generate PDF: $e')));
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.table_chart),
            tooltip: 'Export as CSV',
            onPressed: () async {
              try {
                await ReportGeneratorService.generateAndShareCsv(
                  rides: await ref.read(ridesProvider.future),
                  expenses: await ref.read(expensesProvider.future),
                  maintenanceLogs: await ref.read(maintenanceLogsProvider.future),
                  chargingLogs: await ref.read(chargingLogsProvider.future),
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to generate CSV: $e')));
                }
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          MonthlyMileageChart(),
          SizedBox(height: 16),
          EfficiencyChart(),
          SizedBox(height: 16),
          ExpenseBreakdownChart(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
