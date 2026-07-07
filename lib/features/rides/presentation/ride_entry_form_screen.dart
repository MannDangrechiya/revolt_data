import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../data/rides_provider.dart';
import '../domain/ride.dart';

class RideEntryFormScreen extends HookConsumerWidget {
  const RideEntryFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    
    final selectedDate = useState(DateTime.now());
    final startTime = useState<TimeOfDay?>(null);
    final endTime = useState<TimeOfDay?>(null);
    
    final startOdoController = useTextEditingController();
    final endOdoController = useTextEditingController();
    final batteryBeforeController = useTextEditingController();
    final batteryAfterController = useTextEditingController();
    
    final estRemainingRangeController = useTextEditingController();
    final avgSpeedController = useTextEditingController();
    final maxSpeedController = useTextEditingController();
    final passengerCountController = useTextEditingController(text: '1');
    
    final startLocationController = useTextEditingController();
    final endLocationController = useTextEditingController();
    
    final notesController = useTextEditingController();
    final routeNotesController = useTextEditingController();
    final customTagsController = useTextEditingController();

    final rideMode = useState(RideMode.normal);
    final roadCondition = useState(RoadCondition.average);
    final weather = useState<String?>(null);
    final roadType = useState<String?>(null);
    final ridePurpose = useState<String?>(null);
    
    final photoPaths = useState<List<String>>([]);
    final isSubmitting = useState(false);

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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

      DateTime? startDateTime;
      DateTime? endDateTime;
      int? durationMinutes;

