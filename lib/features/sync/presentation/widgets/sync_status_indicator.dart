import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/sync_history_log.dart';

class SyncStatusIndicator extends ConsumerWidget {
  const SyncStatusIndicator({super.key});

  void _showHistoryModal(BuildContext context, WidgetRef ref) async {
    final historyService = ref.read(syncHistoryLogServiceProvider);
    final history = await historyService.getSyncHistory(limit: 20);

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sync History Logs',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(),
              if (history.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No sync history recorded yet.'),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final item = history[index];
                      final timeStr =
                          item.syncedAt.toIso8601String().substring(11, 16);
                      final dateStr =
                          item.syncedAt.toIso8601String().substring(0, 10);
                      return ListTile(
                        leading: Icon(
                          item.result == 'success'
                              ? Icons.check_circle
                              : (item.result == 'conflict'
                                  ? Icons.warning
                                  : Icons.info_outline),
                          color: item.result == 'success'
                              ? Colors.green
                              : (item.result == 'conflict'
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                        title: Text(
                          '${item.result.toUpperCase()} — $dateStr $timeStr',
                          style: const TextStyle(fontSize: 13),
                        ),
                        subtitle: Text(
                          'Rides added: ${item.ridesAdded} ${item.detailsJson != null ? "(${item.detailsJson})" : ""}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(syncHistoryLogServiceProvider);

    return FutureBuilder(
      future: historyAsync.getLastSyncTime(),
      builder: (context, snapshot) {
        final lastSyncedAt = snapshot.data;
        MaterialColor statusColor = Colors.red;
        String statusText = 'Not synced today';

        if (lastSyncedAt != null) {
          final diff = DateTime.now().difference(lastSyncedAt);
          if (diff.inMinutes < 5) {
            statusColor = Colors.green;
            statusText = 'Synced just now';
          } else if (diff.inHours < 24) {
            statusColor = Colors.amber;
            statusText = 'Synced ${diff.inHours}h ago';
          } else {
            statusColor = Colors.red;
            statusText = 'Not synced today';
          }
        }

        return GestureDetector(
          onTap: () => _showHistoryModal(context, ref),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: statusColor,
                ),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor.shade900,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
