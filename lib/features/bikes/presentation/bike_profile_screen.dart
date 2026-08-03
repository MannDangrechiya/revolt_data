import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../data/bike_provider.dart';

class BikeProfileScreen extends HookConsumerWidget {
  const BikeProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBikeAsync = ref.watch(currentBikeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bike', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          currentBikeAsync.maybeWhen(
            data: (bike) => bike != null
                ? IconButton(
                    icon: const Icon(LucideIcons.edit2),
                    onPressed: () => context.push('/bike/edit'),
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: currentBikeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (bike) {
          if (bike == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.bike, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Bike Profile Found',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Create your first bike profile to get started.'),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.push('/bike/edit'),
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('Add Bike'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPhotoHeader(context, bike.photoPath, bike.name),
                const SizedBox(height: 24),
                _buildInfoSection(
                  context,
                  title: 'Primary Information',
                  icon: LucideIcons.info,
                  children: [
                    _buildInfoRow('Brand', bike.brand),
                    _buildInfoRow('Model', bike.model),
                    if (bike.variant != null && bike.variant!.isNotEmpty)
                      _buildInfoRow('Variant', bike.variant!),
                    _buildInfoRow('Color', bike.color),
                    _buildInfoRow('Registration No.', bike.registrationNumber),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoSection(
                  context,
                  title: 'Technical Specs',
                  icon: LucideIcons.settings,
                  children: [
                    if (bike.vin != null && bike.vin!.isNotEmpty) _buildInfoRow('VIN', bike.vin!),
                    if (bike.motorNumber != null && bike.motorNumber!.isNotEmpty) _buildInfoRow('Motor No.', bike.motorNumber!),
                    if (bike.batteryCapacity != null) _buildInfoRow('Battery Capacity', '${bike.batteryCapacity} kWh'),
                    if (bike.motorPower != null) _buildInfoRow('Motor Power', '${bike.motorPower} kW'),
                    if (bike.claimedRange != null) _buildInfoRow('Claimed Range', '${bike.claimedRange} km'),
                    if (bike.topSpeed != null) _buildInfoRow('Top Speed', '${bike.topSpeed} km/h'),
                    if (bike.tyreInfo != null && bike.tyreInfo!.isNotEmpty) _buildInfoRow('Tyres', bike.tyreInfo!),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoSection(
                  context,
                  title: 'Purchase & Warranty',
                  icon: LucideIcons.shieldCheck,
                  children: [
                    if (bike.purchaseDate != null)
                      _buildInfoRow('Purchase Date', bike.purchaseDate!.toString().split(' ')[0]),
                    if (bike.purchasePrice != null)
                      _buildInfoRow('Purchase Price', '₹${bike.purchasePrice}'),
                    if (bike.dealer != null && bike.dealer!.isNotEmpty) _buildInfoRow('Dealer', bike.dealer!),
                    if (bike.insurance != null && bike.insurance!.isNotEmpty) _buildInfoRow('Insurance', bike.insurance!),
                    if (bike.warranty != null && bike.warranty!.isNotEmpty) _buildInfoRow('Vehicle Warranty', bike.warranty!),
                    if (bike.batteryWarranty != null && bike.batteryWarranty!.isNotEmpty)
                      _buildInfoRow('Battery Warranty', bike.batteryWarranty!),
                  ],
                ),
                if (bike.customNotes != null && bike.customNotes!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildInfoSection(
                    context,
                    title: 'Notes',
                    icon: LucideIcons.fileText,
                    children: [
                      Text(bike.customNotes!),
                    ],
                  ),
                ],
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhotoHeader(BuildContext context, String? photoPath, String name) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            image: photoPath != null && photoPath.isNotEmpty
                ? DecorationImage(
                    image: FileImage(File(photoPath)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: photoPath == null || photoPath.isEmpty
              ? const Center(child: Icon(LucideIcons.camera, size: 48, color: Colors.grey))
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, {required String title, required IconData icon, required List<Widget> children}) {
    if (children.isEmpty) return const SizedBox.shrink();
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
