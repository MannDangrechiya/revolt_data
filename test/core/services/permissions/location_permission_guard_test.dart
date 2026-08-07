import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/core/services/permissions/location_permission_guard.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocationPermissionGuard Tests', () {
    test('ensurePermissionsAndChannelsAsync executes without throwing errors', () async {
      final result = await LocationPermissionGuard.ensurePermissionsAndChannelsAsync();
      expect(result, isA<bool>());
    });
  });
}
