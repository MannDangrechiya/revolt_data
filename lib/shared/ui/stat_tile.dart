import 'package:flutter/material.dart';
import '../../core/theme/sizes.dart';
import '../../core/theme/theme_extension.dart';
import 'volt_card.dart';

class StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const StatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? context.colorScheme.primary;
    
    return VoltCard(
      padding: const EdgeInsets.all(Sizes.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: Sizes.iconMedium, color: effectiveIconColor),
              const SizedBox(width: Sizes.paddingSmall),
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: Sizes.paddingSmall),
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
