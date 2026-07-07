import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/theme_extension.dart';
import '../../core/theme/sizes.dart';

class VoltFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  const VoltFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(LucideIcons.plus),
      label: const Text("Add"),
      backgroundColor: context.colorScheme.primary,
      foregroundColor: context.colorScheme.onPrimary,
    );
  }
}

void showVoltQuickActionsMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Quick Actions",
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Sizes.paddingMedium),
              ListTile(
                leading: const Icon(LucideIcons.bike),
                title: const Text("Start Ride"),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Start Ride
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.zap),
                title: const Text("Add Charge"),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Add Charge
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.wallet),
                title: const Text("Add Expense"),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Add Expense
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.wrench),
                title: const Text("Add Maintenance"),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Add Maintenance
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
