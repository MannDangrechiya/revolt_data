// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anti_theft_guard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AntiTheftGuard)
final antiTheftGuardProvider = AntiTheftGuardProvider._();

final class AntiTheftGuardProvider
    extends $NotifierProvider<AntiTheftGuard, AntiTheftState> {
  AntiTheftGuardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'antiTheftGuardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$antiTheftGuardHash();

  @$internal
  @override
  AntiTheftGuard create() => AntiTheftGuard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AntiTheftState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AntiTheftState>(value),
    );
  }
}

String _$antiTheftGuardHash() => r'eb714fbcd8612d12775696ebf91eca7facdb2c45';

abstract class _$AntiTheftGuard extends $Notifier<AntiTheftState> {
  AntiTheftState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AntiTheftState, AntiTheftState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AntiTheftState, AntiTheftState>,
              AntiTheftState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
