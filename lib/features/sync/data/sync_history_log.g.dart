// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_history_log.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncHistoryLogService)
final syncHistoryLogServiceProvider = SyncHistoryLogServiceProvider._();

final class SyncHistoryLogServiceProvider
    extends
        $FunctionalProvider<
          SyncHistoryLogService,
          SyncHistoryLogService,
          SyncHistoryLogService
        >
    with $Provider<SyncHistoryLogService> {
  SyncHistoryLogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncHistoryLogServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncHistoryLogServiceHash();

  @$internal
  @override
  $ProviderElement<SyncHistoryLogService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncHistoryLogService create(Ref ref) {
    return syncHistoryLogService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncHistoryLogService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncHistoryLogService>(value),
    );
  }
}

String _$syncHistoryLogServiceHash() =>
    r'1c38e04c7cc9936a18ebf56260cb556daed77b91';
