import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/database/database_mappers.dart';
import '../../../../core/database/database_provider.dart';
import '../../../rides/domain/ride.dart';
import '../../domain/sync_conflict.dart';
import '../providers/sync_engine_notifier.dart';

class ConflictResolverSheet extends ConsumerStatefulWidget {
  final List<SyncConflict> conflicts;

  const ConflictResolverSheet({
    super.key,
    required this.conflicts,
  });

  @override
  ConsumerState<ConflictResolverSheet> createState() =>
      _ConflictResolverSheetState();
}

class _ConflictResolverSheetState
    extends ConsumerState<ConflictResolverSheet> {
  late List<SyncConflict> _conflicts;

  @override
  void initState() {
    super.initState();
    _conflicts = List.from(widget.conflicts);
  }

  Future<void> _handleKeepBoth(SyncConflict conflict) async {
    final db = ref.read(databaseProvider);
    final cand = conflict.newCandidate;
    final newRide = Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: cand.estimatedStartTime,
      startOdometer: 0.0,
      endOdometer: cand.odometerDeltaKm,
      batteryBefore: 100,
      batteryAfter: 100,
      rideMode: RideMode.normal,
      roadCondition: RoadCondition.smooth,
      startTime: cand.estimatedStartTime,
      endTime: cand.estimatedEndTime,
      durationMinutes: cand.estimatedEndTime.difference(cand.estimatedStartTime).inMinutes,
      source: cand.dataSource,
      notes: 'Conflict Resolved: Kept both',
    );

    await db.into(db.ridesTable).insert(newRide.toCompanion());
    _resolveOne(conflict);
  }

  Future<void> _handleKeepExisting(SyncConflict conflict) async {
    _resolveOne(conflict);
  }

  Future<void> _handleReplaceWithNew(SyncConflict conflict) async {
    final db = ref.read(databaseProvider);
    final cand = conflict.newCandidate;

    // Delete existing
    await (db.delete(db.ridesTable)..where((t) => t.id.equals(conflict.existingRide.id))).go();

    // Insert new
    final newRide = conflict.existingRide.copyWith(
      date: cand.estimatedStartTime,
      endOdometer: conflict.existingRide.startOdometer + cand.odometerDeltaKm,
      startTime: cand.estimatedStartTime,
      endTime: cand.estimatedEndTime,
      source: cand.dataSource,
      notes: 'Conflict Resolved: Replaced with new',
    );

    await db.into(db.ridesTable).insert(newRide.toCompanion());
    _resolveOne(conflict);
  }

  Future<void> _handleMerge(SyncConflict conflict) async {
    final db = ref.read(databaseProvider);
    final existing = conflict.existingRide;
    final cand = conflict.newCandidate;

    final mergedRide = existing.copyWith(
      maxSpeed: (existing.maxSpeed != null && cand.gpsMaxSpeedKmh != null)
          ? (existing.maxSpeed! > cand.gpsMaxSpeedKmh! ? existing.maxSpeed : cand.gpsMaxSpeedKmh)
          : (existing.maxSpeed ?? cand.gpsMaxSpeedKmh),
      source: 'merged',
      notes: 'Conflict Resolved: Merged data (${existing.notes ?? ""})',
    );

    await db.update(db.ridesTable).replace(mergedRide.toCompanion());
    _resolveOne(conflict);
  }

  void _resolveOne(SyncConflict conflict) {
    setState(() {
      _conflicts.removeWhere((c) => c.conflictId == conflict.conflictId);
    });

    if (_conflicts.isEmpty) {
      ref.read(syncEngineNotifierProvider.notifier).resetState();
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                const SizedBox(width: 8),
                Text(
                  'Conflict Resolution (${_conflicts.length})',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'We found ${_conflicts.length} ride(s) that might be duplicates or overlap.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ..._conflicts.map((conflict) => _buildConflictCard(conflict)),
          ],
        ),
      ),
    );
  }

  Widget _buildConflictCard(SyncConflict conflict) {
    final existing = conflict.existingRide;
    final candidate = conflict.newCandidate;

    return Card(
      key: ValueKey(conflict.conflictId),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conflict Type: ${conflict.type.name.replaceAll('_', ' ').toUpperCase()}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'EXISTING RIDE',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        Text('Date: ${existing.date.toIso8601String().substring(0, 10)}'),
                        Text('Dist: ${(existing.endOdometer - existing.startOdometer).toStringAsFixed(1)} km'),
                        Text('Source: ${existing.source}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NEW CANDIDATE',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const Divider(),
                        Text('Date: ${candidate.estimatedStartTime.toIso8601String().substring(0, 10)}'),
                        Text('Dist: ${candidate.odometerDeltaKm.toStringAsFixed(1)} km'),
                        Text('Source: ${candidate.dataSource}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _handleMerge(conflict),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Merge'),
                ),
                OutlinedButton(
                  onPressed: () => _handleKeepExisting(conflict),
                  child: const Text('Keep Existing'),
                ),
                OutlinedButton(
                  onPressed: () => _handleReplaceWithNew(conflict),
                  child: const Text('Replace with New'),
                ),
                TextButton(
                  onPressed: () => _handleKeepBoth(conflict),
                  child: const Text('Keep Both'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
