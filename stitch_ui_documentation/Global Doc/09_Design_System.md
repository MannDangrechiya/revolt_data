# 09 - Design System

This document outlines the core design tokens and styling rules applied in the app. The UI redesign must either replicate this closely or redefine it comprehensively while keeping standard `ThemeData` access so as not to break existing non-UI components (if any).

## 1. Global Theming Engine
- **Framework:** Material 3 (`useMaterial3: true`).
- **Engine:** `flex_color_scheme` is heavily utilized to generate harmonious palettes across Light and Dark modes.
- **Scheme Name:** `FlexScheme.deepBlue`.
- **Surface Mode:** `FlexSurfaceMode.highScaffoldLowSurface` (Scaffold has a deeper color than cards).
- **Blend Level:** 10 (Light Mode) / 15 (Dark Mode).

## 2. Typography
- **Font Family:** `Outfit` (via `google_fonts`).
- **Headings:**
  - `displayLarge`: 57pt, Bold
  - `displayMedium`: 45pt, Bold
  - `headlineLarge`: 32pt, w700
  - `titleLarge`: 22pt, w600
- **Body:**
  - `bodyLarge`: 16pt, Normal
  - `bodyMedium`: 14pt, Normal
  - `labelLarge`: 14pt, w500

## 3. Shape & Corner Radius
The app defines a strict rounding system via a `VoltRadius` constant class.
- **Cards:** `VoltRadius.medium` (RoundedRectangleBorder).
- **Dialogs:** `VoltRadius.large`.
- **Buttons / FABs:** `VoltRadius.extraLarge` (Pill-shaped).
- **Bottom Sheets:** Top corners typically rounded heavily.

## 4. Elevation & Shadows
Defined via an `Elevations` constant class.
- **AppBars & BottomAppBars:** `Elevations.low` (Minimal shadow, relies on color separation).
- **Cards:** `Elevations.low`.
- **FABs:** `Elevations.medium` (Prominent floating shadow).

## 5. Spacing & Padding System
While not explicitly printed in the Theme file, standard `Sizes` usually dictate:
- **Screen Padding:** 16.0 or 20.0 horizontally.
- **Card Padding:** 16.0 all around.
- **Gaps (Vertical/Horizontal):** Usually multiples of 8 (8, 16, 24, 32).

## 6. Iconography
- The app uses `lucide_icons` as defined in `pubspec.yaml`, moving away from standard Material icons for a sharper, more modern geometric look.

## Stitch Instruction
When replacing UI, you can redefine `app_theme.dart` completely. However, you MUST ensure that text styles, cards, and buttons maintain excellent legibility in both light and dark mode, as this is a core requirement of a premium application.
