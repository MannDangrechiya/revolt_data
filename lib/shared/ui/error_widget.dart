import 'package:flutter/material.dart';
import '../../core/theme/sizes.dart';
import '../../core/theme/theme_extension.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class VoltErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const VoltErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.alertTriangle,
              size: 48,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: Sizes.paddingMedium),
            Text(
              "Oops, something went wrong",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.paddingSmall),
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.paddingLarge),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(LucideIcons.refreshCcw),
              label: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
