import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/ui/volt_app_bar.dart';
import '../../../../shared/ui/volt_card.dart';
import '../../domain/connection_state.dart';
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
    // Pre-filled with the last known-good token so the fallback path here
    // is a single tap, not a race against the bike's idle disconnect while
    // the user retypes a 13-character token by hand.
    final tokenController = useTextEditingController(
      text: AppConstants.knownBlePairingToken,
    );
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
                      hintText: 'Token from your Revolt account (not always a short PIN)',
                      prefixIcon: const Icon(LucideIcons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    enabled: !isLoading.value,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Derived from Base64(Mobile:IMEI) - official MyRevolt token.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => _showTokenGeneratorDialog(context, tokenController),
                        icon: const Icon(LucideIcons.calculator, size: 14),
                        label: const Text('Custom IMEI', style: TextStyle(fontSize: 12)),
                      ),
                    ],
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
                                // The bike disconnects unauthenticated
                                // clients and we no longer auto-reconnect
                                // those (that was the reconnect storm). If
                                // an earlier wrong-PIN attempt killed the
                                // link, re-establish it before pairing.
                                final state = repo.currentConnectionState;
                                if (state == BleConnectionState.disconnected ||
                                    state == BleConnectionState.error) {
                                  if (deviceId == null) {
                                    errorMessage.value =
                                        'Connection lost. Please rescan for your bike.';
                                    return;
                                  }
                                  await repo.connect(deviceId!);
                                }

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
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: isLoading.value
                          ? null
                          : () {
                              context.go('/device');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Connected to RV400 in Direct BLE Mode (PIN Bypassed)',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                      icon: const Icon(LucideIcons.arrowRightCircle),
                      label: const Text('Skip PIN & Connect Directly'),
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

  void _showTokenGeneratorDialog(
    BuildContext context,
    TextEditingController tokenController,
  ) {
    final mobileController = TextEditingController(text: AppConstants.defaultMobileNumber);
    final imeiController = TextEditingController(text: AppConstants.defaultEcuImei);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(LucideIcons.key, size: 20),
            SizedBox(width: 8),
            Text('Derive Pairing Token', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MyRevolt computes the 13-character BLE token using Base64 of Registered Mobile : ECU IMEI.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                hintText: '10-digit mobile number',
                prefixIcon: Icon(LucideIcons.phone, size: 18),
                isDense: true,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: imeiController,
              decoration: const InputDecoration(
                labelText: 'ECU IMEI',
                hintText: '15-digit IMEI',
                prefixIcon: Icon(LucideIcons.binary, size: 18),
                isDense: true,
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final mobile = mobileController.text.trim();
              final imei = imeiController.text.trim();
              if (mobile.isNotEmpty && imei.isNotEmpty) {
                final derived = AppConstants.deriveToken(
                  mobileNumber: mobile,
                  ecuImei: imei,
                );
                tokenController.text = derived;
              }
              Navigator.pop(ctx);
            },
            child: const Text('Calculate Token'),
          ),
        ],
      ),
    );
  }
}

