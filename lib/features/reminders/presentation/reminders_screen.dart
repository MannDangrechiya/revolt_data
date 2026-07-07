import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../data/reminders_provider.dart';
import '../domain/reminder.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/error_retry_widget.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> {
  @override
  Widget build(BuildContext context) {
    final remindersAsync = ref.watch(remindersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return const EmptyStateWidget(
              title: 'No reminders set',
              message: 'Set reminders for service, insurance renewal, or part replacements.',
              icon: LucideIcons.bellRing,
            );
          }

          final activeReminders = reminders.where((r) => !r.isCompleted).toList();
          final completedReminders = reminders.where((r) => r.isCompleted).toList();

          return CustomScrollView(
            slivers: [
              if (activeReminders.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text('Active', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildReminderCard(activeReminders[index]),
                    childCount: activeReminders.length,
                  ),
                ),
              ],
              if (completedReminders.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Text('Completed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildReminderCard(completedReminders[index]),
                    childCount: completedReminders.length,
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(16.0),
          child: ListSkeletonLoader(itemCount: 6, itemHeight: 90),
        ),
        error: (err, stack) => ErrorRetryWidget(
          message: err.toString(),
          onRetry: () => ref.refresh(remindersProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/reminders/add'),
        icon: const Icon(LucideIcons.plus),
        label: const Text('New Reminder'),
      ),
    );
  }

  Widget _buildReminderCard(Reminder reminder) {
    return Dismissible(
      key: Key(reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(LucideIcons.trash2, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(remindersProvider.notifier).removeReminder(reminder.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () => context.push('/reminders/edit', extra: reminder),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: reminder.isCompleted 
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              reminder.isCompleted ? LucideIcons.checkCircle : LucideIcons.bell,
              color: reminder.isCompleted 
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          title: Text(
            reminder.title,
            style: TextStyle(
              decoration: reminder.isCompleted ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reminder.body),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (reminder.targetDate != null) ...[
                    const Icon(LucideIcons.calendar, size: 14),
                    const SizedBox(width: 4),
                    Text(DateFormat.yMMMd().format(reminder.targetDate!)),
                  ],
                  if (reminder.targetDate != null && reminder.targetOdometer != null)
                    const SizedBox(width: 12),
                  if (reminder.targetOdometer != null) ...[
                    const Icon(LucideIcons.gauge, size: 14),
                    const SizedBox(width: 4),
                    Text('${reminder.targetOdometer} km'),
                  ],
                ],
              ),
            ],
          ),
          trailing: Checkbox(
            value: reminder.isCompleted,
            onChanged: (val) {
              if (val != null) {
                final updated = reminder.copyWith(isCompleted: val);
                ref.read(remindersProvider.notifier).updateReminder(updated);
              }
            },
          ),
        ),
      ),
    );
  }
}
