import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DashboardSmartAlertsCard extends StatelessWidget {
  final List<String> alerts;

  const DashboardSmartAlertsCard({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alerts
          .map((alert) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.lightbulb, color: Colors.blue, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        alert,
                        style: const TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
