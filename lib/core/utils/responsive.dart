import 'package:flutter/material.dart';

enum Breakpoint { smallPhone, phone, tablet, desktop }

class Responsive extends StatelessWidget {
  final Widget phone;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    super.key,
    required this.phone,
    this.tablet,
    this.desktop,
  });

  static Breakpoint getBreakpoint(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width >= 1100) return Breakpoint.desktop;
    if (width >= 650) return Breakpoint.tablet;
    if (width >= 360) return Breakpoint.phone;
    return Breakpoint.smallPhone;
  }

  static bool isPhone(BuildContext context) => getBreakpoint(context) == Breakpoint.phone || getBreakpoint(context) == Breakpoint.smallPhone;
  static bool isTablet(BuildContext context) => getBreakpoint(context) == Breakpoint.tablet;
  static bool isDesktop(BuildContext context) => getBreakpoint(context) == Breakpoint.desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100 && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= 650 && tablet != null) {
          return tablet!;
        } else {
          return phone;
        }
      },
    );
  }
}

extension ResponsiveExtension on BuildContext {
  Breakpoint get breakpoint => Responsive.getBreakpoint(this);
  bool get isPhone => Responsive.isPhone(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  
  int get responsiveGridColumns {
    if (isDesktop) return 4;
    if (isTablet) return 2;
    return 1;
  }
}
