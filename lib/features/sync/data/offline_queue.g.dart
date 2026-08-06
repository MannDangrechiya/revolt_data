// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_queue.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(offlineQueue)
final offlineQueueProvider = OfflineQueueProvider._();

final class OfflineQueueProvider
    extends $FunctionalProvider<OfflineQueue, OfflineQueue, OfflineQueue>
    with $Provider<OfflineQueue> {
  OfflineQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineQueueHash();

  @$internal
  @override
  $ProviderElement<OfflineQueue> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OfflineQueue create(Ref ref) {
    return offlineQueue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OfflineQueue value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OfflineQueue>(value),
    );
  }
}

String _$offlineQueueHash() => r'2d717ab8e4c29888dd0211afc19da17e8cf5f11a';
