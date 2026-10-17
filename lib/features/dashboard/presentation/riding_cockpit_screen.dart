import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../ble/presentation/providers/ble_connection_provider.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../../ble/domain/connection_state.dart';

/// Full-screen high-contrast OLED riding cockpit designed for handlebar phone mounts.
/// Keeps screen awake with WakelockPlus, displays giant speed typography, live power &
/// regenerative braking rates (kW), multi-mode range estimates, and thermal safety meters.
class RidingCockpitScreen extends ConsumerStatefulWidget {
  const RidingCockpitScreen({super.key});

  @override
  ConsumerState<RidingCockpitScreen> createState() => _RidingCockpitScreenState();
}

class _RidingCockpitScreenState extends ConsumerState<RidingCockpitScreen> {
  DateTime _sessionStartTime = DateTime.now();
  Timer? _sessionTimer;
  Duration _elapsedTime = Duration.zero;
  double _sessionMaxSpeed = 0.0;

  @override
  void initState() {
    super.initState();
    // Keep device screen active while in cockpit handlebar mode
    try {
      WakelockPlus.enable();
    } catch (_) {}

    _sessionStartTime = DateTime.now();
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedTime = DateTime.now().difference(_sessionStartTime);
        });
      }
    });
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    try {
      WakelockPlus.disable();
    } catch (_) {}
    super.dispose();
  }

  Color _getSpeedColor(double speed) {
    if (speed < 35.0) {
      return const Color(0xFF10B981); // Emerald Green
    } else if (speed <= 60.0) {
      return const Color(0xFFF59E0B); // Amber Orange
    } else {
      return const Color(0xFFEF4444); // Crimson Red
    }
  }

  String _getSpeedZoneLabel(double speed) {
    if (speed < 35.0) {
      return 'ECO CRUISING';
    } else if (speed <= 60.0) {
      return 'CITY COMMUTE';
    } else {
      return 'SPORT HIGH SPEED';
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showQuickSoundSelector(BuildContext context) {
    final bleRepo = ref.read(bleRepositoryProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111827),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Revolt Exhaust Sound',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSoundChip('Revolt', 'SOUND0#', bleRepo),
                  _buildSoundChip('Roar', 'SOUND1#', bleRepo),
                  _buildSoundChip('Rebel', 'SOUND2#', bleRepo),
                  _buildSoundChip('Rage', 'SOUND3#', bleRepo),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSoundChip(String label, String command, dynamic bleRepo) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        bleRepo.sendCommand(command);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Switched to $label sound profile'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);
    final snapshot = liveSnapshot ?? lastSnapshot;
    final effectiveOdo = snapshot?.odometer;

    final currentSpeed = snapshot?.speed ?? 0.0;
    if (currentSpeed > _sessionMaxSpeed) {
      _sessionMaxSpeed = currentSpeed;
    }

    final batteryPercent = snapshot?.batteryPercent ?? 0;
    final voltage = snapshot?.batteryVoltage ?? 72.0;
    final current = snapshot?.batteryCurrent ?? 0.0;
    final powerKw = (voltage * current) / 1000.0;
    final isRegen = current < -0.1;

    final speedColor = _getSpeedColor(currentSpeed);
    final bleState = ref.watch(bleConnectionStateProvider).value;
    final isBleConnected = bleState == BleConnectionState.connected ||
        bleState == BleConnectionState.authenticated;

    // Range estimates
    final ecoRange = (batteryPercent * 1.4).toStringAsFixed(0);
    final normalRange = (batteryPercent * 1.0).toStringAsFixed(0);
    final sportRange = (batteryPercent * 0.75).toStringAsFixed(0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            children: [
              // Top Bar: Exit, Status, Sound Studio Shortcut
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
                    tooltip: 'Exit Cockpit',
                    onPressed: () => context.pop(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isBleConnected
                          ? const Color(0xFF10B981).withValues(alpha: 0.2)
                          : const Color(0xFF3B82F6).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isBleConnected
                            ? const Color(0xFF10B981)
                            : const Color(0xFF3B82F6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isBleConnected ? LucideIcons.bluetooth : LucideIcons.cloud,
                          size: 13,
                          color: isBleConnected ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isBleConnected ? 'LIVE BLE' : '4G CLOUD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isBleConnected ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.volume2, color: Colors.white),
                    tooltip: 'Exhaust Sound Studio',
                    onPressed: () => _showQuickSoundSelector(context),
                  ),
                ],
              ),
              const Spacer(),

              // Center: Giant Speedometer Display
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getSpeedZoneLabel(currentSpeed),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: speedColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      currentSpeed.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 96,
                        height: 1.0,
                        fontWeight: FontWeight.w900,
                        color: speedColor,
                        shadows: [
                          Shadow(
                            color: speedColor.withValues(alpha: 0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    'KM / H',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Live Power / Regenerative Braking Meter
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isRegen
                      ? const Color(0xFF10B981).withValues(alpha: 0.15)
                      : (powerKw > 3.0
                          ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                          : const Color(0xFF1E293B)),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isRegen
                        ? const Color(0xFF10B981)
                        : (powerKw > 3.0 ? const Color(0xFFEF4444) : Colors.white24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isRegen ? LucideIcons.batteryCharging : LucideIcons.zap,
                          size: 18,
                          color: isRegen ? const Color(0xFF10B981) : Colors.amber,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isRegen
                              ? 'REGEN BRAKING'
                              : (powerKw > 0.1 ? 'DISCHARGING' : 'IDLE'),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: isRegen ? const Color(0xFF10B981) : Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${isRegen ? "-" : "+"}${powerKw.abs().toStringAsFixed(2)} kW',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isRegen ? const Color(0xFF10B981) : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Mode Projections Row
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildModeRange(
                      label: 'MODE 1 (ECO)',
                      rangeKm: '$ecoRange km',
                      color: const Color(0xFF10B981),
                      isActive: (snapshot?.rideMode ?? 'eco').toLowerCase() == 'eco',
                    ),
                    Container(width: 1, height: 24, color: Colors.white12),
                    _buildModeRange(
                      label: 'MODE 2 (NORM)',
                      rangeKm: '$normalRange km',
                      color: const Color(0xFF3B82F6),
                      isActive: (snapshot?.rideMode ?? '').toLowerCase() == 'normal',
                    ),
                    Container(width: 1, height: 24, color: Colors.white12),
                    _buildModeRange(
                      label: 'MODE 3 (SPORT)',
                      rangeKm: '$sportRange km',
                      color: const Color(0xFFEF4444),
                      isActive: (snapshot?.rideMode ?? '').toLowerCase() == 'sport',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bottom 4-Card Performance Cluster
              Row(
                children: [
                  Expanded(
                    child: _buildCockpitStatCard(
                      label: 'BATTERY',
                      value: '$batteryPercent%',
                      sub: '${voltage.toStringAsFixed(1)} V | ${current.toStringAsFixed(1)} A',
                      icon: LucideIcons.batteryMedium,
                      color: batteryPercent > 20 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildCockpitStatCard(
                      label: 'PACK / MOTOR',
                      value: snapshot?.batteryTemp != null
                          ? '${snapshot!.batteryTemp}°C'
                          : '--°C',
                      sub: snapshot?.motorTemp != null
                          ? 'Motor ${snapshot!.motorTemp}°C'
                          : 'Motor --°C',
                      icon: LucideIcons.thermometer,
                      color: (snapshot?.batteryTemp ?? 30) < 45
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildCockpitStatCard(
                      label: 'SESSION TIME',
                      value: _formatDuration(_elapsedTime),
                      sub: 'Top ${_sessionMaxSpeed.toStringAsFixed(0)} km/h',
                      icon: LucideIcons.clock,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildCockpitStatCard(
                      label: 'ODOMETER',
                      value: effectiveOdo != null
                          ? '${effectiveOdo.toStringAsFixed(1)} km'
                          : '-- km',
                      sub: 'Trip ${(snapshot?.tripDistance ?? 0.0).toStringAsFixed(1)} km',
                      icon: LucideIcons.navigation,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeRange({
    required String label,
    required String rangeKm,
    required Color color,
    required bool isActive,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
            color: isActive ? color : Colors.white54,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          rangeKm,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildCockpitStatCard({
    required String label,
    required String value,
    required String sub,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
