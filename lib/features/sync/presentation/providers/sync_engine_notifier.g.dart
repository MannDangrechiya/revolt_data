// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_engine_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncEngineNotifier)
final syncEngineProvider = SyncEngineNotifierProvider._();

final class SyncEngineNotifierProvider
    extends $NotifierProvider<SyncEngineNotifier, SyncEngineState> {
  SyncEngineNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncEngineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncEngineNotifierHash();

  @$internal
  @override
  SyncEngineNotifier create() => SyncEngineNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncEngineState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncEngineState>(value),
    );
  }
}

String _$syncEngineNotifierHash() =>
    r'27df66bfcd6c8dc9a5f7e4b9cf0a0405c71ef94f';

abstract class _$SyncEngineNotifier extends $Notifier<SyncEngineState> {
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
