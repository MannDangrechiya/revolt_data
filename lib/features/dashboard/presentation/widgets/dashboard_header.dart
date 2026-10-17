import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../ble/domain/connection_state.dart';
import '../../../ble/domain/vehicle_snapshot.dart';
import '../../../ble/presentation/widgets/connection_status_badge.dart';
import '../../../../core/widgets/animated_number.dart';
import '../../../bikes/data/bike_provider.dart';
import '../../../bikes/domain/bike.dart';
import '../../../sync/data/sync_state_service.dart';
import '../../data/dashboard_provider.dart';

class DashboardHeader extends ConsumerWidget {
  final String bikeName;
  final BleConnectionState connectionStatus;
  final num currentOdometer;
  final TelemetrySource? telemetrySource;

  const DashboardHeader({
    super.key,
    required this.bikeName,
    required this.connectionStatus,
    required this.currentOdometer,
    this.telemetrySource,
  });

  void _showCalibrateOdometerDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(
      text: currentOdometer.toStringAsFixed(1),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            void adjustBy(double delta) {
              final currentVal = double.tryParse(controller.text) ?? currentOdometer.toDouble();
              final newVal = (currentVal + delta).clamp(0.0, 999999.0);
              controller.text = newVal.toStringAsFixed(1);
              setModalState(() {});
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(LucideIcons.gauge, color: Colors.amber, size: 22),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Calibrate Odometer',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(sheetContext).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sync the app reading with your bike\'s physical instrument cluster (e.g. 19,920 km). Future trips will accumulate from this calibrated base.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Cluster Odometer Reading (km)',
                      prefixIcon: const Icon(LucideIcons.gauge),
                      suffixText: 'km',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (_) => setModalState(() {}),
                  ),
                  const SizedBox(height: 14),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ActionChip(
                          label: const Text('-10'),
                          onPressed: () => adjustBy(-10),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          label: const Text('-1'),
                          onPressed: () => adjustBy(-1),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          label: const Text('+1'),
                          onPressed: () => adjustBy(1),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          label: const Text('+10'),
                          onPressed: () => adjustBy(10),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          avatar: const Icon(LucideIcons.rotateCcw, size: 14),
                          label: const Text('19,920 km'),
                          onPressed: () {
                            controller.text = '19920.0';
                            setModalState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.check),
                      label: const Text('Save & Calibrate Baseline'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final val = double.tryParse(controller.text);
                        if (val != null && val >= 0) {
                          Navigator.of(sheetContext).pop();

                          final currentBike = await ref.read(currentBikeProvider.future);
                          if (currentBike != null) {
                            await ref.read(currentBikeProvider.notifier).updateBike(
                                  currentBike.copyWith(initialOdometer: val),
                                );
                          } else {
                            await ref.read(currentBikeProvider.notifier).saveBike(
                                  Bike(
                                    name: bikeName,
                                    brand: 'Revolt',
                                    model: 'RV400',
                                    color: 'Cosmic Black',
                                    registrationNumber: 'GJ-01-EV-400',
                                    initialOdometer: val,
                                  ),
                                );
                          }
                          final syncState = await ref.read(syncStateServiceProvider.future);
                          await syncState.setCalibratedOdometer(val);

                          ref.invalidate(dashboardDataProvider);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Odometer calibrated to ${val.toStringAsFixed(1)} km'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Semantics(
                    button: true,
                    label: 'BLE Connection Status',
                    hint: 'Navigates to BLE device screen',
                    child: GestureDetector(
                      onTap: () => context.push('/device'),
                      child: ConnectionStatusBadge(
                        state: connectionStatus,
                        source: (connectionStatus == BleConnectionState.connected ||
                                connectionStatus == BleConnectionState.authenticated)
                            ? TelemetrySource.ble
                            : (telemetrySource == TelemetrySource.cloud
                                ? TelemetrySource.cloud
                                : null),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Semantics(
                button: true,
                label: 'Bike: $bikeName',
                hint: 'Navigates to bike details',
                child: InkWell(
                  onTap: () => context.push('/bike'),
                  child: Row(
                    children: [
                      Text(
                        bikeName,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        LucideIcons.chevronRight,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Semantics(
          button: true,
          label: 'Odometer: ${currentOdometer.toStringAsFixed(1)} km',
          hint: 'Tap to calibrate with physical bike cluster',
          child: InkWell(
            onTap: () => _showCalibrateOdometerDialog(context, ref),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'ODO',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        LucideIcons.gauge,
                        size: 13,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  AnimatedNumber(
                    value: currentOdometer,
                    suffix: ' km',
                    fractionDigits: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
