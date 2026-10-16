import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../ble/domain/connection_state.dart';
import '../../ble/presentation/providers/ble_connection_provider.dart';
import '../../../shared/ui/volt_app_bar.dart';
import '../../../shared/ui/volt_card.dart';

class SoundProfile {
  final int id;
  final String name;
  final String subtitle;
  final String command;
  final IconData icon;
  final Color accentColor;

  const SoundProfile({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.command,
    required this.icon,
    required this.accentColor,
  });
}

const List<SoundProfile> kRevoltSoundProfiles = [
  SoundProfile(
    id: 0,
    name: 'Revolt',
    subtitle: 'Signature futuristic electric turbine hum',
    command: 'SOUND0#',
    icon: LucideIcons.zap,
    accentColor: Colors.cyan,
  ),
  SoundProfile(
    id: 1,
    name: 'Roar',
    subtitle: 'Deep cruiser combustion engine rumble',
    command: 'SOUND1#',
    icon: LucideIcons.flame,
    accentColor: Colors.deepOrange,
  ),
  SoundProfile(
    id: 2,
    name: 'Rebel',
    subtitle: 'Sporty twin-cylinder aggressive exhaust note',
    command: 'SOUND2#',
    icon: LucideIcons.gauge,
    accentColor: Colors.purpleAccent,
  ),
  SoundProfile(
    id: 3,
    name: 'Rage',
    subtitle: 'High-revving inline-4 superbike howl',
    command: 'SOUND3#',
    icon: LucideIcons.activity,
    accentColor: Colors.redAccent,
  ),
];

class SoundStudioScreen extends ConsumerStatefulWidget {
  const SoundStudioScreen({super.key});

  @override
  ConsumerState<SoundStudioScreen> createState() => _SoundStudioScreenState();
}

class _SoundStudioScreenState extends ConsumerState<SoundStudioScreen> {
  int _selectedProfileId = 0;
  double _volume = 80.0;
  bool _isSpeakerEnabled = true;
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    final bleState = ref.watch(bleConnectionStateProvider).value ??
        BleConnectionState.disconnected;
    final isConnected = bleState == BleConnectionState.connected ||
        bleState == BleConnectionState.authenticated;

    return Scaffold(
      appBar: const VoltAppBar(title: 'Revolt Sound Studio'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoltCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isSpeakerEnabled ? LucideIcons.volume2 : LucideIcons.volumeX,
                            color: _isSpeakerEnabled
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Acoustic Sound System',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                _isSpeakerEnabled ? 'Speaker Active' : 'Speaker Muted',
                                style: TextStyle(
                                  color: _isSpeakerEnabled ? Colors.green : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _isSpeakerEnabled,
                        onChanged: (val) async {
                          setState(() => _isSpeakerEnabled = val);
                          if (isConnected) {
                            final cmd = val ? 'SOUND$_selectedProfileId#' : 'SOUND_OFF#';
                            await _sendCommand(cmd);
                          }
                        },
                      ),
                    ],
                  ),
                  if (_isSpeakerEnabled) ...[
                    const Divider(height: 28),
                    Row(
                      children: [
                        const Icon(LucideIcons.volume1, size: 18, color: Colors.grey),
                        Expanded(
                          child: Slider(
                            value: _volume,
                            min: 0,
                            max: 100,
                            divisions: 20,
                            label: '${_volume.round()}%',
                            onChanged: (val) {
                              setState(() => _volume = val);
                            },
                            onChangeEnd: (val) async {
                              if (isConnected) {
                                await _sendCommand('VOLUME${val.round()}#');
                              }
                            },
                          ),
                        ),
                        Text(
                          '${_volume.round()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Exhaust Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...kRevoltSoundProfiles.map((profile) {
              final isSelected = _selectedProfileId == profile.id && _isSpeakerEnabled;

              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: InkWell(
                  onTap: () async {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _selectedProfileId = profile.id;
                      _isSpeakerEnabled = true;
                    });
                    if (isConnected) {
                      await _sendCommand(profile.command);
                    }
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? profile.accentColor : Theme.of(context).colorScheme.outlineVariant,
                        width: isSelected ? 2.0 : 1.0,
                      ),
                      color: isSelected
                          ? profile.accentColor.withValues(alpha: 0.1)
                          : Theme.of(context).colorScheme.surface,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: profile.accentColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(profile.icon, color: profile.accentColor, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    profile.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: profile.accentColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'ACTIVE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profile.subtitle,
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isSelected ? LucideIcons.disc : LucideIcons.circle,
                          color: isSelected ? profile.accentColor : Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (!isConnected)
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(LucideIcons.info, size: 18, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Connect bike via Bluetooth to preview and apply exhaust sound profiles directly to the motorcycle speaker.',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
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

  Future<void> _sendCommand(String cmd) async {
    if (_isSending) return;
    setState(() => _isSending = true);
    try {
      final repo = ref.read(bleRepositoryProvider);
      await repo.sendCommand(cmd);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sound profile updated: $cmd'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update sound: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}
