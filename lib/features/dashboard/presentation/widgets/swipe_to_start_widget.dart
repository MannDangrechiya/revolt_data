import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../ble/domain/connection_state.dart';
import '../../../ble/presentation/providers/ble_connection_provider.dart';

/// Swipe-to-Start digital key ignition slider widget for the RV400.
class SwipeToStartWidget extends ConsumerStatefulWidget {
  const SwipeToStartWidget({super.key});

  @override
  ConsumerState<SwipeToStartWidget> createState() => _SwipeToStartWidgetState();
}

class _SwipeToStartWidgetState extends ConsumerState<SwipeToStartWidget>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _isBikeStarted = false;
  bool _isSendingCommand = false;

  @override
  Widget build(BuildContext context) {
    final bleState = ref.watch(bleConnectionStateProvider).value ??
        BleConnectionState.disconnected;
    final isConnected = bleState == BleConnectionState.connected ||
        bleState == BleConnectionState.authenticated;

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        const thumbSize = 56.0;
        final maxDrag = trackWidth - thumbSize - 8.0;

        return Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: _isBikeStarted
                  ? [Colors.green.shade800, Colors.teal.shade700]
                  : [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: _isBikeStarted
                    ? Colors.green.withValues(alpha: 0.3)
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isBikeStarted ? LucideIcons.powerOff : LucideIcons.power,
                      size: 16,
                      color: _isBikeStarted
                          ? Colors.white.withValues(alpha: 0.8)
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isSendingCommand
                          ? 'Transmitting Command...'
                          : (_isBikeStarted
                              ? 'Swipe to Turn OFF'
                              : (isConnected
                                  ? 'Swipe to Start Bike'
                                  : 'Connect Bike to Start')),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 0.5,
                        color: _isBikeStarted
                            ? Colors.white
                            : (isConnected
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.outline),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 4.0 + _dragPosition,
                top: 4.0,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_isSendingCommand) return;
                    setState(() {
                      _dragPosition = (_dragPosition + details.delta.dx)
                          .clamp(0.0, maxDrag);
                    });
                  },
                  onHorizontalDragEnd: (details) async {
                    if (_isSendingCommand) return;
                    if (_dragPosition >= maxDrag * 0.85) {
                      // Trigger ignition command
                      await _handleSwipeAction(isConnected);
                    }
                    setState(() {
                      _dragPosition = 0.0;
                    });
                  },
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isBikeStarted
                          ? Colors.redAccent
                          : Theme.of(context).colorScheme.primary,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isSendingCommand
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              _isBikeStarted ? LucideIcons.square : LucideIcons.chevronsRight,
                              color: Colors.white,
                              size: 26,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleSwipeAction(bool isConnected) async {
    HapticFeedback.heavyImpact();

    if (!isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please connect to the bike via Bluetooth first.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSendingCommand = true;
    });

    final command = _isBikeStarted ? 'STOP#' : 'START#';
    try {
      final repo = ref.read(bleRepositoryProvider);
      await repo.sendCommand(command);

      setState(() {
        _isBikeStarted = !_isBikeStarted;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isBikeStarted
                  ? '⚡ RV400 Ignition Powered ON!'
                  : 'RV400 Ignition Turned OFF.',
            ),
            backgroundColor: _isBikeStarted ? Colors.green.shade800 : Colors.blueGrey,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send $command: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSendingCommand = false;
        });
      }
    }
  }
}
