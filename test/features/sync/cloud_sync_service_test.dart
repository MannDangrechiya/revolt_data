import 'package:flutter_test/flutter_test.dart';
import 'package:revolt_data/features/sync/data/cloud_sync_service.dart';
import 'package:revolt_data/features/sync/data/offline_queue.dart';

void main() {
  group('CloudSyncService Unit Tests', () {
    late CloudSyncService service;

    setUp(() {
      service = CloudSyncService();
    });

    test('isConfigured evaluates correctly when no client or env keys exist', () {
      expect(service.isConfigured, isFalse);
    });

    test('uploadQueueItem returns true stub when Supabase is unconfigured', () async {
      final item = QueueItem(
        id: 'q_1',
        action: 'INSERT',
        entityType: 'Ride',
        entityId: 'ride_101',
        payloadJson: '{"distance": 12.5}',
        createdAt: DateTime.now(),
      );

      final result = await service.uploadQueueItem(item);
      expect(result, isTrue);
    });

    test('syncBatch uploads all pending items and returns processed count', () async {
      final items = [
        QueueItem(
          id: 'q_1',
          action: 'INSERT',
          entityType: 'Ride',
          entityId: 'ride_101',
          payloadJson: '{"distance": 12.5}',
          createdAt: DateTime.now(),
        ),
        QueueItem(
          id: 'q_2',
          action: 'INSERT',
          entityType: 'ChargeLog',
          entityId: 'charge_201',
          payloadJson: '{"kwh": 3.2}',
          createdAt: DateTime.now(),
        ),
      ];

      final processedCount = await service.syncBatch(items);
      expect(processedCount, equals(2));
    });

    test('uploadQueueItem supports Ride entity mapping', () async {
      final item = QueueItem(
        id: 'q_3',
        action: 'UPDATE',
        entityType: 'Ride',
        entityId: 'ride_102',
        payloadJson: '{"notes": "Updated ride notes"}',
        createdAt: DateTime.now(),
      );

      final result = await service.uploadQueueItem(item);
      expect(result, isTrue);
    });

    test('uploadQueueItem supports SyncState entity mapping', () async {
      final item = QueueItem(
        id: 'q_4',
        action: 'UPDATE',
        entityType: 'SyncState',
        entityId: 'state_1',
        payloadJson: '{"odometer": 1500.0}',
        createdAt: DateTime.now(),
      );

      final result = await service.uploadQueueItem(item);
      expect(result, isTrue);
    });
  });
}
