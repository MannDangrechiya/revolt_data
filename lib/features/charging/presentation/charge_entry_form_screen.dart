import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../data/charging_provider.dart';
import '../domain/charge_log.dart';

class ChargeEntryFormScreen extends HookConsumerWidget {
  final ChargeLog? log;

  const ChargeEntryFormScreen({super.key, this.log});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = log != null;
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final date = useState(log?.date ?? DateTime.now());
    final durationController = useTextEditingController(text: log != null ? log!.durationMinutes.toString() : '');
    final kwhController = useTextEditingController(text: log != null ? log!.kwhAdded.toString() : '');
    final costController = useTextEditingController(text: log != null ? log!.cost.toString() : '');
    final startBatteryController = useTextEditingController(text: log != null ? log!.startBattery.toString() : '');
    final endBatteryController = useTextEditingController(text: log != null ? log!.endBattery.toString() : '');
    final locationNameController = useTextEditingController(text: log?.locationName ?? '');
    final notesController = useTextEditingController(text: log?.notes ?? '');

    final chargerTypeController = useTextEditingController(text: log?.chargerType ?? '');
    final providerNameController = useTextEditingController(text: log?.providerName ?? '');
    final maxPowerController = useTextEditingController(text: log?.maxChargingPowerKw?.toString() ?? '');
    final speedController = useTextEditingController();

    final paymentMethod = useState(log?.paymentMethod ?? PaymentMethod.creditCard);
    final locationType = useState(log?.locationType ?? LocationType.home);

    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      isSubmitting.value = true;
      try {
        final entry = ChargeLog(
          id: log?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          date: date.value,
          durationMinutes: double.parse(durationController.text),
          kwhAdded: double.parse(kwhController.text),
          cost: double.parse(costController.text),
          paymentMethod: paymentMethod.value,
          locationType: locationType.value,
          startBattery: int.parse(startBatteryController.text),
          endBattery: int.parse(endBatteryController.text),
          locationName: locationNameController.text.isEmpty ? null : locationNameController.text,
          notes: notesController.text.isEmpty ? null : notesController.text,
          chargerType: chargerTypeController.text.isEmpty ? null : chargerTypeController.text,
          providerName: providerNameController.text.isEmpty ? null : providerNameController.text,
          maxChargingPowerKw: double.tryParse(maxPowerController.text),

        );

        if (isEditing) {
          await ref.read(chargingLogsProvider.notifier).updateChargeLog(entry);
        } else {
          await ref.read(chargingLogsProvider.notifier).addChargeLog(entry);
        }
        if (context.mounted) {
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '')),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Charge Log' : 'Add Charge Log', style: const TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: isSubmitting.value ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(LucideIcons.check),
            onPressed: isSubmitting.value ? null : submit,
          ),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
            _buildSectionHeader('Date & Time', LucideIcons.calendar),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Charge Date'),
              subtitle: Text(date.value.toString().split(' ')[0]),
              leading: const Icon(LucideIcons.calendar),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: date.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (d != null) date.value = d;
              },
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Battery & Energy', LucideIcons.batteryCharging),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: startBatteryController,
                    decoration: const InputDecoration(labelText: 'Start Battery %*'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final val = int.tryParse(v);
                      if (val == null || val < 0 || val > 100) return '0-100';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: endBatteryController,
                    decoration: const InputDecoration(labelText: 'End Battery %*'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final val = int.tryParse(v);
                      if (val == null || val < 0 || val > 100) return '0-100';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: durationController,
                    decoration: const InputDecoration(labelText: 'Duration (min)*'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (double.tryParse(v) == null) return 'Invalid';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: kwhController,
                    decoration: const InputDecoration(labelText: 'Energy (kWh)*'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (double.tryParse(v) == null) return 'Invalid';
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            _buildSectionHeader('Charger Details', LucideIcons.zap),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<LocationType>(
                    initialValue: locationType.value,
                    decoration: const InputDecoration(labelText: 'Location Type*'),
                    items: LocationType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name.toUpperCase()))).toList(),
                    onChanged: (v) {
                      if (v != null) locationType.value = v;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: locationNameController,
                    decoration: const InputDecoration(labelText: 'Location Name'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chargerTypeController,
                    decoration: const InputDecoration(labelText: 'Charger Type (e.g. AC)'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: providerNameController,
                    decoration: const InputDecoration(labelText: 'Provider (e.g. Revolt)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: maxPowerController,
                    decoration: const InputDecoration(labelText: 'Max Power (kW)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: speedController,
                    decoration: const InputDecoration(labelText: 'Speed (kW)', hintText: 'Auto-calc'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            _buildSectionHeader('Cost & Payment', LucideIcons.banknote),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: costController,
                    decoration: const InputDecoration(labelText: 'Cost (₹)*'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (double.tryParse(v) == null) return 'Invalid';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<PaymentMethod>(
                    initialValue: paymentMethod.value,
                    decoration: const InputDecoration(labelText: 'Payment Method*'),
                    items: PaymentMethod.values.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase()))).toList(),
                    onChanged: (v) {
                      if (v != null) paymentMethod.value = v;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            _buildSectionHeader('Extra', LucideIcons.tag),
            const SizedBox(height: 16),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.cloudOff, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text('Data is saved locally.', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: isSubmitting.value ? null : submit,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: Text(isEditing ? 'Update Charge Log' : 'Save Charge Log'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      if (isSubmitting.value)
        Container(
          color: Colors.black45,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
    ],
  ),
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
}
