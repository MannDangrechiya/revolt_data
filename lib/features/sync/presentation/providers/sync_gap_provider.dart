import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'sync_engine_notifier.dart';

part 'sync_gap_provider.g.dart';

/// Legacy alias / delegate for SyncEngineNotifier
@riverpod
class SyncGapNotifier extends _$SyncGapNotifier {
  @override
  SyncEngineState build() {
    return ref.watch(syncEngineNotifierProvider);
  }
}
