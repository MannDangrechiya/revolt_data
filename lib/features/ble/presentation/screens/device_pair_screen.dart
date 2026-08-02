import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../shared/ui/volt_app_bar.dart';
import '../../../../shared/ui/volt_card.dart';
import '../providers/ble_connection_provider.dart';

/// Screen allowing users to enter a pairing token to authenticate with their RV400.
class DevicePairScreen extends HookConsumerWidget {
  final String? deviceId;

  const DevicePairScreen({
    super.key,
    this.deviceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenController = useTextEditingController();
    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);
    final repo = ref.read(bleRepositoryProvider);

    return Scaffold(
      appBar: const VoltAppBar(title: 'Pair RV400 Bike'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            VoltCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.keyRound,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Authentication Required',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Enter your vehicle pairing token to complete connection.',
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: tokenController,
                    decoration: InputDecoration(
                      labelText: 'Pairing Token',
                      hintText: 'e.g. 123456',
                      prefixIcon: const Icon(LucideIcons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    enabled: !isLoading.value,
                  ),
                  if (errorMessage.value != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      errorMessage.value!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: isLoading.value
                          ? null
                          : () async {
                              final token = tokenController.text.trim();
                              if (token.isEmpty) {
                                errorMessage.value =
                                    'Please enter your pairing token';
                                return;
                              }

                              isLoading.value = true;
                              errorMessage.value = null;

                              try {
                                final success = await repo.pair(token);
                                if (success && context.mounted) {
                                  context.go('/device');
                                } else {
                                  errorMessage.value =
                                      'Authentication failed. Verify token and try again.';
                                }
                              } catch (e) {
                                errorMessage.value = 'Pairing error: $e';
                              } finally {
                                isLoading.value = false;
                              }
                            },
                      icon: isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(LucideIcons.shieldCheck),
                      label: Text(
                        isLoading.value ? 'Authenticating...' : 'Pair & Connect',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
