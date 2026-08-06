import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_state.freezed.dart';
part 'sync_state.g.dart';

@freezed
abstract class SyncState with _$SyncState {
  const SyncState._();

  const factory SyncState({
    required double lastSyncedOdometer,
    required DateTime lastSyncedAt,
    required int lastKnownBatteryPercent,
  }) = _SyncState;

  factory SyncState.fromJson(Map<String, dynamic> json) =>
      _$SyncStateFromJson(json);

  /// Auto-calculates if this sync state was recorded on a different calendar day relative to current local time.
  bool get isFirstConnectOfDay {
    final now = DateTime.now();
    final last = lastSyncedAt.toLocal();
    return now.year != last.year ||
        now.month != last.month ||
        now.day != last.day;
  }
}
