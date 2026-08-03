import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'dart:async';

import '../data/rides_provider.dart';
import '../domain/ride.dart';
import '../domain/ride_filter.dart';
import 'widgets/ride_card.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/error_retry_widget.dart';

class RidesScreen extends HookConsumerWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ridesAsync = ref.watch(filteredRidesProvider);
    final filter = ref.watch(rideFilterStateProvider);
    
    final searchController = useTextEditingController(text: filter.searchQuery);
    
    // Debounce search
    useEffect(() {
      Timer? timer;
      void listener() {
        if (timer?.isActive ?? false) timer!.cancel();
        timer = Timer(const Duration(milliseconds: 500), () {
          ref.read(rideFilterStateProvider.notifier).updateFilter(
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
        title: const Text('Ride Logs'),
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
                    hintText: 'Search notes, tags, locations...',
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
                      label: const Text('Favorites'),
                      selected: filter.isFavorite == true,
                      onSelected: (val) {
                        ref.read(rideFilterStateProvider.notifier).updateFilter(
                          filter.copyWith(isFavorite: val ? true : null),
                        );
                      },
                      avatar: const Icon(Icons.star, size: 16, color: Colors.amber),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Eco Mode'),
                      selected: filter.rideMode == RideMode.eco,
                      onSelected: (val) {
                        ref.read(rideFilterStateProvider.notifier).updateFilter(
                          filter.copyWith(rideMode: val ? RideMode.eco : null),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Sport Mode'),
                      selected: filter.rideMode == RideMode.sport,
                      onSelected: (val) {
                        ref.read(rideFilterStateProvider.notifier).updateFilter(
                          filter.copyWith(rideMode: val ? RideMode.sport : null),
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
      body: ridesAsync.when(
        data: (ridesList) => ridesList.isEmpty
            ? const EmptyStateWidget(
                title: 'No rides found',
                message: 'Start logging your trips to see them here.',
                icon: LucideIcons.bike,
              )
            : _buildGroupedList(context, ref, ridesList),
        loading: () => const Padding(
          padding: EdgeInsets.all(16.0),
          child: ListSkeletonLoader(itemCount: 8, itemHeight: 120),
        ),
        error: (err, stack) => ErrorRetryWidget(
          message: err.toString(),
          onRetry: () => ref.refresh(filteredRidesProvider),
        ),
      ),
      // Add action is provided by the app shell's context-aware FAB.
    );
  }

  void _showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    // Advanced filtering can be added here
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
                      ref.read(rideFilterStateProvider.notifier).updateFilter(const RideFilter());
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

  Widget _buildGroupedList(BuildContext context, WidgetRef ref, List<Ride> rides) {
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
                return Dismissible(
                  key: Key(ride.id),
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
                    final notifier = ref.read(ridesProvider.notifier);
                    notifier.removeRide(ride.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Ride deleted'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () => notifier.addRide(ride),
                        ),
                      ),
                    );
                  },
                  child: RideCard(
                    ride: ride,
                    onTap: () {
                      context.push('/rides/${ride.id}');
                    },
                    onLongPress: () {
                      _showRideOptions(context, ref, ride);
                    },
                    onFavoriteToggle: () {
                      ref.read(ridesProvider.notifier).toggleFavorite(ride.id);
                    },
                  ),
                );
              },
              childCount: entry.value.length,
            ),
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );
  }

  void _showRideOptions(BuildContext context, WidgetRef ref, Ride ride) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.copy),
              title: const Text('Duplicate Ride'),
              onTap: () {
                context.pop();
                ref.read(ridesProvider.notifier).duplicateRide(ride.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ride duplicated')),
                );
              },
            ),
            ListTile(
              leading: Icon(ride.isFavorite ? Icons.star_border : Icons.star, color: Colors.amber),
              title: Text(ride.isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
              onTap: () {
                context.pop();
                ref.read(ridesProvider.notifier).toggleFavorite(ride.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
