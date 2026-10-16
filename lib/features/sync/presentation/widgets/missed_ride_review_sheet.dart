import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/database/database_mappers.dart';
import '../../../../core/database/database_provider.dart';
import '../../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../../rides/domain/ride.dart';
import '../../../tracking/data/ride_merger.dart';
import '../../domain/missed_ride_candidate.dart';
import '../providers/sync_engine_notifier.dart';

class MissedRideReviewSheet extends ConsumerStatefulWidget {
  final List<MissedRideCandidate> candidates;

  const MissedRideReviewSheet({
    super.key,
    required this.candidates,
  });

  @override
  ConsumerState<MissedRideReviewSheet> createState() =>
      _MissedRideReviewSheetState();
}

class _MissedRideReviewSheetState
    extends ConsumerState<MissedRideReviewSheet> {
  late List<MissedRideCandidate> _currentCandidates;
  late Map<String, TextEditingController> _distanceControllers;
  late Map<String, TextEditingController> _speedControllers;
  late Map<String, RideMode> _selectedModes;

  @override
  void initState() {
    super.initState();
    _currentCandidates = List.from(widget.candidates);
    _distanceControllers = {};
    _speedControllers = {};
    _selectedModes = {};

    for (final candidate in _currentCandidates) {
      _initCandidateFields(candidate);
    }
  }

  void _initCandidateFields(MissedRideCandidate candidate) {
    final dist = candidate.gpsDistanceKm ?? candidate.odometerDeltaKm;
    final speed = candidate.gpsMaxSpeedKmh ?? 40.0;
    _distanceControllers[candidate.id] =
        TextEditingController(text: dist.toStringAsFixed(1));
    _speedControllers[candidate.id] =
        TextEditingController(text: speed.toStringAsFixed(0));
    _selectedModes[candidate.id] = RideMode.normal;
  }

  @override
  void dispose() {
    for (final controller in _distanceControllers.values) {
      controller.dispose();
    }
    for (final controller in _speedControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveCandidate(MissedRideCandidate candidate) async {
    final distText = _distanceControllers[candidate.id]?.text ?? '0';
    final speedText = _speedControllers[candidate.id]?.text ?? '40';
    final dist = double.tryParse(distText) ?? candidate.odometerDeltaKm;
    final speed = double.tryParse(speedText) ?? 40.0;
    final mode = _selectedModes[candidate.id] ?? RideMode.normal;
    final start = candidate.estimatedStartTime;
    final end = candidate.estimatedEndTime;

    final db = ref.read(databaseProvider);
    final durationMins = end.difference(start).inMinutes.clamp(1, 1440);

    final latestRides = await (db.select(db.ridesTable)
          ..orderBy([(t) => drift.OrderingTerm(expression: t.endOdometer, mode: drift.OrderingMode.desc)])
          ..limit(1))
        .get();
    final baseOdometer = latestRides.isNotEmpty ? latestRides.first.endOdometer : 0.0;
    final startOdo = baseOdometer;
    final endOdo = baseOdometer + dist;

    final lastSnapshot = ref.read(lastKnownVehicleSnapshotProvider);
    final currentBattery = lastSnapshot?.batteryPercent ?? 100;

    final polylineJson = candidate.gpsRoute != null && candidate.gpsRoute!.isNotEmpty
        ? RideMerger.encodeRoutePolyline(candidate.gpsRoute!)
        : null;

    final ride = Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: start,
      startOdometer: startOdo,
      endOdometer: endOdo,
      batteryBefore: currentBattery,
      batteryAfter: currentBattery,
      rideMode: mode,
      roadCondition: RoadCondition.smooth,
      startTime: start,
      endTime: end,
      durationMinutes: durationMins,
      maxSpeed: speed,
      notes: 'Reviewed Missed Ride (${candidate.confidence} confidence)',
      source: candidate.dataSource,
      routePolyline: polylineJson,
    );

    await db.into(db.ridesTable).insert(ride.toCompanion());

    setState(() {
      _currentCandidates.removeWhere((c) => c.id == candidate.id);
    });

    if (_currentCandidates.isEmpty) {
      ref.read(syncEngineNotifierProvider.notifier).resetState();
      if (mounted) Navigator.of(context).pop();
    }
  }

  void _skipCandidate(MissedRideCandidate candidate) {
    setState(() {
      _currentCandidates.removeWhere((c) => c.id == candidate.id);
    });

    if (_currentCandidates.isEmpty) {
      ref.read(syncEngineNotifierProvider.notifier).resetState();
      if (mounted) Navigator.of(context).pop();
    }
  }

  void _splitCandidate(MissedRideCandidate candidate) {
    final halfDist = candidate.odometerDeltaKm / 2.0;
    final midTime = candidate.estimatedStartTime.add(
      Duration(
        minutes: candidate.estimatedEndTime
                .difference(candidate.estimatedStartTime)
                .inMinutes ~/
            2,
      ),
    );

    final c1 = candidate.copyWith(
      id: '${candidate.id}_split1',
      odometerDeltaKm: halfDist,
      estimatedEndTime: midTime,
    );
    final c2 = candidate.copyWith(
      id: '${candidate.id}_split2',
      odometerDeltaKm: halfDist,
      estimatedStartTime: midTime,
    );

    setState(() {
      final index = _currentCandidates.indexWhere((c) => c.id == candidate.id);
      if (index != -1) {
        _currentCandidates.removeAt(index);
        _currentCandidates.insert(index, c1);
        _currentCandidates.insert(index + 1, c2);
        _initCandidateFields(c1);
        _initCandidateFields(c2);
      }
    });
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
                const Icon(Icons.sync_problem, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Missed Ride Review (${_currentCandidates.length})',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'We detected unaccounted distance while disconnected. Please confirm or edit details.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ..._currentCandidates.map((candidate) => _buildCandidateCard(candidate)),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateCard(MissedRideCandidate candidate) {
    final distController = _distanceControllers[candidate.id];
    final speedController = _speedControllers[candidate.id];
    final mode = _selectedModes[candidate.id] ?? RideMode.normal;
    final hasRoute = candidate.gpsRoute != null && candidate.gpsRoute!.isNotEmpty;

    final confidenceColor = candidate.confidence == 'high'
        ? Colors.green
        : (candidate.confidence == 'medium' ? Colors.orange : Colors.red);

    return Card(
      key: ValueKey(candidate.id),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: confidenceColor,
                    radius: 5,
                  ),
                  label: Text(
                    '${candidate.confidence.toUpperCase()} CONFIDENCE',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: confidenceColor.withValues(alpha: 0.1),
                ),
                Text(
                  candidate.dataSource.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    hasRoute ? Icons.map : Icons.nature_people,
                    color: hasRoute ? Colors.blue : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hasRoute
                          ? 'GPS Route Available (${candidate.gpsRoute!.length} points)'
                          : 'No Route Data (Odometer Delta Only)',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: distController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Distance (km)',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: speedController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Max Speed (km/h)',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Mode: ', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                DropdownButton<RideMode>(
                  value: mode,
                  isDense: true,
                  items: RideMode.values.map((m) {
                    return DropdownMenuItem(
                      value: m,
                      child: Text(m.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedModes[candidate.id] = val;
                      });
                    }
                  },
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _splitCandidate(candidate),
                  icon: const Icon(Icons.call_split, size: 16),
                  label: const Text('Split Ride', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _skipCandidate(candidate),
                    child: const Text('Skip'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _saveCandidate(candidate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save Ride'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
