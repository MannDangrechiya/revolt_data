import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/widgets/not_found_widget.dart';
import '../data/rides_provider.dart';
import '../domain/ride.dart';
import 'widgets/ride_route_map_widget.dart';

class RideDetailsScreen extends ConsumerWidget {
  final String rideId;
  
  const RideDetailsScreen({super.key, required this.rideId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideAsync = ref.watch(rideByIdProvider(rideId));

    return rideAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Ride Details')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => NotFoundWidget(
        message: 'Error loading ride details: $err',
        returnRoute: '/rides',
      ),
      data: (ride) {
        if (ride == null) {
          return const NotFoundWidget(
            message: 'Ride details not found or deleted.',
            returnRoute: '/rides',
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Ride Details'),
            actions: [
              if (ride.isFavorite)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.star, color: Colors.amber),
                ),
              IconButton(
                icon: const Icon(LucideIcons.pencil),
                tooltip: 'Edit',
                onPressed: () => context.push('/rides/edit/${ride.id}'),
              ),
            ],
          ),
          body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (ride.photoPaths.isNotEmpty)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  itemCount: ride.photoPaths.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.file(
                        File(ride.photoPaths[index]),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, MMMM d, yyyy').format(ride.date),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (ride.startTime != null && ride.endTime != null)
                    Text(
                      '${DateFormat.jm().format(ride.startTime!)} - ${DateFormat.jm().format(ride.endTime!)} (${ride.durationMinutes} mins)',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  const SizedBox(height: 24),
                  
                  _buildSectionHeader('Overview', LucideIcons.activity),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildMetricCard(context, 'Distance', '${ride.distance.toStringAsFixed(1)} km', LucideIcons.navigation)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildMetricCard(context, 'Battery Used', '${ride.batteryConsumed}%', LucideIcons.batteryMedium)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSectionHeader('Route details', LucideIcons.map),
                  const SizedBox(height: 16),
                  RideRouteMapWidget(routePolylineJson: ride.routePolyline),
                  const SizedBox(height: 16),
                  _buildInfoRow('Start Odometer', '${ride.startOdometer} km'),
                  _buildInfoRow('End Odometer', '${ride.endOdometer} km'),
                  if (ride.startLocation != null) _buildInfoRow('From', ride.startLocation!),
                  if (ride.endLocation != null) _buildInfoRow('To', ride.endLocation!),
                  if (ride.routeNotes != null) _buildInfoRow('Route Notes', ride.routeNotes!),
                  const SizedBox(height: 24),

                  _buildSectionHeader('Performance', LucideIcons.gauge),
                  const SizedBox(height: 16),
                  _buildInfoRow('Ride Mode', ride.rideMode.name.toUpperCase()),
                  if (ride.averageSpeed != null) _buildInfoRow('Average Speed', '${ride.averageSpeed} km/h'),
                  if (ride.maxSpeed != null) _buildInfoRow('Max Speed', '${ride.maxSpeed} km/h'),
                  if (ride.estimatedRemainingRange != null) _buildInfoRow('Est. Remaining Range', '${ride.estimatedRemainingRange} km'),
                  const SizedBox(height: 24),

                  _buildSectionHeader('Conditions', LucideIcons.cloud),
                  const SizedBox(height: 16),
                  _buildInfoRow('Road Condition', ride.roadCondition.name.toUpperCase()),
                  if (ride.roadType != null) _buildInfoRow('Road Type', ride.roadType!),
                  if (ride.weather != null) _buildInfoRow('Weather', ride.weather!),
                  const SizedBox(height: 24),

                  if (ride.customTags.isNotEmpty || ride.notes != null || ride.ridePurpose != null || ride.passengerCount != null) ...[
                    _buildSectionHeader('Additional Information', LucideIcons.info),
                    const SizedBox(height: 16),
                    if (ride.ridePurpose != null) _buildInfoRow('Purpose', ride.ridePurpose!),
                    if (ride.passengerCount != null) _buildInfoRow('Passengers', ride.passengerCount.toString()),
                    if (ride.customTags.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(flex: 2, child: Text('Tags', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))),
                            Expanded(
                              flex: 3,
                              child: Wrap(
                                spacing: 8,
                                alignment: WrapAlignment.end,
                                children: ride.customTags.map((tag) => Chip(label: Text(tag), padding: EdgeInsets.zero)).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (ride.notes != null) _buildInfoRow('Notes', ride.notes!),
                    const SizedBox(height: 24),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
