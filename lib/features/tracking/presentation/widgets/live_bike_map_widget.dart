import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ble/presentation/providers/vehicle_snapshot_provider.dart';

/// Live vehicle locator map displaying the bike's real-time position,
/// battery statistics, geofence circle, and navigation launcher.
/// Seamlessly falls back to smartphone GPS when bike ECU GPS has no satellite fix (e.g. indoors/parked).
class LiveBikeMapWidget extends ConsumerStatefulWidget {
  final double height;
  final bool showHeader;

  const LiveBikeMapWidget({
    super.key,
    this.height = 220,
    this.showHeader = true,
  });

  @override
  ConsumerState<LiveBikeMapWidget> createState() => _LiveBikeMapWidgetState();
}

class _LiveBikeMapWidgetState extends ConsumerState<LiveBikeMapWidget> {
  final MapController _mapController = MapController();
  LatLng? _deviceLocation;
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    _fetchDeviceLocation();
  }

  Future<void> _fetchDeviceLocation() async {
    if (_isLocating) return;
    setState(() => _isLocating = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final pos = await Geolocator.getLastKnownPosition() ??
            await Geolocator.getCurrentPosition(
              timeLimit: const Duration(seconds: 4),
            );
        if (mounted) {
          setState(() {
            _deviceLocation = LatLng(pos.latitude, pos.longitude);
            _isLocating = false;
          });
        }
      } else {
        if (mounted) setState(() => _isLocating = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  void _recenterMap(LatLng target) {
    _mapController.move(target, 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final liveSnapshot = ref.watch(vehicleSnapshotProvider).value;
    final persistedSnapshot = ref.watch(persistedVehicleSnapshotProvider).value;
    final lastSnapshot = ref.watch(lastKnownVehicleSnapshotProvider);

    final snapshot = liveSnapshot ?? lastSnapshot ?? persistedSnapshot;
    final coordsString = snapshot?.gpsCoords;

    LatLng? bikePosition;
    bool isFromBikeEcu = false;

    if (coordsString != null && coordsString.contains(',')) {
      final parts = coordsString.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].trim());
        final lon = double.tryParse(parts[1].trim());
        if (lat != null && lon != null && lat != 0.0 && lon != 0.0) {
          bikePosition = LatLng(lat, lon);
          isFromBikeEcu = true;
        }
      }
    }

    // Proximity fallback to smartphone GPS if bike GPS is empty/no fix
    final effectivePosition = bikePosition ?? _deviceLocation;
    final batteryPercent = snapshot?.batteryPercent;
    final rangeKm = snapshot?.range;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeader) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Bike Locator',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: _isLocating
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(LucideIcons.locateFixed, size: 18),
                    tooltip: 'Find My Position',
                    visualDensity: VisualDensity.compact,
                    onPressed: () async {
                      await _fetchDeviceLocation();
                      if (effectivePosition != null) {
                        _recenterMap(effectivePosition);
                      }
                    },
                  ),
                  if (effectivePosition != null)
                    TextButton.icon(
                      onPressed: () async {
                        final uri = Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=${effectivePosition.latitude},${effectivePosition.longitude}',
                        );
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(LucideIcons.navigation, size: 14),
                      label: const Text('Directions', style: TextStyle(fontSize: 12)),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            ),
            child: effectivePosition == null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.mapPinOff,
                            size: 32,
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isLocating ? 'Acquiring GPS fix...' : 'Waiting for GPS signal...',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ElevatedButton.icon(
                            onPressed: _fetchDeviceLocation,
                            icon: const Icon(LucideIcons.locate, size: 14),
                            label: const Text('Locate with Phone GPS', style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: effectivePosition,
                          initialZoom: 15.5,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.revolt.platform',
                          ),
                          CircleLayer(
                            circles: [
                              CircleMarker(
                                point: effectivePosition,
                                radius: 80,
                                useRadiusInMeter: true,
                                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                                borderColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                                borderStrokeWidth: 1.5,
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: effectivePosition,
                                width: 44,
                                height: 44,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isFromBikeEcu
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.blue.shade700,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2.5),
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 2)),
                                    ],
                                  ),
                                  child: const Icon(
                                    LucideIcons.bike,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.batteryMedium,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                batteryPercent != null ? '$batteryPercent%' : '--%',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              if (rangeKm != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '• ${rangeKm.toStringAsFixed(0)} km',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isFromBikeEcu
                                ? Colors.green.shade800.withValues(alpha: 0.9)
                                : Colors.blue.shade800.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isFromBikeEcu ? LucideIcons.satellite : LucideIcons.smartphone,
                                size: 12,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isFromBikeEcu ? 'Bike GPS Fix' : 'Phone GPS Proximity',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.shieldCheck, size: 12, color: Colors.green),
                              SizedBox(width: 4),
                              Text(
                                'Geofence Active',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
