import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../shared/ui/volt_app_bar.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';

/// Live 15A Household Charging Monitor with ETA, Cost in ₹, and 80% Longevity Alert
class HomeChargingScreen extends ConsumerStatefulWidget {
  const HomeChargingScreen({super.key});

  @override
  ConsumerState<HomeChargingScreen> createState() => _HomeChargingScreenState();
}

class _HomeChargingScreenState extends ConsumerState<HomeChargingScreen> {
  double _electricityTariffPerKwh = 6.50; // Gujarat UGVCL / Torrent Power residential default
  bool _notifyAt80Percent = true;

  @override
  Widget build(BuildContext context) {
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
    final persistedSnapshot = ref.watch(persistedVehicleSnapshotProvider).value;

    final snapshot = liveSnapshot ?? lastSnapshot ?? persistedSnapshot;

    final currentSoc = snapshot?.batteryPercent ?? 65;
    final voltage = snapshot?.batteryVoltage ?? 72.4;
    final current = snapshot?.batteryCurrent ?? 8.5; // positive or negative
    final isCharging = current.abs() > 0.5 || (snapshot?.batteryCurrent != null && snapshot!.batteryCurrent! > 0);

    // RV400 3.24 kWh pack charges at ~0.8 kWh/hour on 15A socket (~25% SOC per hour)
    final socLeftTo80 = (80 - currentSoc).clamp(0, 80);
    final socLeftTo100 = (100 - currentSoc).clamp(0, 100);

    final minsTo80 = (socLeftTo80 * 2.4).round(); // ~2.4 mins per 1% SOC
    final minsTo100 = (socLeftTo100 * 2.5).round();

    final hoursTo80 = minsTo80 ~/ 60;
    final remainingMins80 = minsTo80 % 60;

    final hoursTo100 = minsTo100 ~/ 60;
    final remainingMins100 = minsTo100 % 60;

    // Energy needed & Cost Calculation
    final kwhNeededToFull = (socLeftTo100 / 100.0) * 3.24;
    final kwhNeededTo80 = (socLeftTo80 / 100.0) * 3.24;
    final sessionCostRs = kwhNeededToFull * _electricityTariffPerKwh;
    final costTo80Rs = kwhNeededTo80 * _electricityTariffPerKwh;
    final dailyCommuteChargeCostRs = (55.0 / 150.0 * 3.24) * _electricityTariffPerKwh; // ~₹13.00 for 55 km
    final monthlyIceSavings = (105.0 - dailyCommuteChargeCostRs) * 26; // ~₹2,400 monthly savings vs petrol

    final chargingPowerKw = (voltage * current.abs() / 1000.0).clamp(0.0, 1.2);

    return Scaffold(
      appBar: VoltAppBar(
        title: '15A Home Charging',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw),
            tooltip: 'Refresh Status',
            onPressed: () async {
              HapticFeedback.lightImpact();
              await ref.read(telemetryRepositoryProvider).refreshCloudTelemetry();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Charging telematics refreshed.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Live Charging Hero Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    isCharging ? Colors.teal.shade900 : Theme.of(context).colorScheme.primaryContainer,
                    isCharging ? Colors.teal.shade800 : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: isCharging
                    ? [
                        BoxShadow(
                          color: Colors.teal.withValues(alpha: 0.3),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
                border: Border.all(
                  color: isCharging ? Colors.teal : Colors.grey.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCharging ? LucideIcons.plugZap : LucideIcons.plug,
                            color: isCharging ? Colors.greenAccent : Colors.grey,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isCharging ? '15A AC SOCKET CHARGING' : 'CHARGER STANDBY',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          isCharging ? '${chargingPowerKw.toStringAsFixed(2)} kW' : 'Idle',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          value: (currentSoc / 100.0).clamp(0.0, 1.0),
                          strokeWidth: 14,
                          backgroundColor: Colors.white12,
                          color: currentSoc >= 80 ? Colors.greenAccent : Colors.tealAccent,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$currentSoc%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            isCharging ? 'Charging Live' : 'Current SOC',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHeroStat(
                        label: 'Pack Voltage',
                        value: '${voltage.toStringAsFixed(1)} V',
                        icon: LucideIcons.activity,
                      ),
                      _buildHeroStat(
                        label: 'AC Current',
                        value: '${current.abs().toStringAsFixed(1)} A',
                        icon: LucideIcons.zap,
                      ),
                      _buildHeroStat(
                        label: 'Standard Charger',
                        value: '72V 15A',
                        icon: LucideIcons.shieldCheck,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Time Remaining Countdown Card
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
                    const Text(
                      'Charging Time Remaining (Estimated)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.teal.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(LucideIcons.batteryCharging, size: 16, color: Colors.teal),
                                    SizedBox(width: 6),
                                    Text(
                                      'Target 80% (Ideal)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  currentSoc >= 80 ? 'Reached!' : '${hoursTo80}h ${remainingMins80}m',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Protects cell longevity',
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(LucideIcons.batteryFull, size: 16, color: Colors.blue),
                                    SizedBox(width: 6),
                                    Text(
                                      'Target 100% (Full)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  currentSoc >= 100 ? 'Fully Charged' : '${hoursTo100}h ${remainingMins100}m',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Maximum riding range',
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Notify when battery hits 80%',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        Switch(
                          value: _notifyAt80Percent,
                          activeTrackColor: Colors.teal,
                          activeThumbColor: Colors.white,
                          onChanged: (val) {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _notifyAt80Percent = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Electricity Cost & Petrol Savings Calculator Card
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
                          'Electricity Cost & Savings',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹${_electricityTariffPerKwh.toStringAsFixed(1)} / unit',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Slider(
                      value: _electricityTariffPerKwh.clamp(4.0, 15.0),
                      min: 4.0,
                      max: 15.0,
                      divisions: 22,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        setState(() {
                          _electricityTariffPerKwh = val;
                        });
                      },
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ChoiceChip(
                            label: const Text('Gujarat (₹6.5/u)', style: TextStyle(fontSize: 11)),
                            selected: (_electricityTariffPerKwh - 6.5).abs() < 0.1,
                            onSelected: (_) => setState(() => _electricityTariffPerKwh = 6.5),
                          ),
                          const SizedBox(width: 6),
                          ChoiceChip(
                            label: const Text('Delhi (₹4.5/u)', style: TextStyle(fontSize: 11)),
                            selected: (_electricityTariffPerKwh - 4.5).abs() < 0.1,
                            onSelected: (_) => setState(() => _electricityTariffPerKwh = 4.5),
                          ),
                          const SizedBox(width: 6),
                          ChoiceChip(
                            label: const Text('Maharashtra (₹8.5/u)', style: TextStyle(fontSize: 11)),
                            selected: (_electricityTariffPerKwh - 8.5).abs() < 0.1,
                            onSelected: (_) => setState(() => _electricityTariffPerKwh = 8.5),
                          ),
                          const SizedBox(width: 6),
                          ChoiceChip(
                            label: const Text('Commercial (₹12/u)', style: TextStyle(fontSize: 11)),
                            selected: (_electricityTariffPerKwh - 12.0).abs() < 0.1,
                            onSelected: (_) => setState(() => _electricityTariffPerKwh = 12.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Night Charging Coach routine panel (8:30 PM - 10:30 PM @ 80%)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(LucideIcons.moon, size: 16, color: Colors.tealAccent),
                              SizedBox(width: 6),
                              Text(
                                'Night 15A Home Charging Coach (8:30 – 10:30 PM)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.tealAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Charge to 80% cutoff for cell longevity. Daily 55 km commute recharge consumes ~2.0 units (₹${dailyCommuteChargeCostRs.toStringAsFixed(1)}/day) saving ~₹${monthlyIceSavings.toStringAsFixed(0)}/month compared to petrol.',
                            style: const TextStyle(fontSize: 11, color: Colors.white70, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCostColumn(
                          label: 'Cost to 80%',
                          value: '₹${costTo80Rs.toStringAsFixed(1)}',
                          subtext: '${kwhNeededTo80.toStringAsFixed(2)} units',
                          color: Colors.teal,
                        ),
                        Container(width: 1, height: 40, color: Colors.grey.withValues(alpha: 0.3)),
                        _buildCostColumn(
                          label: 'Cost to 100%',
                          value: '₹${sessionCostRs.toStringAsFixed(1)}',
                          subtext: '${kwhNeededToFull.toStringAsFixed(2)} units',
                          color: Colors.green,
                        ),
                        Container(width: 1, height: 40, color: Colors.grey.withValues(alpha: 0.3)),
                        _buildCostColumn(
                          label: 'Monthly Savings',
                          value: '₹${monthlyIceSavings.toStringAsFixed(0)}',
                          subtext: 'vs ₹105/day ICE',
                          color: Colors.orange,
                        ),
                      ],
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

  Widget _buildHeroStat({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildCostColumn({
    required String label,
    required String value,
    required String subtext,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          subtext,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
