import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../shared/ui/volt_app_bar.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';

/// Smart Round-Trip Range & Reachability Planner for Revolt RV400
class RangePlannerScreen extends ConsumerStatefulWidget {
  const RangePlannerScreen({super.key});

  @override
  ConsumerState<RangePlannerScreen> createState() => _RangePlannerScreenState();
}

class _RangePlannerScreenState extends ConsumerState<RangePlannerScreen> {
  double _oneWayDistanceKm = 25.0;
  bool _isRoundTrip = true;
  final TextEditingController _distanceController = TextEditingController(text: '25');

  @override
  void dispose() {
    _distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
    final persistedSnapshot = ref.watch(persistedVehicleSnapshotProvider).value;

    final snapshot = liveSnapshot ?? lastSnapshot ?? persistedSnapshot;
    final currentSoc = snapshot?.batteryPercent ?? 85;

    final totalTripKm = _isRoundTrip ? _oneWayDistanceKm * 2 : _oneWayDistanceKm;

    // Real-world RV400 consumption models (3.24 kWh pack):
    // Eco: ~1.4 km per 1% SOC (Max range ~140 km)
    // Normal: ~1.0 km per 1% SOC (Max range ~100 km)
    // Sport: ~0.75 km per 1% SOC (Max range ~75 km)
    final ecoSocNeeded = (totalTripKm / 1.4).round();
    final normalSocNeeded = (totalTripKm / 1.0).round();
    final sportSocNeeded = (totalTripKm / 0.75).round();

    final ecoArrivalSoc = currentSoc - ecoSocNeeded;
    final normalArrivalSoc = currentSoc - normalSocNeeded;
    final sportArrivalSoc = currentSoc - sportSocNeeded;

    // Feasibility status based on Normal mode
    final bool canCompleteComfortably = normalArrivalSoc >= 15;
    final bool canCompleteEcoOnly = !canCompleteComfortably && ecoArrivalSoc >= 10;
    final bool cannotComplete = ecoArrivalSoc < 10;

    return Scaffold(
      appBar: const VoltAppBar(
        title: 'Smart Range Planner',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Battery Status Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.batteryMedium, color: Colors.green, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Battery',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            '$currentSoc%',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Pack Capacity',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '3.24 kWh',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Distance & Round Trip Configuration Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Destination Distance',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_oneWayDistanceKm.toStringAsFixed(0)} km one-way',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Slider(
                      value: _oneWayDistanceKm.clamp(5.0, 100.0),
                      min: 5.0,
                      max: 100.0,
                      divisions: 95,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() {
                          _oneWayDistanceKm = val;
                          _distanceController.text = val.toStringAsFixed(0);
                        });
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('5 km', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        Text('50 km', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        Text('100 km', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Calculate Round Trip',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(
                              'Includes return journey without destination charging',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                        Switch(
                          value: _isRoundTrip,
                          activeTrackColor: Colors.teal,
                          activeThumbColor: Colors.white,
                          onChanged: (val) {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _isRoundTrip = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Overall Feasibility Verdict Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cannotComplete
                    ? Colors.red.shade900
                    : (canCompleteEcoOnly ? Colors.amber.shade900 : Colors.teal.shade900),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (cannotComplete
                            ? Colors.red
                            : (canCompleteEcoOnly ? Colors.amber : Colors.teal))
                        .withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    cannotComplete
                        ? LucideIcons.triangleAlert
                        : (canCompleteEcoOnly ? LucideIcons.alertCircle : LucideIcons.checkCircle),
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cannotComplete
                              ? 'INSUFFICIENT BATTERY'
                              : (canCompleteEcoOnly
                                  ? 'FEASIBLE IN ECO MODE ONLY'
                                  : 'SAFE FOR TOTAL TRIP (${totalTripKm.toStringAsFixed(0)} KM)'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cannotComplete
                              ? 'You need more battery. Plug into a 15A socket before leaving.'
                              : (canCompleteEcoOnly
                                  ? 'Normal mode will run out. Ride at 45 km/h in Eco or carry your 15A charger.'
                                  : 'You will return home with ~$normalArrivalSoc% battery in Normal mode.'),
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Mode-by-Mode Projection Cards
            const Text(
              'Mode-by-Mode Projections',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildModeProjectionCard(
              context,
              modeName: 'Eco Mode (Max 45 km/h)',
              consumptionRate: '1.4 km / 1% SOC',
              batteryNeededPct: ecoSocNeeded,
              remainingPct: ecoArrivalSoc,
              color: Colors.green,
              recommended: canCompleteEcoOnly || canCompleteComfortably,
            ),
            const SizedBox(height: 10),

            _buildModeProjectionCard(
              context,
              modeName: 'Normal Mode (Max 65 km/h)',
              consumptionRate: '1.0 km / 1% SOC',
              batteryNeededPct: normalSocNeeded,
              remainingPct: normalArrivalSoc,
              color: Colors.blue,
              recommended: canCompleteComfortably,
            ),
            const SizedBox(height: 10),

            _buildModeProjectionCard(
              context,
              modeName: 'Sport Mode (Max 85 km/h)',
              consumptionRate: '0.75 km / 1% SOC',
              batteryNeededPct: sportSocNeeded,
              remainingPct: sportArrivalSoc,
              color: Colors.orange,
              recommended: false,
            ),

            const SizedBox(height: 20),

            // Portable 15A Charger Reminder Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(LucideIcons.plug, color: Colors.blue, size: 26),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RV400 Portable 15A Charger Tip',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'If your destination has any standard 3-pin 15A socket, carrying your portable charger gives you ~25% battery (~25 km) per hour of charging.',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildModeProjectionCard(
    BuildContext context, {
    required String modeName,
    required String consumptionRate,
    required int batteryNeededPct,
    required int remainingPct,
    required Color color,
    required bool recommended,
  }) {
    final bool canFinish = remainingPct >= 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: recommended
              ? color
              : Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: recommended ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    modeName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              if (recommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Energy needed: ~$batteryNeededPct% SOC',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                canFinish ? 'Remaining: $remainingPct%' : 'Deficit: ${remainingPct.abs()}% short',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: canFinish ? (remainingPct > 20 ? Colors.green : Colors.orange) : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
