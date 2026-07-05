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

class ExpenseEntryFormScreen extends HookConsumerWidget {
  const ExpenseEntryFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final date = useState(DateTime.now());
    final category = useState(ExpenseCategory.service);
    final amountController = useTextEditingController();
    final notesController = useTextEditingController();
    final receiptPhoto = useState<String?>(null);

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
        final expense = Expense(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          date: date.value,
          category: category.value,
          amount: double.parse(amountController.text),
          notes: notesController.text.isEmpty ? null : notesController.text,
          receiptPhotoPath: receiptPhoto.value,
        );

        await ref.read(expensesProvider.notifier).addExpense(expense);
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
        title: const Text('Add Expense'),
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
              decoration: const InputDecoration(labelText: 'Amount (\$)', border: OutlineInputBorder()),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (double.tryParse(v) == null) return 'Invalid amount';
                return null;
              },
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
            ElevatedButton(
              onPressed: isSubmitting.value ? null : submit,
              child: const Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
