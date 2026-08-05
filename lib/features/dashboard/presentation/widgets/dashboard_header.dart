import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../ble/domain/connection_state.dart';
import '../../../ble/presentation/widgets/connection_status_badge.dart';
import '../../../../core/widgets/animated_number.dart';

class DashboardHeader extends StatelessWidget {
  final String bikeName;
  final BleConnectionState connectionStatus;
  final num currentOdometer;

  const DashboardHeader({
    super.key,
    required this.bikeName,
    required this.connectionStatus,
    required this.currentOdometer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Semantics(
                    button: true,
                    label: 'BLE Connection Status',
                    hint: 'Navigates to BLE device screen',
                    child: GestureDetector(
                      onTap: () => context.push('/device'),
                      child: ConnectionStatusBadge(
                        state: connectionStatus,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Semantics(
                button: true,
                label: 'Bike: $bikeName',
                hint: 'Navigates to bike details',
                child: InkWell(
                  onTap: () => context.push('/bike'),
                  child: Row(
                    children: [
                      Text(
                        bikeName,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        LucideIcons.chevronRight,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'ODO',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            AnimatedNumber(
              value: currentOdometer,
              suffix: ' km',
              fractionDigits: 1,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
