// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_state_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncStateService)
final syncStateServiceProvider = SyncStateServiceProvider._();

final class SyncStateServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SyncStateService>,
          SyncStateService,
          FutureOr<SyncStateService>
        >
    with $FutureModifier<SyncStateService>, $FutureProvider<SyncStateService> {
  SyncStateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncStateServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncStateServiceHash();

  @$internal
  @override
  $FutureProviderElement<SyncStateService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SyncStateService> create(Ref ref) {
    return syncStateService(ref);
  }
}

String _$syncStateServiceHash() => r'942aac43bd511d85d0b1eddbc70522ecb749dbd2';
