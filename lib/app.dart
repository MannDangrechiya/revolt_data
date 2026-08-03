import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/router.dart' as router;
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

class AppWidget extends ConsumerWidget {
  final String organization = "VoltLog Engineering";

  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: router.routerDelegate,
      title: organization,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
    );
  }
}
