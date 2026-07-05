import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../data/rides_provider.dart';
import '../domain/ride.dart';

class RideEntryFormScreen extends HookConsumerWidget {
  const RideEntryFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    
    final startOdoController = useTextEditingController();
    final endOdoController = useTextEditingController();
    final batteryBeforeController = useTextEditingController();
    final batteryAfterController = useTextEditingController();
    final notesController = useTextEditingController();

    final rideMode = useState(RideMode.normal);
    final roadCondition = useState(RoadCondition.average);
    final selectedDate = useState(DateTime.now());
    final photoPaths = useState<List<String>>([]);

    final isSubmitting = useState(false);

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(pickedFile.path);
        final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
        photoPaths.value = [...photoPaths.value, savedImage.path];
      }
    }

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      final startOdo = double.parse(startOdoController.text);
      final endOdo = double.parse(endOdoController.text);
      final batBefore = int.parse(batteryBeforeController.text);
      final batAfter = int.parse(batteryAfterController.text);

      if (endOdo <= startOdo) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End odometer must be greater than start odometer')),
        );
        return;
      }

      if (batAfter > batBefore) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Battery after cannot be greater than battery before')),
        );
        return;
      }

      isSubmitting.value = true;
      try {
        final ride = Ride(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          date: selectedDate.value,
          startOdometer: startOdo,
          endOdometer: endOdo,
          batteryBefore: batBefore,
          batteryAfter: batAfter,
          rideMode: rideMode.value,
          roadCondition: roadCondition.value,
          notes: notesController.text.isEmpty ? null : notesController.text,
          photoPaths: photoPaths.value,
        );

        await ref.read(ridesProvider.notifier).addRide(ride);
        if (context.mounted) {
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ride Log'),
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
              subtitle: Text(selectedDate.value.toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  selectedDate.value = date;
                }
              },
            ),
            const Divider(),
            _buildSectionHeader('Odometer (km)'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: startOdoController,
                    decoration: const InputDecoration(labelText: 'Start Odo', border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final val = double.tryParse(v);
                      if (val == null) return 'Invalid';
                      if (val < 0) return 'Must be ≥ 0';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: endOdoController,
                    decoration: const InputDecoration(labelText: 'End Odo', border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final val = double.tryParse(v);
                      if (val == null) return 'Invalid';
                      if (val < 0) return 'Must be ≥ 0';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Battery (%)'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: batteryBeforeController,
                    decoration: const InputDecoration(labelText: 'Before', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final val = int.tryParse(v);
                      if (val == null) return 'Invalid';
                      if (val < 0 || val > 100) return '0 - 100';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: batteryAfterController,
                    decoration: const InputDecoration(labelText: 'After', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final val = int.tryParse(v);
                      if (val == null) return 'Invalid';
                      if (val < 0 || val > 100) return '0 - 100';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Ride Settings'),
            DropdownButtonFormField<RideMode>(
              initialValue: rideMode.value,
              decoration: const InputDecoration(labelText: 'Ride Mode', border: OutlineInputBorder()),
              items: RideMode.values.map((m) {
                return DropdownMenuItem(
                  value: m,
                  child: Text(m.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) rideMode.value = v;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<RoadCondition>(
              initialValue: roadCondition.value,
              decoration: const InputDecoration(labelText: 'Road Condition', border: OutlineInputBorder()),
              items: RoadCondition.values.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(c.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) roadCondition.value = v;
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Photos'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...photoPaths.value.map((path) => Stack(
                  children: [
                    Image.file(File(path), width: 80, height: 80, fit: BoxFit.cover),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          photoPaths.value = photoPaths.value.where((p) => p != path).toList();
                        },
                        child: Container(
                          color: Colors.black54,
                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                )),
                InkWell(
                  onTap: pickImage,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.camera_alt, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: isSubmitting.value ? null : submit,
              child: const Text('Save Ride Log'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
