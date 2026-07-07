import 'package:flutter/material.dart';

class Sizes {
  // Padding & Margin
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
}

class VoltRadius {
  static const BorderRadius small = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(12.0)); // Cards
  static const BorderRadius large = BorderRadius.all(Radius.circular(20.0)); // Dialogs
  static const BorderRadius extraLarge = BorderRadius.all(Radius.circular(30.0)); // FAB

  static const double circularValue = 100.0;
}

class Elevations {
  static const double low = 2.0;
  static const double medium = 4.0;
  static const double high = 8.0;
}
