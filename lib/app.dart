import 'package:flutter/material.dart';
import 'core/router.dart' as router;
import 'core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  final String organization = "VoltLog Engineering";

  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router.routerDelegate,
      title: organization,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
