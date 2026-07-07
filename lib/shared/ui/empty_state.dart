import 'package:flutter/material.dart';
import '../../core/theme/sizes.dart';
import '../../core/theme/theme_extension.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? lottieAsset;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.lottieAsset,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (lottieAsset != null)
              Lottie.asset(
                lottieAsset!,
                width: 200,
                height: 200,
                repeat: true,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
              )
            else
              const Icon(
                Icons.inbox_outlined,
                size: 64,
                color: Colors.grey,
              ),
            const SizedBox(height: Sizes.paddingMedium),
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.paddingSmall),
            Text(
              subtitle,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: Sizes.paddingLarge),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
