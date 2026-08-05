import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DashboardServiceIntelligenceCard extends StatelessWidget {
  final String prediction;

  const DashboardServiceIntelligenceCard({
    super.key,
    required this.prediction,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = prediction.contains('overdue');
    final color = isOverdue ? Colors.red : Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wrench, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              prediction,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
