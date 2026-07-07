import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:async';

import '../data/charging_provider.dart';
import '../domain/charge_log.dart';
import '../domain/charge_filter.dart';
import 'widgets/battery_health_dashboard.dart';
import 'widgets/charge_card.dart';

class ChargingScreen extends HookConsumerWidget {
  const ChargingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(filteredChargeLogsProvider);
    final filter = ref.watch(chargeFilterStateProvider);
    
    final searchController = useTextEditingController(text: filter.searchQuery);
    
    // Debounce search
    useEffect(() {
      Timer? timer;
      void listener() {
        if (timer?.isActive ?? false) timer!.cancel();
        timer = Timer(const Duration(milliseconds: 500), () {
          ref.read(chargeFilterStateProvider.notifier).updateFilter(
            filter.copyWith(searchQuery: searchController.text),
          );
        });
      }
      searchController.addListener(listener);
      return () {
        searchController.removeListener(listener);
        timer?.cancel();
      };
    }, [searchController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Logs'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.filter),
            onPressed: () => _showFilterBottomSheet(context, ref),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search locations, notes...',
                    prefixIcon: const Icon(LucideIcons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(LucideIcons.x),
                            onPressed: () {
                              searchController.clear();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Home'),
                      selected: filter.locationType == LocationType.home,
                      onSelected: (val) {
                        ref.read(chargeFilterStateProvider.notifier).updateFilter(
                          filter.copyWith(locationType: val ? LocationType.home : null),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Public'),
                      selected: filter.locationType == LocationType.public,
                      onSelected: (val) {
                        ref.read(chargeFilterStateProvider.notifier).updateFilter(
                          filter.copyWith(locationType: val ? LocationType.public : null),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Work'),
                      selected: filter.locationType == LocationType.work,
                      onSelected: (val) {
                        ref.read(chargeFilterStateProvider.notifier).updateFilter(
                          filter.copyWith(locationType: val ? LocationType.work : null),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: logsAsync.when(
        data: (logs) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
                  'Charge Logs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (logs.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(LucideIcons.batteryCharging, size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'No logs found.',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final log = logs[index];
                    return Dismissible(
                      key: Key(log.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(LucideIcons.trash2, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        final notifier = ref.read(chargingLogsProvider.notifier);
                        notifier.removeChargeLog(log.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Log deleted'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () => notifier.addChargeLog(log),
                            ),
                          ),
                        );
                      },
                      child: ChargeCard(
                        log: log,
                        onTap: () {
                          context.push('/charging/details', extra: log);
                        },
                      ),
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
        child: const Icon(LucideIcons.plus),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Advanced Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(chargeFilterStateProvider.notifier).updateFilter(const ChargeFilter());
                      context.pop();
                    },
                    child: const Text('Reset All'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => context.pop(),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
