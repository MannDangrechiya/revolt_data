import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../data/reminders_provider.dart';
import '../domain/reminder.dart';

class ReminderAddEditScreen extends ConsumerStatefulWidget {
  final Reminder? reminder;

  const ReminderAddEditScreen({super.key, this.reminder});

  @override
  ConsumerState<ReminderAddEditScreen> createState() => _ReminderAddEditScreenState();
}

class _ReminderAddEditScreenState extends ConsumerState<ReminderAddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _odometerController;
  late final TextEditingController _noteController;
  
  DateTime? _selectedDate;
  String _selectedType = 'Service';
  
  final List<String> _types = [
    'Service',
    'Insurance',
    'BatteryWarranty',
    'VehicleWarranty',
    'TyreReplacement',
    'BrakeInspection',
    'ChargerInspection',
    'Custom'
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder?.title ?? '');
    _bodyController = TextEditingController(text: widget.reminder?.body ?? '');
    _odometerController = TextEditingController(text: widget.reminder?.targetOdometer?.toString() ?? '');
    _noteController = TextEditingController(text: widget.reminder?.note ?? '');
    
    _selectedDate = widget.reminder?.targetDate;
    if (widget.reminder?.type != null && _types.contains(widget.reminder!.type!)) {
      _selectedType = widget.reminder!.type!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _odometerController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedDate == null && _odometerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set either a Target Date or Target Odometer.')),
      );
      return;
    }

    final reminder = Reminder(
      id: widget.reminder?.id ?? const Uuid().v4(),
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      targetDate: _selectedDate,
      targetOdometer: double.tryParse(_odometerController.text),
      type: _selectedType,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      isCompleted: widget.reminder?.isCompleted ?? false,
      isActive: widget.reminder?.isActive ?? true,
      isNotified: widget.reminder?.isNotified ?? false,
    );

    if (widget.reminder == null) {
      await ref.read(remindersProvider.notifier).addReminder(reminder);
    } else {
      await ref.read(remindersProvider.notifier).updateReminder(reminder);
    }
    
    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder == null ? 'Add Reminder' : 'Edit Reminder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Reminder Type',
                  prefixIcon: Icon(LucideIcons.listTodo),
                  border: OutlineInputBorder(),
                ),
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                      if (_titleController.text.isEmpty) {
                        _titleController.text = value;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(LucideIcons.type),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(LucideIcons.alignLeft),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              
              const SizedBox(height: 24),
              const Text('Triggers (Set at least one)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(LucideIcons.calendar),
                      title: Text(
                        _selectedDate == null 
                            ? 'Set Target Date' 
                            : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                      ),
                      trailing: _selectedDate != null 
                          ? IconButton(
                              icon: const Icon(LucideIcons.x, size: 20),
                              onPressed: () => setState(() => _selectedDate = null),
                            )
                          : const Icon(LucideIcons.chevronRight),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() => _selectedDate = date);
                        }
                      },
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: _odometerController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Target Odometer (km)',
                          prefixIcon: Icon(LucideIcons.gauge),
                          border: InputBorder.none,
                          hintText: 'e.g. 15000',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Personal Notes (Optional)',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(LucideIcons.penTool),
                  border: OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: FilledButton.icon(
                  onPressed: _saveReminder,
                  icon: const Icon(LucideIcons.save),
                  label: const Text('Save Reminder', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
