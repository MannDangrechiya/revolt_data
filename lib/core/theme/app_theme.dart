import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

final ThemeData voltLogTheme = FlexThemeData.light(
  scheme: FlexScheme.green,
  colors: const FlexSchemeColor(
    primary: Color(0xFF00C853), // Electric Green
    secondary: Color(0xFF003d33), // Deep Charcoal
  ),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 10,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    useMaterial3Typography: true,
    useM2StyleDividerInM3: true,
    elevatedButtonSchemeColor: SchemeColor.primary,
    elevatedButtonSecondarySchemeColor: SchemeColor.onPrimary,
    cardElevation: 2,
    cardRadius: 16,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  fontFamily: 'Inter',
).copyWith(
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  textTheme: Typography.whiteMountainView.apply(
    fontFamily: 'Inter',
    displayColor: Colors.black,
    bodyColor: Colors.black,
  ),
);