      if (startTime.value != null) {
        startDateTime = DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          startTime.value!.hour,
          startTime.value!.minute,
        );
      }
      if (endTime.value != null) {
         endDateTime = DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          endTime.value!.hour,
          endTime.value!.minute,
        );
        
        // Handle rides spanning past midnight
        if (startDateTime != null && endDateTime.isBefore(startDateTime)) {
          endDateTime = endDateTime.add(const Duration(days: 1));
        }
      }
      
      if (startDateTime != null && endDateTime != null) {
        durationMinutes = endDateTime.difference(startDateTime).inMinutes;
      }

      List<String> tags = [];
      if (customTagsController.text.isNotEmpty) {
        tags = customTagsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
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
          startTime: startDateTime,
          endTime: endDateTime,
          durationMinutes: durationMinutes,
          estimatedRemainingRange: double.tryParse(estRemainingRangeController.text),
          averageSpeed: double.tryParse(avgSpeedController.text),
          maxSpeed: double.tryParse(maxSpeedController.text),
          weather: weather.value,
          roadType: roadType.value,
          passengerCount: int.tryParse(passengerCountController.text),
          ridePurpose: ridePurpose.value,
          startLocation: startLocationController.text.isEmpty ? null : startLocationController.text,
          endLocation: endLocationController.text.isEmpty ? null : endLocationController.text,
          routeNotes: routeNotesController.text.isEmpty ? null : routeNotesController.text,
          customTags: tags,
        );

        await ref.read(ridesProvider.notifier).addRide(ride);
        if (context.mounted) {
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ride Log', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: isSubmitting.value ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(LucideIcons.check),
            onPressed: isSubmitting.value ? null : submit,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _buildSectionHeader('Date & Time', LucideIcons.clock),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Ride Date'),
              subtitle: Text(selectedDate.value.toString().split(' ')[0]),
              leading: const Icon(LucideIcons.calendar),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) selectedDate.value = date;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Start Time'),
                    subtitle: Text(startTime.value?.format(context) ?? 'Not set'),
                    leading: const Icon(LucideIcons.clock3),
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (time != null) startTime.value = time;
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('End Time'),
                    subtitle: Text(endTime.value?.format(context) ?? 'Not set'),
                    leading: const Icon(LucideIcons.clock7),
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (time != null) endTime.value = time;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Distance & Battery', LucideIcons.gauge),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TextFormField(controller: startOdoController, decoration: const InputDecoration(labelText: 'Start Odo (km)*'), keyboardType: TextInputType.number, validator: _requiredValidator)),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: endOdoController, decoration: const InputDecoration(labelText: 'End Odo (km)*'), keyboardType: TextInputType.number, validator: _requiredValidator)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: TextFormField(controller: batteryBeforeController, decoration: const InputDecoration(labelText: 'Battery Before (%)*'), keyboardType: TextInputType.number, validator: _requiredValidator)),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: batteryAfterController, decoration: const InputDecoration(labelText: 'Battery After (%)*'), keyboardType: TextInputType.number, validator: _requiredValidator)),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(controller: estRemainingRangeController, decoration: const InputDecoration(labelText: 'Est. Remaining Range (km)'), keyboardType: TextInputType.number),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Locations & Route', LucideIcons.mapPin),
            const SizedBox(height: 16),
            TextFormField(controller: startLocationController, decoration: const InputDecoration(labelText: 'Start Location')),
            const SizedBox(height: 12),
            TextFormField(controller: endLocationController, decoration: const InputDecoration(labelText: 'End Location')),
            const SizedBox(height: 12),
            TextFormField(controller: routeNotesController, decoration: const InputDecoration(labelText: 'Route Notes'), maxLines: 2),

            const SizedBox(height: 32),
            _buildSectionHeader('Ride Details', LucideIcons.info),
            const SizedBox(height: 16),
            DropdownButtonFormField<RideMode>(
              value: rideMode.value,
              decoration: const InputDecoration(labelText: 'Ride Mode*'),
              items: RideMode.values.map((m) => DropdownMenuItem(value: m, child: Text(m.name.toUpperCase()))).toList(),
              onChanged: (v) { if (v != null) rideMode.value = v; },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<RoadCondition>(
              value: roadCondition.value,
              decoration: const InputDecoration(labelText: 'Road Condition*'),
              items: RoadCondition.values.map((c) => DropdownMenuItem(value: c, child: Text(c.name.toUpperCase()))).toList(),
              onChanged: (v) { if (v != null) roadCondition.value = v; },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: avgSpeedController, decoration: const InputDecoration(labelText: 'Avg Speed (km/h)'), keyboardType: TextInputType.number)),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: maxSpeedController, decoration: const InputDecoration(labelText: 'Max Speed (km/h)'), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: weather.value,
                    decoration: const InputDecoration(labelText: 'Weather'),
                    items: const [
                      DropdownMenuItem(value: 'Sunny', child: Text('Sunny')),
                      DropdownMenuItem(value: 'Cloudy', child: Text('Cloudy')),
                      DropdownMenuItem(value: 'Rainy', child: Text('Rainy')),
                      DropdownMenuItem(value: 'Night', child: Text('Night')),
                    ],
                    onChanged: (v) => weather.value = v,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: ridePurpose.value,
                    decoration: const InputDecoration(labelText: 'Purpose'),
                    items: const [
                      DropdownMenuItem(value: 'Commute', child: Text('Commute')),
                      DropdownMenuItem(value: 'Leisure', child: Text('Leisure')),
                      DropdownMenuItem(value: 'Errand', child: Text('Errand')),
                      DropdownMenuItem(value: 'Touring', child: Text('Touring')),
                    ],
                    onChanged: (v) => ridePurpose.value = v,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: roadType.value,
                    decoration: const InputDecoration(labelText: 'Road Type'),
                    items: const [
                      DropdownMenuItem(value: 'City', child: Text('City')),
                      DropdownMenuItem(value: 'Highway', child: Text('Highway')),
                      DropdownMenuItem(value: 'Off-road', child: Text('Off-road')),
                      DropdownMenuItem(value: 'Mixed', child: Text('Mixed')),
                    ],
                    onChanged: (v) => roadType.value = v,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(controller: passengerCountController, decoration: const InputDecoration(labelText: 'Passengers'), keyboardType: TextInputType.number)),
              ],
            ),

            const SizedBox(height: 32),
            _buildSectionHeader('Extra', LucideIcons.tag),
            const SizedBox(height: 16),
            TextFormField(controller: customTagsController, decoration: const InputDecoration(labelText: 'Tags (comma separated)')),
            const SizedBox(height: 12),
            TextFormField(controller: notesController, decoration: const InputDecoration(labelText: 'General Notes'), maxLines: 3),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Photos', LucideIcons.camera),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...photoPaths.value.map((path) => Stack(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(path), width: 80, height: 80, fit: BoxFit.cover)),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          photoPaths.value = photoPaths.value.where((p) => p != path).toList();
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                )),
                InkWell(
                  onTap: pickImage,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.camera, color: Colors.grey),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            FilledButton(
              onPressed: isSubmitting.value ? null : submit,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Save Ride Log'),
            ),
            const SizedBox(height: 40),
          ],
        ),
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

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    return null;
  }
}
