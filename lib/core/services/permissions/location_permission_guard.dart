import 'package:flutter/foundation.dart';
import '../../../features/tracking/data/background_location_service.dart';

/// Non-blocking guard utility ensuring background location permissions
/// (`ACCESS_FINE_LOCATION`, `ACCESS_BACKGROUND_LOCATION`) and notification channels
/// are requested smoothly without stalling app initialization.
class LocationPermissionGuard {
  static Future<bool> ensurePermissionsAndChannelsAsync() async {
    try {
      final bgService = BackgroundLocationService();
      await bgService.initialize();
      return await bgService.requestPermissions();
    } catch (e) {
      debugPrint('[LocationPermissionGuard] Non-blocking permission check handled: $e');
      return false;
    }
  }
}
