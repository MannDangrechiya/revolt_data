import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/maintenance_provider.dart';
import '../domain/maintenance_log.dart';

class MaintenanceEntryFormScreen extends HookConsumerWidget {
  const MaintenanceEntryFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final date = useState(DateTime.now());
    final component = useState(MaintenanceComponent.tires);
    final descriptionController = useTextEditingController();
    final odoController = useTextEditingController();
    final costController = useTextEditingController();

    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      isSubmitting.value = true;

      try {
        final log = MaintenanceLog(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          date: date.value,
          component: component.value,
          description: descriptionController.text,
          odometerReading: double.parse(odoController.text),
          cost: double.parse(costController.text),
        );

        await ref.read(maintenanceLogsProvider.notifier).addLog(log);
        if (context.mounted) context.pop();
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
        title: const Text('Log Maintenance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: isSubmitting.value ? null : submit,
          )
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
            DropdownButtonFormField<MaintenanceComponent>(
              initialValue: component.value,
              decoration: const InputDecoration(labelText: 'Component', border: OutlineInputBorder()),
              items: MaintenanceComponent.values.map((c) => DropdownMenuItem(value: c, child: Text(c.name.toUpperCase()))).toList(),
              onChanged: (v) {
                if (v != null) component.value = v;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: odoController,
                    decoration: const InputDecoration(labelText: 'Odometer (km)', border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                    controller: costController,
                    decoration: const InputDecoration(labelText: 'Cost (\$)', border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            ElevatedButton(
              onPressed: isSubmitting.value ? null : submit,
              child: const Text('Save Maintenance Log'),
            ),
          ],
        ),
      ),
    );
  }
}
