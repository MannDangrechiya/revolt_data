// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_gap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Legacy alias / delegate for SyncEngineNotifier

@ProviderFor(SyncGapNotifier)
final syncGapProvider = SyncGapNotifierProvider._();

/// Legacy alias / delegate for SyncEngineNotifier
final class SyncGapNotifierProvider
    extends $NotifierProvider<SyncGapNotifier, SyncEngineState> {
  /// Legacy alias / delegate for SyncEngineNotifier
  SyncGapNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncGapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncGapNotifierHash();

  @$internal
  @override
  SyncGapNotifier create() => SyncGapNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncEngineState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncEngineState>(value),
    );
  }
}

String _$syncGapNotifierHash() => r'770fb3a741327b49ddcb87038be77d4c74df47db';

/// Legacy alias / delegate for SyncEngineNotifier

abstract class _$SyncGapNotifier extends $Notifier<SyncEngineState> {
  SyncEngineState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SyncEngineState, SyncEngineState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncEngineState, SyncEngineState>,
              SyncEngineState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
