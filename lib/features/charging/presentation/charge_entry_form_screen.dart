import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/charging_provider.dart';
import '../domain/charge_log.dart';

class ChargeEntryFormScreen extends HookConsumerWidget {
  const ChargeEntryFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final date = useState(DateTime.now());
    final durationController = useTextEditingController();
    final kwhController = useTextEditingController();
    final costController = useTextEditingController();
    final startBatteryController = useTextEditingController();
    final endBatteryController = useTextEditingController();
    final locationNameController = useTextEditingController();
    final notesController = useTextEditingController();

    final paymentMethod = useState(PaymentMethod.creditCard);
    final locationType = useState(LocationType.home);

    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      isSubmitting.value = true;
      try {
        final log = ChargeLog(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
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
        );

        await ref.read(chargingLogsProvider.notifier).addChargeLog(log);
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
        title: const Text('Add Charge Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: isSubmitting.value ? null : submit,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: const Text('Date'),
              subtitle: Text(date.value.toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
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
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: startBatteryController,
                    decoration: const InputDecoration(labelText: 'Start Battery %', border: OutlineInputBorder()),
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
                    decoration: const InputDecoration(labelText: 'End Battery %', border: OutlineInputBorder()),
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
                    decoration: const InputDecoration(labelText: 'Duration (min)', border: OutlineInputBorder()),
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
                    decoration: const InputDecoration(labelText: 'Energy (kWh)', border: OutlineInputBorder()),
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
            const SizedBox(height: 16),
            TextFormField(
              controller: costController,
              decoration: const InputDecoration(labelText: 'Cost (\$)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final val = double.tryParse(v);
                if (val == null || val < 0) return 'Invalid';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LocationType>(
              initialValue: locationType.value,
              decoration: const InputDecoration(labelText: 'Location Type', border: OutlineInputBorder()),
              items: LocationType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name.toUpperCase()))).toList(),
              onChanged: (v) {
                if (v != null) locationType.value = v;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<PaymentMethod>(
              initialValue: paymentMethod.value,
              decoration: const InputDecoration(labelText: 'Payment Method', border: OutlineInputBorder()),
              items: PaymentMethod.values.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase()))).toList(),
              onChanged: (v) {
                if (v != null) paymentMethod.value = v;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: locationNameController,
              decoration: const InputDecoration(labelText: 'Location Name (Optional)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Save Charge Log'),
            ),
          ],
        ),
      ),
    );
  }
}
