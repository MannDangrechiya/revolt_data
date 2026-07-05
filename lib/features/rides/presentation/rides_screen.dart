import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/rides_provider.dart';
import '../domain/ride.dart';
import 'widgets/ride_card.dart';

class RidesScreen extends HookConsumerWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rides = ref.watch(filteredRidesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter bottom sheet
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filtering coming soon')),
              );
            },
          ),
        ],
      ),
      body: rides.when(
        data: (ridesList) => ridesList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_bike, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'No rides logged yet.',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 8),
                    const Text('Tap the + button to add your first ride.'),
                  ],
                ),
              )
            : _buildGroupedList(ridesList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/rides/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGroupedList(List<Ride> rides) {
    // Group rides by month/year
    final groupedRides = <String, List<Ride>>{};
    for (final ride in rides) {
      final key = DateFormat('MMMM yyyy').format(ride.date);
      groupedRides.putIfAbsent(key, () => []).add(ride);
    }

    return CustomScrollView(
      slivers: [
        for (final entry in groupedRides.entries) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final ride = entry.value[index];
                return RideCard(
                  ride: ride,
                  onTap: () {
                    // Navigate to details if needed
                  },
                );
              },
              childCount: entry.value.length,
            ),
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 80)), // FAB padding
      ],
    );
  }
}
