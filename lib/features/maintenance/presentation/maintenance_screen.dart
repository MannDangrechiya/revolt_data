import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/maintenance_provider.dart';

class MaintenanceScreen extends HookConsumerWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedLogsAsync = ref.watch(maintenanceByComponentProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Maintenance Logs')),
      body: groupedLogsAsync.when(
        data: (groupedLogs) => groupedLogs.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No maintenance logs recorded.'),
                ),
              )
            : ListView.builder(
                itemCount: groupedLogs.length,
                itemBuilder: (context, index) {
                  final entry = groupedLogs.entries.elementAt(index);
                  final component = entry.key;
                  final logs = entry.value;

                  return ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(component.name.toUpperCase(), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    children: logs.map((log) {
                      return ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.build)),
                        title: Text(log.description),
                        subtitle: Text('${DateFormat('MMM d, yyyy').format(log.date)} • ${log.odometerReading} km'),
                        trailing: Text('\$${log.cost.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/maintenance/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
