import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/maintenance_provider.dart';
import '../domain/maintenance_log.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../shared/ui/empty_state.dart';
import '../../../shared/ui/error_widget.dart';

class MaintenanceScreen extends HookConsumerWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(maintenanceLogsProvider);
    Theme.of(context);

    final searchQuery = useState('');
    final selectedComponent = useState<MaintenanceComponent?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _FilterSheet(
                  currentFilter: selectedComponent.value,
                  onFilterChanged: (val) {
                    selectedComponent.value = val;
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: logsAsync.when(
        data: (logs) {
          final filteredLogs = logs.where((log) {
            final matchesQuery =
                log.description.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ) ||
                (log.notes?.toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ) ??
                    false);
            final matchesComponent =
                selectedComponent.value == null ||
                log.component == selectedComponent.value;
            return matchesQuery && matchesComponent;
          }).toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search logs...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    onChanged: (v) => searchQuery.value = v,
                  ),
                ),
              ),
              if (selectedComponent.value != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ActionChip(
                        label: Text('Filter: ${selectedComponent.value!.name}'),
                        onPressed: () => selectedComponent.value = null,
                        avatar: const Icon(Icons.close, size: 16),
                      ),
                    ),
                  ),
                ),
              if (filteredLogs.isEmpty)
                const SliverToBoxAdapter(
                  child: EmptyState(
                    title: 'No maintenance logs found',
                    message:
                        'Record maintenance events to keep track of your bike health.',
                    icon: Icons.build,
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final log = filteredLogs[index];
                    return ExpansionTile(
                      leading: const CircleAvatar(child: Icon(Icons.build)),
                      title: Text(
                        log.description,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${DateFormat('MMM d, yyyy').format(log.date)} • ${log.odometerReading} km',
                      ),
                      trailing: Text(
                        '₹${log.cost.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (log.serviceCenter != null)
                                Text('Center: ${log.serviceCenter}'),
                              if (log.technician != null)
                                Text('Technician: ${log.technician}'),
                              if (log.partsReplaced != null)
                                Text('Parts Replaced: ${log.partsReplaced}'),
                              if (log.nextServiceDueOdometer != null)
                                Text(
                                  'Next Service Due: ${log.nextServiceDueOdometer} km',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              if (log.warrantyClaim)
                                const Text(
                                  'Warranty Claim: Yes',
                                  style: TextStyle(color: Colors.green),
                                ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: [
                                  if (log.tyres)
                                    const Chip(
                                      label: Text('Tyres'),
                                      padding: EdgeInsets.zero,
                                    ),
                                  if (log.brakes)
                                    const Chip(
                                      label: Text('Brakes'),
                                      padding: EdgeInsets.zero,
                                    ),
                                  if (log.battery)
                                    const Chip(
                                      label: Text('Battery'),
                                      padding: EdgeInsets.zero,
                                    ),
                                  if (log.suspension)
                                    const Chip(
                                      label: Text('Suspension'),
                                      padding: EdgeInsets.zero,
                                    ),
                                  if (log.motor)
                                    const Chip(
                                      label: Text('Motor'),
                                      padding: EdgeInsets.zero,
                                    ),
                                  if (log.lights)
                                    const Chip(
                                      label: Text('Lights'),
                                      padding: EdgeInsets.zero,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Edit'),
                                    onPressed: () {
                                      context.push('/maintenance/edit/${log.id}');
                                    },
                                  ),
                                  TextButton.icon(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      ref
                                          .read(maintenanceLogsProvider.notifier)
                                          .removeLog(log.id);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }, childCount: filteredLogs.length),
                ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
            ],
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(16.0),
          child: ListSkeletonLoader(itemCount: 5, itemHeight: 80),
        ),
        error: (e, st) => VoltErrorWidget(
          message: e.toString(),
          onRetry: () => ref.refresh(maintenanceLogsProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/maintenance/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final MaintenanceComponent? currentFilter;
  final ValueChanged<MaintenanceComponent?> onFilterChanged;

  const _FilterSheet({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter by Component',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: currentFilter == null,
                onSelected: (s) {
                  if (s) onFilterChanged(null);
                },
              ),
              ...MaintenanceComponent.values.map(
                (c) => ChoiceChip(
                  label: Text(c.name.toUpperCase()),
                  selected: currentFilter == c,
                  onSelected: (s) {
                    if (s) onFilterChanged(c);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
