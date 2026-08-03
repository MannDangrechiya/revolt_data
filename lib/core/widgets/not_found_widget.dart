import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Reusable widget displayed when a deep-linked entity or route cannot be found.
class NotFoundWidget extends StatelessWidget {
  final String message;
  final String? returnRoute;
  final String returnButtonText;

  const NotFoundWidget({
    super.key,
    this.message = 'The requested item could not be found or has been deleted.',
    this.returnRoute,
    this.returnButtonText = 'Go Back',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Found'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LucideIcons.fileSearch,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Item Not Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                if (returnRoute != null && returnRoute!.isNotEmpty) {
                  context.go(returnRoute!);
                } else if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
              icon: const Icon(LucideIcons.arrowLeft, size: 18),
              label: Text(returnButtonText),
            ),
          ],
        ),
      ),
    ),
  );
}
}
