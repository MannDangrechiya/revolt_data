import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/reminders_provider.dart';

class RemindersScreen extends HookConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reminders & Alerts')),
      body: remindersAsync.when(
        data: (reminders) => reminders.isEmpty
            ? const Center(child: Text('No reminders scheduled.'))
            : ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return ListTile(
                    leading: Icon(
                      reminder.isCompleted ? Icons.check_circle : Icons.notifications_active,
                      color: reminder.isCompleted ? Colors.green : Colors.amber,
                    ),
                    title: Text(reminder.title),
                    subtitle: Text(
                      '${reminder.body}\n'
                      '${reminder.targetOdometer != null ? 'Target Odo: ${reminder.targetOdometer} km' : ''}'
                      '${reminder.targetDate != null ? 'Target Date: ${reminder.targetDate.toString().split(' ')[0]}' : ''}',
                    ),
                    trailing: reminder.isCompleted
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.done),
                            onPressed: () {
                              ref.read(remindersProvider.notifier).markCompleted(reminder.id);
                            },
                          ),
                    isThreeLine: true,
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
