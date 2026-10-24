import 'package:flutter/material.dart';

import '../../domain/dashboard_data.dart';
import '../../../../core/widgets/animated_number.dart';

class DashboardQuickStatsRow extends StatelessWidget {
  final DashboardData data;

  const DashboardQuickStatsRow({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildStatBox(context, 'Today', data.todayDistance, ' km', 1)),
        const SizedBox(width: 10),
        Expanded(child: _buildStatBox(context, 'Week', data.weeklyDistance, ' km', 1)),
        const SizedBox(width: 10),
        Expanded(child: _buildStatBox(context, 'Month', data.monthlyDistance, ' km', 1)),
      ],
    );
  }

  Widget _buildStatBox(
    BuildContext context,
    String label,
    num value,
    String suffix,
    int fractionDigits,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedNumber(
            value: value,
            suffix: suffix,
            fractionDigits: fractionDigits,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
