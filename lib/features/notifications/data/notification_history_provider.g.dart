// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationHistoryNotifier)
final notificationHistoryProvider = NotificationHistoryNotifierProvider._();

final class NotificationHistoryNotifierProvider
    extends
        $StreamNotifierProvider<
          NotificationHistoryNotifier,
          List<NotificationHistory>
        > {
  NotificationHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHistoryNotifierHash();

  @$internal
  @override
  NotificationHistoryNotifier create() => NotificationHistoryNotifier();
}

String _$notificationHistoryNotifierHash() =>
    r'21fe7ce70bd10ebf448618f538513ce28a17b10a';

abstract class _$NotificationHistoryNotifier
    extends $StreamNotifier<List<NotificationHistory>> {
  Stream<List<NotificationHistory>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<NotificationHistory>>,
              List<NotificationHistory>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NotificationHistory>>,
                List<NotificationHistory>
              >,
              AsyncValue<List<NotificationHistory>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
