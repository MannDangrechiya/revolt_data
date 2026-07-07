import 'package:flutter/material.dart';
import '../../core/theme/sizes.dart';
import '../../core/theme/theme_extension.dart';

class VoltCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double elevation;
  final VoidCallback? onTap;

  const VoltCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Sizes.paddingMedium),
    this.color,
    this.elevation = Elevations.low,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      color: color ?? context.theme.cardColor,
      elevation: elevation,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: VoltRadius.medium),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: VoltRadius.medium,
        child: card,
      );
    }

    return card;
  }
}
