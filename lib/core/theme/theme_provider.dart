import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

const _kThemeKey = 'app_theme_mode';

ThemeMode? _preloadedThemeMode;

/// Reads the saved theme before `runApp` so the first frame renders in the
/// right mode instead of flashing system default then correcting itself.
Future<void> preloadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString(_kThemeKey);
  if (saved != null) _preloadedThemeMode = ThemeNotifier._stringToThemeMode(saved);
}

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() => _preloadedThemeMode ?? ThemeMode.system;

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeKey, _themeModeToString(mode));
  }

  static String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }

  static ThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
