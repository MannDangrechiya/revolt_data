import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../domain/bike.dart';
import '../data/bike_provider.dart';

class BikeEditScreen extends HookConsumerWidget {
  const BikeEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBikeAsync = ref.watch(currentBikeProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    
    // Bike might be null if creating the first one
    final bike = currentBikeAsync.valueOrNull;
    final isNew = bike == null;

    final nameController = useTextEditingController(text: bike?.name ?? 'My RV400');
    final brandController = useTextEditingController(text: bike?.brand ?? 'Revolt');
    final modelController = useTextEditingController(text: bike?.model ?? 'RV400');
    final variantController = useTextEditingController(text: bike?.variant);
    final colorController = useTextEditingController(text: bike?.color ?? 'Rebel Red');
    final registrationNumberController = useTextEditingController(text: bike?.registrationNumber);
    final vinController = useTextEditingController(text: bike?.vin);
    final motorNumberController = useTextEditingController(text: bike?.motorNumber);
    
    final purchaseDate = useState<DateTime?>(bike?.purchaseDate);
    final purchasePriceController = useTextEditingController(text: bike?.purchasePrice?.toString());
    final dealerController = useTextEditingController(text: bike?.dealer);
    final insuranceController = useTextEditingController(text: bike?.insurance);
    final warrantyController = useTextEditingController(text: bike?.warranty);
    final batteryWarrantyController = useTextEditingController(text: bike?.batteryWarranty);
    
    final batteryCapacityController = useTextEditingController(text: bike?.batteryCapacity?.toString() ?? '3.24');
    final motorPowerController = useTextEditingController(text: bike?.motorPower?.toString() ?? '3.0');
    final claimedRangeController = useTextEditingController(text: bike?.claimedRange?.toString() ?? '150');
    final topSpeedController = useTextEditingController(text: bike?.topSpeed?.toString() ?? '85');
    final tyreInfoController = useTextEditingController(text: bike?.tyreInfo);
    final customNotesController = useTextEditingController(text: bike?.customNotes);
    
    final photoPath = useState<String?>(bike?.photoPath);

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(pickedFile.path);
        final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
        photoPath.value = savedImage.path;
      }
    }

    Future<void> saveBike() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;
      try {
        final updatedBike = Bike(
          id: bike?.id,
          name: nameController.text,
          brand: brandController.text,
          model: modelController.text,
          variant: variantController.text.isEmpty ? null : variantController.text,
          color: colorController.text,
          registrationNumber: registrationNumberController.text,
          vin: vinController.text.isEmpty ? null : vinController.text,
          motorNumber: motorNumberController.text.isEmpty ? null : motorNumberController.text,
          purchaseDate: purchaseDate.value,
          purchasePrice: double.tryParse(purchasePriceController.text),
          dealer: dealerController.text.isEmpty ? null : dealerController.text,
          insurance: insuranceController.text.isEmpty ? null : insuranceController.text,
          warranty: warrantyController.text.isEmpty ? null : warrantyController.text,
          batteryWarranty: batteryWarrantyController.text.isEmpty ? null : batteryWarrantyController.text,
          batteryCapacity: double.tryParse(batteryCapacityController.text),
          motorPower: double.tryParse(motorPowerController.text),
          claimedRange: double.tryParse(claimedRangeController.text),
          topSpeed: double.tryParse(topSpeedController.text),
          tyreInfo: tyreInfoController.text.isEmpty ? null : tyreInfoController.text,
          customNotes: customNotesController.text.isEmpty ? null : customNotesController.text,
          photoPath: photoPath.value,
        );

        if (isNew) {
          await ref.read(currentBikeProvider.notifier).saveBike(updatedBike);
        } else {
          await ref.read(currentBikeProvider.notifier).updateBike(updatedBike);
        }

        if (context.mounted) {
          context.pop();
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving bike: $e'), backgroundColor: Colors.red),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Add Bike' : 'Edit Bike', style: const TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: isLoading.value ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(LucideIcons.check),
            onPressed: isLoading.value ? null : saveBike,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                      image: photoPath.value != null
                          ? DecorationImage(
                              image: FileImage(File(photoPath.value!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: photoPath.value == null
                        ? const Icon(LucideIcons.camera, size: 40, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(LucideIcons.edit2, size: 20, color: Colors.white),
                        onPressed: pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Primary Information', LucideIcons.info),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nickname (e.g. My RV400)*', prefixIcon: Icon(LucideIcons.bike)),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: brandController, decoration: const InputDecoration(labelText: 'Brand*'), validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
                const SizedBox(width: 12),
                Expanded(child: TextFormField(controller: modelController, decoration: const InputDecoration(labelText: 'Model*'), validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: variantController, decoration: const InputDecoration(labelText: 'Variant'))),
                const SizedBox(width: 12),
                Expanded(child: TextFormField(controller: colorController, decoration: const InputDecoration(labelText: 'Color*'), validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: registrationNumberController,
              decoration: const InputDecoration(labelText: 'Registration Number*', prefixIcon: Icon(LucideIcons.fileText)),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Technical Specs', LucideIcons.settings),
            const SizedBox(height: 16),
            TextFormField(
              controller: vinController,
              decoration: const InputDecoration(labelText: 'VIN (Vehicle Identification Number)', prefixIcon: Icon(LucideIcons.hash)),
              validator: (v) {
                if (v != null && v.isNotEmpty && v.length != 17) {
                  return 'VIN is typically 17 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(controller: motorNumberController, decoration: const InputDecoration(labelText: 'Motor Number')),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: batteryCapacityController, decoration: const InputDecoration(labelText: 'Battery (kWh)'), keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: TextFormField(controller: motorPowerController, decoration: const InputDecoration(labelText: 'Motor (kW)'), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: claimedRangeController, decoration: const InputDecoration(labelText: 'Range (km)'), keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: TextFormField(controller: topSpeedController, decoration: const InputDecoration(labelText: 'Top Speed (km/h)'), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(controller: tyreInfoController, decoration: const InputDecoration(labelText: 'Tyre Info (e.g. 90/80-17 120/80-17)')),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Purchase & Warranty', LucideIcons.shieldCheck),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(LucideIcons.calendar),
              title: const Text('Purchase Date'),
              subtitle: Text(purchaseDate.value != null ? purchaseDate.value!.toString().split(' ')[0] : 'Not set'),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: purchaseDate.value ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) purchaseDate.value = date;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(controller: purchasePriceController, decoration: const InputDecoration(labelText: 'Purchase Price', prefixIcon: Icon(Icons.currency_rupee)), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            TextFormField(controller: dealerController, decoration: const InputDecoration(labelText: 'Dealer Name')),
            const SizedBox(height: 12),
            TextFormField(controller: insuranceController, decoration: const InputDecoration(labelText: 'Insurance Info')),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextFormField(controller: warrantyController, decoration: const InputDecoration(labelText: 'Vehicle Warranty'))),
                const SizedBox(width: 12),
                Expanded(child: TextFormField(controller: batteryWarrantyController, decoration: const InputDecoration(labelText: 'Battery Warranty'))),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Additional Info', LucideIcons.fileText),
            const SizedBox(height: 16),
            TextFormField(
              controller: customNotesController,
              decoration: const InputDecoration(labelText: 'Custom Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 40),
            FilledButton(
              onPressed: isLoading.value ? null : saveBike,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Save Bike Profile'),
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
}
