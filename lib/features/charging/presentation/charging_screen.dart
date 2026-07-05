import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/charging_provider.dart';
import 'widgets/battery_health_dashboard.dart';

class ChargingScreen extends HookConsumerWidget {
  const ChargingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(chargingLogsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging & Battery Health'),
      ),
      body: logsAsync.when(
        data: (logs) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: BatteryHealthDashboard(),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Recent Charge Logs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (logs.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      'No charging logs yet. Tap + to add one.',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final log = logs[index];
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.electrical_services)),
                      title: Text('${log.kwhAdded.toStringAsFixed(1)} kWh • \$${log.cost.toStringAsFixed(2)}'),
                      subtitle: Text(
                        '${DateFormat('MMM d, yyyy').format(log.date)} • ${log.locationType.name.toUpperCase()}',
                      ),
                      trailing: Text('${log.startBattery}% → ${log.endBattery}%'),
                    );
                  },
                  childCount: logs.length,
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/charging/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
