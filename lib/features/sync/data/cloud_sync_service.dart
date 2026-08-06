import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/env_config.dart';
import 'offline_queue.dart';

/// Service responsible for syncing local offline queue data with Supabase Cloud
class CloudSyncService {
  final SupabaseClient? _client;

  CloudSyncService({SupabaseClient? client}) : _client = client;

  bool get isConfigured => EnvConfig.isSupabaseConfigured || _client != null;

  /// Uploads pending queue payload items to Supabase table
  Future<bool> uploadQueueItem(QueueItem item) async {
    if (!isConfigured) {
      debugPrint('[CloudSyncService] Supabase not configured. Stubbing upload for item ${item.id}');
      return true; // Stub success for offline mode / dev environment
    }

    try {
      final client = _client ?? Supabase.instance.client;
      final tableName = _resolveTableName(item.entityType);

      await client.from(tableName).upsert({
        'id': item.entityId,
        'action': item.action,
        'payload': item.payloadJson,
        'created_at': item.createdAt.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      debugPrint('[CloudSyncService] Successfully synced ${item.entityType} ${item.entityId} to Supabase');
      return true;
    } catch (e) {
      debugPrint('[CloudSyncService] Error syncing item ${item.id} to Supabase: $e');
      return false;
    }
  }

  /// Bulk sync items to Supabase
  Future<int> syncBatch(List<QueueItem> items) async {
    int count = 0;
    for (final item in items) {
      final success = await uploadQueueItem(item);
      if (success) {
        count++;
      }
    }
    return count;
  }

  String _resolveTableName(String entityType) {
    switch (entityType.toLowerCase()) {
      case 'ride':
        return 'cloud_rides';
      case 'chargelog':
      case 'charge':
        return 'cloud_charges';
      case 'syncstate':
        return 'cloud_sync_states';
      default:
        return 'cloud_sync_queue';
    }
  }
}
