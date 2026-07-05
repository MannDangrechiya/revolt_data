import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the typography hierarchy for VoltLog using the Inter font.
/// All text styles are derived from [GoogleFonts.inter] and are
/// intentionally fine‑tuned for a clean, Apple‑like feel.
class AppTypography {
  const AppTypography._();

  // Headline hierarchy (H1…H4)
  static const double _headlineLineHeight = 1.35;
  static const double _subtitleLineHeight = 1.4;
  static const double _bodyTextLineHeight = 1.55;

  static TextStyle headline1(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: _headlineLineHeight,
        letterSpacing: 0.5,
      );

  static TextStyle headline2(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: _headlineLineHeight,
        letterSpacing: 0.25,
      );

  static TextStyle headline3(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: _subtitleLineHeight,
        letterSpacing: 0.15,
      );

  static TextStyle headline4(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: _subtitleLineHeight,
        letterSpacing: 0.1,
      );

  // Body texts
  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: _bodyTextLineHeight,
        letterSpacing: 0.5,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: _bodyTextLineHeight,
        letterSpacing: 0.25,
      );

  static TextStyle bodySmall(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: _bodyTextLineHeight,
        letterSpacing: 0.4,
      );

  // Statistics cards / captions
  static TextStyle caption(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      );
}