import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/widgets/not_found_widget.dart';
import '../data/charging_provider.dart';
import '../domain/charge_log.dart';

class ChargeDetailsScreen extends ConsumerWidget {
  final String chargeId;
  
  const ChargeDetailsScreen({super.key, required this.chargeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logAsync = ref.watch(chargeLogByIdProvider(chargeId));

    return logAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Charge Details')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => NotFoundWidget(
        message: 'Error loading charge log details: $err',
        returnRoute: '/charging',
      ),
      data: (log) {
        if (log == null) {
          return const NotFoundWidget(
            message: 'Charge log details not found or deleted.',
            returnRoute: '/charging',
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Charge Details'),
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.pencil),
                tooltip: 'Edit',
                onPressed: () => context.push('/charging/edit/${log.id}'),
              ),
            ],
          ),
          body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, MMMM d, yyyy').format(log.date),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSectionHeader('Overview', LucideIcons.zap),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildMetricCard(context, 'Energy', '${log.kwhAdded.toStringAsFixed(1)} kWh', LucideIcons.zap)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildMetricCard(context, 'Cost', '₹${log.cost.toStringAsFixed(2)}', LucideIcons.banknote)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildMetricCard(context, 'Duration', '${log.durationMinutes} mins', LucideIcons.clock)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildMetricCard(context, 'Avg Speed', '${log.chargingSpeedKw.toStringAsFixed(1)} kW', LucideIcons.gauge)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSectionHeader('Battery Details', LucideIcons.batteryCharging),
                  const SizedBox(height: 16),
                  _buildInfoRow('Start Battery', '${log.startBattery}%'),
                  _buildInfoRow('End Battery', '${log.endBattery}%'),
                  _buildInfoRow('Added', '${log.endBattery - log.startBattery}%'),
                  const SizedBox(height: 24),

                  _buildSectionHeader('Location & Charger', LucideIcons.mapPin),
                  const SizedBox(height: 16),
                  _buildInfoRow('Type', log.locationType.name.toUpperCase()),
                  if (log.locationName != null) _buildInfoRow('Name', log.locationName!),
                  if (log.chargerType != null) _buildInfoRow('Charger', log.chargerType!),
                  if (log.providerName != null) _buildInfoRow('Provider', log.providerName!),
                  if (log.maxChargingPowerKw != null) _buildInfoRow('Max Power', '${log.maxChargingPowerKw} kW'),
                  const SizedBox(height: 24),

                  _buildSectionHeader('Payment', LucideIcons.creditCard),
                  const SizedBox(height: 16),
                  _buildInfoRow('Method', log.paymentMethod.name.toUpperCase()),
                  const SizedBox(height: 24),

                  if (log.notes != null) ...[
                    _buildSectionHeader('Additional Information', LucideIcons.info),
                    const SizedBox(height: 16),
                    _buildInfoRow('Notes', log.notes!),
                    const SizedBox(height: 24),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
