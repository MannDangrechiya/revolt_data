import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/maintenance_provider.dart';
import '../domain/maintenance_log.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MaintenanceEntryFormScreen extends HookConsumerWidget {
  final MaintenanceLog? log;

  const MaintenanceEntryFormScreen({super.key, this.log});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = log != null;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final date = useState(log?.date ?? DateTime.now());
    final component = useState(log?.component ?? MaintenanceComponent.other);
    final descriptionController = useTextEditingController(text: log?.description ?? '');
    final odoController = useTextEditingController(text: log != null ? log!.odometerReading.toString() : '');
    final costController = useTextEditingController(text: log != null ? log!.cost.toString() : '');

    // New fields
    final serviceCenterController = useTextEditingController(text: log?.serviceCenter ?? '');
    final partsReplacedController = useTextEditingController(text: log?.partsReplaced ?? ''); // Simplified: just a text field for comma separated for now
    final labourCostController = useTextEditingController(text: log?.labourCost?.toString() ?? '');
    final technicianController = useTextEditingController(text: log?.technician ?? '');
    final notesController = useTextEditingController(text: log?.notes ?? '');
    final warrantyClaim = useState(log?.warrantyClaim ?? false);

    // Next service (stored as an absolute odometer; reconstruct the interval for editing)
    final serviceIntervalController = useTextEditingController(
      text: (log?.nextServiceDueOdometer != null)
          ? (log!.nextServiceDueOdometer! - log!.odometerReading).toString()
          : '',
    );

    // Checklist
    final chkTyres = useState(log?.tyres ?? false);
    final chkBrakes = useState(log?.brakes ?? false);
    final chkBattery = useState(log?.battery ?? false);
    final chkSuspension = useState(log?.suspension ?? false);
    final chkMotor = useState(log?.motor ?? false);
    final chkLights = useState(log?.lights ?? false);
    final chkHorn = useState(log?.horn ?? false);
    final chkSoftwareUpdate = useState(log?.softwareUpdate ?? false);
    final chkGeneralInspection = useState(log?.generalInspection ?? false);

    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      isSubmitting.value = true;

      try {
        double currentOdo = double.parse(odoController.text);
        double? nextDueOdo;
        if (serviceIntervalController.text.isNotEmpty) {
           nextDueOdo = currentOdo + double.parse(serviceIntervalController.text);
        }

        final entry = MaintenanceLog(
          id: log?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          date: date.value,
          component: component.value,
          description: descriptionController.text,
          odometerReading: currentOdo,
          cost: double.parse(costController.text),
          serviceCenter: serviceCenterController.text.isEmpty ? null : serviceCenterController.text,
          partsReplaced: partsReplacedController.text.isEmpty ? null : partsReplacedController.text,
          labourCost: labourCostController.text.isEmpty ? null : double.parse(labourCostController.text),
          technician: technicianController.text.isEmpty ? null : technicianController.text,
          notes: notesController.text.isEmpty ? null : notesController.text,
          warrantyClaim: warrantyClaim.value,
          nextServiceDueOdometer: nextDueOdo,
          
          tyres: chkTyres.value,
          brakes: chkBrakes.value,
          battery: chkBattery.value,
          suspension: chkSuspension.value,
          motor: chkMotor.value,
          lights: chkLights.value,
          horn: chkHorn.value,
          softwareUpdate: chkSoftwareUpdate.value,
          generalInspection: chkGeneralInspection.value,
        );

        if (isEditing) {
          await ref.read(maintenanceLogsProvider.notifier).updateLog(entry);
        } else {
          await ref.read(maintenanceLogsProvider.notifier).addLog(entry);
        }
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
        title: Text(isEditing ? 'Edit Maintenance' : 'Log Maintenance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: isSubmitting.value ? null : submit,
          )
        ],
      ),
      body: Stack(
        children: [
          Form(
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
              decoration: const InputDecoration(labelText: 'Primary Component', border: OutlineInputBorder()),
              items: MaintenanceComponent.values.map((c) => DropdownMenuItem(value: c, child: Text(c.name.toUpperCase()))).toList(),
              onChanged: (v) {
                if (v != null) component.value = v;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description / Title', border: OutlineInputBorder()),
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
                    decoration: const InputDecoration(labelText: 'Total Cost (₹)', border: OutlineInputBorder()),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: labourCostController,
                    decoration: const InputDecoration(labelText: 'Labour Cost (₹)', border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: serviceIntervalController,
                    decoration: const InputDecoration(labelText: 'Next Service In (km)', border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: serviceCenterController,
              decoration: const InputDecoration(labelText: 'Service Center', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: technicianController,
              decoration: const InputDecoration(labelText: 'Technician Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: partsReplacedController,
              decoration: const InputDecoration(labelText: 'Parts Replaced (comma separated)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Warranty Claim'),
              value: warrantyClaim.value,
              onChanged: (v) => warrantyClaim.value = v,
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Checklist', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(label: const Text('Tyres'), selected: chkTyres.value, onSelected: (v) => chkTyres.value = v),
                FilterChip(label: const Text('Brakes'), selected: chkBrakes.value, onSelected: (v) => chkBrakes.value = v),
                FilterChip(label: const Text('Battery'), selected: chkBattery.value, onSelected: (v) => chkBattery.value = v),
                FilterChip(label: const Text('Suspension'), selected: chkSuspension.value, onSelected: (v) => chkSuspension.value = v),
                FilterChip(label: const Text('Motor'), selected: chkMotor.value, onSelected: (v) => chkMotor.value = v),
                FilterChip(label: const Text('Lights'), selected: chkLights.value, onSelected: (v) => chkLights.value = v),
                FilterChip(label: const Text('Horn'), selected: chkHorn.value, onSelected: (v) => chkHorn.value = v),
                FilterChip(label: const Text('Software Update'), selected: chkSoftwareUpdate.value, onSelected: (v) => chkSoftwareUpdate.value = v),
                FilterChip(label: const Text('General Inspection'), selected: chkGeneralInspection.value, onSelected: (v) => chkGeneralInspection.value = v),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder()),
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
              child: Text(isEditing ? 'Update Maintenance Log' : 'Save Maintenance Log'),
            ),
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
}
