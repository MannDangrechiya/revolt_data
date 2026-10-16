import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../ble/domain/vehicle_snapshot.dart';
import '../../domain/dashboard_data.dart';
import '../../../../core/widgets/animated_number.dart';

class BatteryStatusCard extends StatelessWidget {
  final DashboardData data;
  final bool isConnected;

  const BatteryStatusCard({
    super.key,
    required this.data,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    final liveSnapshot = data.liveSnapshot;
    final isCloudActive = !isConnected &&
        liveSnapshot != null &&
        liveSnapshot.source == TelemetrySource.cloud;
    final hasLiveTelematics = isConnected || isCloudActive;

    final batteryPercent = (hasLiveTelematics &&
            liveSnapshot != null &&
            liveSnapshot.batteryPercent != null)
        ? liveSnapshot.batteryPercent!
        : data.latestBatteryPercentage;

    // Direct telemetry range when connected or cloud; manual log calculation without multiplier when disconnected.
    final rangeValue = (hasLiveTelematics &&
            liveSnapshot != null &&
            liveSnapshot.range != null)
        ? liveSnapshot.range!
        : batteryPercent.toDouble();

    final speedValue = (hasLiveTelematics &&
            liveSnapshot != null &&
            liveSnapshot.speed != null)
        ? liveSnapshot.speed!
        : 0.0;

    Color batteryColor;
    if (batteryPercent > 50) {
      batteryColor = Colors.green;
    } else if (batteryPercent > 20) {
      batteryColor = Colors.orange;
    } else {
      batteryColor = Colors.red;
    }

    final borderColor = isConnected
        ? Colors.green
        : (isCloudActive
            ? Colors.blue
            : Theme.of(context).colorScheme.primary.withValues(alpha: 0.2));

    final healthValue = liveSnapshot?.batteryHealth;
    final healthText = healthValue != null && healthValue > 0
        ? '$healthValue%'
        : (hasLiveTelematics ? 'N/A' : 'Connect for health');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
          width: hasLiveTelematics ? 2 : 1,
        ),
        boxShadow: isConnected
            ? [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.25),
                  blurRadius: 14,
                  spreadRadius: 2,
                )
              ]
            : (isCloudActive
                ? [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.25),
                      blurRadius: 14,
                      spreadRadius: 2,
                    )
                  ]
                : null),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Battery & Range',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isConnected
                        ? Container(
                            key: const ValueKey('live_chip'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.radio,
                                    size: 10, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'LIVE BLE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : (isCloudActive
                            ? Container(
                                key: const ValueKey('cloud_chip'),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade700,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(LucideIcons.cloud,
                                        size: 10, color: Colors.white),
                                    SizedBox(width: 4),
                                    Text(
                                      '4G CLOUD',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                key: const ValueKey('est_chip'),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade800,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'ESTIMATED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                  ),
                ],
              ),
              if (isConnected && liveSnapshot != null)
                Text(
                  'Mode: ${liveSnapshot.formattedRideMode}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      AnimatedNumber(
                        value: batteryPercent,
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: batteryColor,
                          height: 1,
                        ),
                      ),
                      Text(
                        '%',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: batteryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Battery Charge',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              if (isConnected)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedNumber(
                      value: speedValue,
                      suffix: ' km/h',
                      fractionDigits: 1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Live Speed',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedNumber(
                    value: rangeValue,
                    suffix: ' km',
                    fractionDigits: 0,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Est. Range',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          if (isConnected && liveSnapshot != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Batt: ${liveSnapshot.batteryTemp}°C  •  Motor: ${liveSnapshot.motorTemp}°C',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Health: $healthText',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Align(
              key: ValueKey(isConnected),
              alignment: Alignment.centerLeft,
              child: Text(
                isConnected
                    ? '• Connected to RV400 via BLE Telemetry Stream'
                    : '• Disconnected — Last updated from manual log history',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isConnected ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
