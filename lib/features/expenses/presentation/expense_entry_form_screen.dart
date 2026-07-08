import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../data/expenses_provider.dart';
import '../domain/expense.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ExpenseEntryFormScreen extends HookConsumerWidget {
  final Expense? expense;

  const ExpenseEntryFormScreen({super.key, this.expense});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = expense != null;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final date = useState(expense?.date ?? DateTime.now());
    final category = useState(expense?.category ?? ExpenseCategory.service);
    final amountController = useTextEditingController(text: expense != null ? expense!.amount.toString() : '');
    final notesController = useTextEditingController(text: expense?.notes ?? '');
    final descriptionController = useTextEditingController(text: expense?.description ?? '');
    final receiptPhoto = useState<String?>(expense?.receiptPhotoPath);

    Future<void> pickReceipt() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(pickedFile.path);
        final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
        receiptPhoto.value = savedImage.path;
      }
    }

    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      isSubmitting.value = true;

      try {
        final result = Expense(
          id: expense?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          date: date.value,
          category: category.value,
          amount: double.parse(amountController.text),
          notes: notesController.text.isEmpty ? null : notesController.text,
          description: descriptionController.text.isEmpty ? null : descriptionController.text,
          receiptPhotoPath: receiptPhoto.value,
        );

        if (isEditing) {
          await ref.read(expensesProvider.notifier).updateExpense(result);
        } else {
          await ref.read(expensesProvider.notifier).addExpense(result);
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
        title: Text(isEditing ? 'Edit Expense' : 'Add Expense'),
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
            DropdownButtonFormField<ExpenseCategory>(
              initialValue: category.value,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: ExpenseCategory.values.map((c) => DropdownMenuItem(value: c, child: Text(c.name.toUpperCase()))).toList(),
              onChanged: (v) {
                if (v != null) category.value = v;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount (₹)', border: OutlineInputBorder()),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (double.tryParse(v) == null) return 'Invalid amount';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder()),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            const Text('Receipt Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (receiptPhoto.value != null)
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(File(receiptPhoto.value!), height: 200, fit: BoxFit.cover),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => receiptPhoto.value = null,
                  ),
                ],
              )
            else
              ElevatedButton.icon(
                onPressed: pickReceipt,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture Receipt'),
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
              child: const Text('Save Expense'),
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
