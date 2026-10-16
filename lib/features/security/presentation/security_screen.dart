import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/ui/volt_app_bar.dart';
import '../../ble/presentation/providers/vehicle_snapshot_provider.dart';
import '../data/anti_theft_guard_provider.dart';

/// Interactive Anti-Theft Guard & Geofence Shield Screen
class SecurityScreen extends ConsumerStatefulWidget {
  const SecurityScreen({super.key});

  @override
  ConsumerState<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends ConsumerState<SecurityScreen> {
  final MapController _mapController = MapController();

  static const List<double> _presetRadii = [50.0, 100.0, 250.0, 500.0, 1000.0];

  @override
  Widget build(BuildContext context) {
    final guardState = ref.watch(antiTheftGuardProvider);
    final guardNotifier = ref.read(antiTheftGuardProvider.notifier);
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);

    final snapshot = liveSnapshot ?? lastSnapshot;
    LatLng bikeCoords = const LatLng(18.5204, 73.8567); // Default fallback (Pune)

    if (guardState.parkedLatitude != null && guardState.parkedLongitude != null) {
      bikeCoords = LatLng(guardState.parkedLatitude!, guardState.parkedLongitude!);
    } else if (snapshot?.gpsCoords != null && snapshot!.gpsCoords!.contains(',')) {
      final parts = snapshot.gpsCoords!.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].trim());
        final lon = double.tryParse(parts[1].trim());
        if (lat != null && lon != null) {
          bikeCoords = LatLng(lat, lon);
        }
      }
    }

    final isArmed = guardState.status == AntiTheftStatus.armed;
    final isTriggered = guardState.status == AntiTheftStatus.alertTriggered;

    return Scaffold(
      appBar: VoltAppBar(
        title: 'Security & Geofence',
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.locateFixed),
            tooltip: 'Center on Bike',
            onPressed: () {
              _mapController.move(bikeCoords, 16.0);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Alert Banner if Breach Detected
            if (isTriggered) ...[
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.siren, color: Colors.white, size: 32),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GEOFENCE BREACH DETECTED!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            guardState.alertMessage ??
                                'Bike moved ${(guardState.distanceMovedMeters ?? 0).toStringAsFixed(0)}m beyond geofence!',
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // OpenStreetMap Interactive Visualizer
            Container(
              height: 280,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isTriggered
                      ? Colors.red
                      : (isArmed ? Colors.teal : Colors.grey.withValues(alpha: 0.3)),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: bikeCoords,
                    initialZoom: 16.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.revolt.evcompanion',
                    ),
                    if (isArmed || isTriggered)
                      CircleLayer(
                        circles: [
                          CircleMarker(
                            point: bikeCoords,
                            radius: guardState.geofenceRadiusMeters,
                            useRadiusInMeter: true,
                            color: isTriggered
                                ? Colors.red.withValues(alpha: 0.25)
                                : Colors.teal.withValues(alpha: 0.2),
                            borderColor: isTriggered ? Colors.red : Colors.teal,
                            borderStrokeWidth: 2,
                          ),
                        ],
                      ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: bikeCoords,
                          width: 48,
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isTriggered
                                  ? Colors.red
                                  : (isArmed ? Colors.teal : Colors.blue.shade700),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: (isTriggered ? Colors.red : Colors.black)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              LucideIcons.bike,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Guard Status & Arm / Disarm Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: (isArmed || isTriggered ? Colors.teal : Colors.grey)
                                      .withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isTriggered
                                      ? LucideIcons.shieldAlert
                                      : (isArmed ? LucideIcons.shieldCheck : LucideIcons.shieldOff),
                                  color: isTriggered
                                      ? Colors.red
                                      : (isArmed ? Colors.teal : Colors.grey),
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isTriggered
                                        ? 'Security Triggered'
                                        : (isArmed ? 'Anti-Theft Active' : 'Shield Disarmed'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isArmed
                                        ? 'Perimeter: ${guardState.geofenceRadiusMeters.toStringAsFixed(0)}m radius'
                                        : 'Tap switch to arm protection',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Switch(
                            value: isArmed || isTriggered,
                            activeTrackColor: Colors.teal,
                            activeThumbColor: Colors.white,
                            onChanged: (val) {
                              HapticFeedback.mediumImpact();
                              if (val) {
                                guardNotifier.armGuard(
                                  lat: bikeCoords.latitude,
                                  lng: bikeCoords.longitude,
                                );
                              } else {
                                guardNotifier.disarmGuard();
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(height: 1),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Displacement from Parked Spot',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            '${(guardState.distanceMovedMeters ?? 0.0).toStringAsFixed(1)} m',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: (guardState.distanceMovedMeters ?? 0) >
                                      guardState.geofenceRadiusMeters
                                  ? Colors.red
                                  : Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Geofence Radius Slider Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Geofence Boundary Radius',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            '${guardState.geofenceRadiusMeters.toStringAsFixed(0)} m',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: guardState.geofenceRadiusMeters.clamp(50.0, 2000.0),
                        min: 50.0,
                        max: 2000.0,
                        divisions: 39,
                        activeColor: Colors.teal,
                        onChanged: (val) {
                          guardNotifier.setGeofenceRadius(val);
                        },
                      ),
                      Wrap(
                        spacing: 8,
                        children: _presetRadii.map((radius) {
                          final selected = (guardState.geofenceRadiusMeters - radius).abs() < 1.0;
                          return ChoiceChip(
                            label: Text(
                              radius >= 1000 ? '${(radius / 1000).toStringAsFixed(0)} km' : '${radius.toStringAsFixed(0)}m',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            selected: selected,
                            selectedColor: Colors.teal.withValues(alpha: 0.25),
                            onSelected: (_) {
                              HapticFeedback.selectionClick();
                              guardNotifier.setGeofenceRadius(radius);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Remote Security Actions Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Find My Bike (Hazard / Horn Chirp)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        HapticFeedback.heavyImpact();
                        final success = await guardNotifier.triggerLocateBike();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Chirp command sent! Bike hazards & buzzer triggered.'
                                    : 'Command sent over available channels.',
                              ),
                              backgroundColor: Colors.teal.shade800,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      icon: const Icon(LucideIcons.bellRing, size: 18),
                      label: const Text('Find Bike'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Remote Engine Lock / Immobilizer
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _confirmRemoteLock(context, guardNotifier),
                      icon: const Icon(LucideIcons.lock, size: 18),
                      label: const Text('Lock Engine'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.red.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Navigate to Bike Directions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                onPressed: () async {
                  final uri = Uri.parse(
                    'https://www.google.com/maps/search/?api=1&query=${bikeCoords.latitude},${bikeCoords.longitude}',
                  );
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(LucideIcons.navigation, size: 18),
                label: const Text('Get Walking Directions to Bike'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _confirmRemoteLock(BuildContext context, AntiTheftGuard guardNotifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(LucideIcons.triangleAlert, color: Colors.red),
            SizedBox(width: 8),
            Text('Remote Engine Lock'),
          ],
        ),
        content: const Text(
          'This will send an emergency immobilizer command (LOCK#) to the Revolt ECU, cutting powertrain throttle. Use only in emergency or parked conditions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade800,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.of(ctx).pop();
              HapticFeedback.heavyImpact();
              final success = await guardNotifier.remoteLockEngine();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Engine locked! ECU immobilizer engaged.'
                          : 'Lock command dispatched to vehicle.',
                    ),
                    backgroundColor: Colors.red.shade900,
                  ),
                );
              }
            },
            child: const Text('Engage Lock'),
          ),
        ],
      ),
    );
  }
}
