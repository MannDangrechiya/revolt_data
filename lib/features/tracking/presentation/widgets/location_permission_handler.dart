import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionHandler extends StatefulWidget {
  final Widget child;

  const LocationPermissionHandler({
    super.key,
    required this.child,
  });

  @override
  State<LocationPermissionHandler> createState() =>
      _LocationPermissionHandlerState();
}

class _LocationPermissionHandlerState
    extends State<LocationPermissionHandler> {
  bool _isDenied = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final statusWhenInUse = await Permission.locationWhenInUse.status;
    final statusAlways = await Permission.locationAlways.status;

    if (statusWhenInUse.isDenied || statusAlways.isDenied) {
      if (mounted) {
        setState(() {
          _isDenied = true;
        });
      }
    }
  }

  Future<void> _requestPermissions() async {
    final showRationale = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Background Location Access Needed'),
            content: const Text(
              'My Revolt uses background location to seamlessly continue tracking your ride if Bluetooth disconnects or the app is in the background.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Grant Access'),
              ),
            ],
          ),
        ) ??
        false;

    if (showRationale) {
      final whenInUse = await Permission.locationWhenInUse.request();
      if (whenInUse.isGranted) {
        await Permission.locationAlways.request();
        await Permission.ignoreBatteryOptimizations.request();
      }

      await _checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isDenied)
          Container(
            width: double.infinity,
            color: Colors.amber.shade800,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.location_off, color: Colors.white),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Background location is disabled. GPS fallback tracking requires always-allow location.',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _requestPermissions();
                  },
                  child: const Text(
                    'Enable in Settings',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        Expanded(child: widget.child),
      ],
    );
  }
}
