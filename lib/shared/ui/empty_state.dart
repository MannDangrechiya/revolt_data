import 'package:flutter/material.dart';
import '../../core/theme/sizes.dart';
import '../../core/theme/theme_extension.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? message;
  final String? lottieAsset;
  final IconData? icon;
  final Widget? action;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.message,
    this.lottieAsset,
    this.icon,
    this.action,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final displayMessage = subtitle ?? message ?? '';

    Widget iconOrAnimation;
    if (icon != null) {
      iconOrAnimation = Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (lottieAsset != null) {
      iconOrAnimation = Lottie.asset(
        lottieAsset!,
        width: 200,
        height: 200,
        repeat: true,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.inbox_outlined,
          size: 64,
          color: Colors.grey,
        ),
      );
    } else {
      iconOrAnimation = const Icon(
        Icons.inbox_outlined,
        size: 64,
        color: Colors.grey,
      );
    }

    Widget? actionWidget = action;
    if (actionWidget == null && buttonText != null && onButtonPressed != null) {
      actionWidget = FilledButton.icon(
        onPressed: onButtonPressed,
        icon: const Icon(Icons.add),
        label: Text(buttonText!),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconOrAnimation,
            const SizedBox(height: Sizes.paddingMedium),
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (displayMessage.isNotEmpty) ...[
              const SizedBox(height: Sizes.paddingSmall),
              Text(
                displayMessage,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionWidget != null) ...[
              const SizedBox(height: Sizes.paddingLarge),
              actionWidget,
            ],
          ],
        ),
      ),
    );
  }
}
