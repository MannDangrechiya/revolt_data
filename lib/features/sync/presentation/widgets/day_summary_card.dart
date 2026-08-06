import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../rides/data/rides_provider.dart';
import '../../domain/missed_ride_candidate.dart';
import '../providers/sync_engine_notifier.dart';
import 'missed_ride_review_sheet.dart';

class DaySummaryCard extends ConsumerWidget {
  const DaySummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ridesAsync = ref.watch(ridesProvider);
    final syncState = ref.watch(syncEngineNotifierProvider);

    final ridesToday = ridesAsync.when(
      data: (rides) {
        final now = DateTime.now();
        return rides.where((r) {
          final date = r.startTime ?? r.date;
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).toList();
      },
      loading: () => [],
      error: (_, _) => [],
    );

    final totalKmToday = ridesToday.fold<double>(
      0.0,
      (sum, r) => sum + (r.endOdometer - r.startOdometer).abs(),
    );

    final pendingCandidates = syncState.maybeWhen<List<MissedRideCandidate>>(
      needsReview: (candidates) => candidates,
      orElse: () => const [],
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.today, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  'First Connect of Day — Daily Summary',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Today so far: ${ridesToday.length} rides, ${totalKmToday.toStringAsFixed(1)} km',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (pendingCandidates.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Pending review: ${pendingCandidates.length} ride(s) need confirmation',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => MissedRideReviewSheet(
                            candidates: pendingCandidates,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text('Review', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
