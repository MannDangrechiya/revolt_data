import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../tracking/data/ride_merger.dart';
import '../../../tracking/domain/gps_point.dart';

/// Interactive map widget displaying the GPS polyline route of a recorded ride,
/// complete with a multi-color speed heatmap and animated trip replay HUD.
class RideRouteMapWidget extends StatefulWidget {
  final String? routePolylineJson;
  final double height;
  final bool showReplayControls;

  const RideRouteMapWidget({
    super.key,
    required this.routePolylineJson,
    this.height = 280,
    this.showReplayControls = true,
  });

  /// Maps speed to color bands:
  /// - < 35 km/h: Emerald Green (Eco Cruising)
  /// - 35-60 km/h: Amber Orange (City Commuting)
  /// - > 60 km/h: Crimson Red (Sport / High Power)
  static Color getSpeedColor(double speed) {
    if (speed < 35.0) {
      return const Color(0xFF10B981);
    } else if (speed <= 60.0) {
      return const Color(0xFFF59E0B);
    } else {
      return const Color(0xFFEF4444);
    }
  }

  @override
  State<RideRouteMapWidget> createState() => _RideRouteMapWidgetState();
}

class _RideRouteMapWidgetState extends State<RideRouteMapWidget> {
  late final MapController _mapController;

  bool _isReplaying = false;
  bool _isPlaying = false;
  int _replayIndex = 0;
  double _playbackSpeed = 1.0; // 1.0x, 2.0x, 5.0x
  Timer? _replayTimer;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _replayTimer?.cancel();
    super.dispose();
  }

  void _startReplay(int totalPoints) {
    if (totalPoints <= 1) return;
    setState(() {
      _isReplaying = true;
      _isPlaying = true;
      _replayIndex = 0;
    });
    _startTimer(totalPoints);
  }

  void _startTimer(int totalPoints) {
    _replayTimer?.cancel();
    // Base 350ms tick at 1x
    final intervalMs = (350 / _playbackSpeed).round().clamp(50, 1000);
    _replayTimer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_replayIndex < totalPoints - 1) {
        setState(() {
          _replayIndex++;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
        timer.cancel();
      }
    });
  }

  void _togglePlayPause(int totalPoints) {
    if (_isPlaying) {
      _replayTimer?.cancel();
      setState(() {
        _isPlaying = false;
      });
    } else {
      if (_replayIndex >= totalPoints - 1) {
        _replayIndex = 0;
      }
      setState(() {
        _isPlaying = true;
      });
      _startTimer(totalPoints);
    }
  }

  void _cyclePlaybackSpeed(int totalPoints) {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 2.0;
      } else if (_playbackSpeed == 2.0) {
        _playbackSpeed = 5.0;
      } else {
        _playbackSpeed = 1.0;
      }
    });
    if (_isPlaying) {
      _startTimer(totalPoints);
    }
  }

  void _stopReplay() {
    _replayTimer?.cancel();
    setState(() {
      _isReplaying = false;
      _isPlaying = false;
      _replayIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<GpsPoint> points = RideMerger.decodeRoutePolyline(widget.routePolylineJson);

    if (points.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Center(
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
                'No GPS route breadcrumbs recorded for this ride',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final latLngs = points.map((p) => LatLng(p.latitude, p.longitude)).toList();
    final startPoint = latLngs.first;
    final endPoint = latLngs.last;
    final hasSpeedData = points.any((p) => p.speedKmh > 0);

    // Calculate center point
    double sumLat = 0;
    double sumLon = 0;
    for (final p in latLngs) {
      sumLat += p.latitude;
      sumLon += p.longitude;
    }
    final centerPoint = LatLng(sumLat / latLngs.length, sumLon / latLngs.length);

    // Build Polylines: Speed Heatmap if speed data exists, otherwise solid theme color
    final List<Polyline> polylines = [];
    if (points.length >= 2 && hasSpeedData) {
      for (int i = 0; i < points.length - 1; i++) {
        final p1 = points[i];
        final p2 = points[i + 1];
        final avgSpeed = (p1.speedKmh + p2.speedKmh) / 2.0;
        polylines.add(
          Polyline(
            points: [
              LatLng(p1.latitude, p1.longitude),
              LatLng(p2.latitude, p2.longitude),
            ],
            strokeWidth: 5.0,
            color: RideRouteMapWidget.getSpeedColor(avgSpeed),
            borderStrokeWidth: 1.0,
            borderColor: Colors.black26,
          ),
        );
      }
    } else {
      polylines.add(
        Polyline(
          points: latLngs,
          strokeWidth: 4.5,
          color: Theme.of(context).colorScheme.primary,
          borderStrokeWidth: 1.5,
          borderColor: Colors.black26,
        ),
      );
    }

    // Build Markers
    final List<Marker> markers = [
      Marker(
        point: startPoint,
        width: 32,
        height: 32,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)],
          ),
          child: const Icon(LucideIcons.play, color: Colors.white, size: 16),
        ),
      ),
      Marker(
        point: endPoint,
        width: 32,
        height: 32,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)],
          ),
          child: const Icon(LucideIcons.flag, color: Colors.white, size: 16),
        ),
      ),
    ];

    // If Replaying, add moving animated bike marker
    if (_isReplaying && _replayIndex < latLngs.length) {
      final currentCoord = latLngs[_replayIndex];
      final currentSpeed = points[_replayIndex].speedKmh;
      final speedColor = RideRouteMapWidget.getSpeedColor(currentSpeed);

      markers.add(
        Marker(
          point: currentCoord,
          width: 48,
          height: 48,
          child: Container(
            decoration: BoxDecoration(
              color: speedColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: speedColor.withValues(alpha: 0.6),
                  blurRadius: 12,
                  spreadRadius: 3,
                ),
                const BoxShadow(color: Colors.black45, blurRadius: 4),
              ],
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(LucideIcons.bike, color: Colors.white, size: 22),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Stack(
          children: [
            RepaintBoundary(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: centerPoint,
                  initialZoom: 14.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.revolt.platform',
                  ),
                  PolylineLayer(polylines: polylines),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),

            // Top Status Badges: Point Count & Speed Heatmap Legend
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Text(
                  '${latLngs.length} Points',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // Top-Left Speed Legend (When speed data is recorded)
            if (hasSpeedData && !_isReplaying)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSpeedDot(const Color(0xFF10B981)),
                      const Text(' <35', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 6),
                      _buildSpeedDot(const Color(0xFFF59E0B)),
                      const Text(' 35-60', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 6),
                      _buildSpeedDot(const Color(0xFFEF4444)),
                      const Text(' >60 km/h', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

            // Bottom Floating Trigger Button (when replay is closed)
            if (widget.showReplayControls && !_isReplaying && points.length > 1)
              Positioned(
                bottom: 10,
                right: 10,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _startReplay(points.length),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.play, color: Colors.white, size: 14),
                          SizedBox(width: 6),
                          Text(
                            'Replay Trip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Animated Trip Replay HUD Overlay (when replay is active)
            if (_isReplaying)
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          // Play / Pause Button
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => _togglePlayPause(points.length),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: Icon(
                                _isPlaying ? LucideIcons.pause : LucideIcons.play,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Live Speed Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: RideRouteMapWidget.getSpeedColor(
                                points[_replayIndex].speedKmh,
                              ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: RideRouteMapWidget.getSpeedColor(
                                  points[_replayIndex].speedKmh,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.gauge,
                                  size: 13,
                                  color: RideRouteMapWidget.getSpeedColor(
                                    points[_replayIndex].speedKmh,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${points[_replayIndex].speedKmh.toStringAsFixed(0)} km/h',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: RideRouteMapWidget.getSpeedColor(
                                      points[_replayIndex].speedKmh,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),

                          // Playback Rate Chip
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _cyclePlaybackSpeed(points.length),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${_playbackSpeed.toStringAsFixed(0)}x',
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Close / Stop Replay
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: _stopReplay,
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(LucideIcons.x, size: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Scrubber Slider
                      Row(
                        children: [
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                              ),
                              child: Slider(
                                value: _replayIndex.toDouble().clamp(0.0, (points.length - 1).toDouble()),
                                min: 0.0,
                                max: (points.length - 1).toDouble(),
                                onChanged: (val) {
                                  setState(() {
                                    _replayIndex = val.toInt();
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            '${_replayIndex + 1}/${points.length}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(right: 3),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
