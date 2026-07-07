import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:revolt_data/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Test', () {
    testWidgets('verify app startup and dashboard presence',
        (tester) async {
      app.main();
      
      // Wait for app to render and providers to initialize
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check for EV Companion title
      expect(find.text('EV Companion'), findsWidgets);

      // Verify quick action buttons exist
      expect(find.text('Rides'), findsWidgets);
      expect(find.text('Charging'), findsWidgets);
      expect(find.text('Expenses'), findsWidgets);
      expect(find.text('Maintenance'), findsWidgets);
    });
    
    // Add additional critical flows such as "Create bike profile -> Add ride -> Dashboard updates"
    // Since the app uses sqlite, test will use actual DB or we can override providers 
    // for e2e tests via a test main entrypoint.
  });
}
