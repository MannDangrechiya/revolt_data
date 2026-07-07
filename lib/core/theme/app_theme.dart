import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sizes.dart';

class AppTheme {
  // Define custom typography using Outfit
  static TextTheme get _textTheme {
    return GoogleFonts.outfitTextTheme().copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 57,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.outfit(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w500),
    );
  }

  static ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 10,
      appBarStyle: FlexAppBarStyle.primary,
      bottomAppBarElevation: Elevations.low,
      appBarElevation: Elevations.low,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme: _textTheme,
    ).copyWith(
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: VoltRadius.medium),
        elevation: Elevations.low,
        clipBehavior: Clip.antiAlias,
      ),
      dialogTheme: const DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: VoltRadius.large),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: VoltRadius.extraLarge),
        elevation: Elevations.medium,
      ),
    );
  }

  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.deepBlue,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,
      appBarStyle: FlexAppBarStyle.background,
      bottomAppBarElevation: Elevations.low,
      appBarElevation: Elevations.low,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.outfit().fontFamily,
      textTheme: _textTheme,
    ).copyWith(
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: VoltRadius.medium),
        elevation: Elevations.low,
        clipBehavior: Clip.antiAlias,
      ),
      dialogTheme: const DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: VoltRadius.large),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: VoltRadius.extraLarge),
        elevation: Elevations.medium,
      ),
    );
  }
}
