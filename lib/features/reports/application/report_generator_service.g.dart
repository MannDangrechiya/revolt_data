// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_generator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportGeneratorService)
final reportGeneratorServiceProvider = ReportGeneratorServiceProvider._();

final class ReportGeneratorServiceProvider
    extends $NotifierProvider<ReportGeneratorService, void> {
  ReportGeneratorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportGeneratorServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportGeneratorServiceHash();

  @$internal
  @override
  ReportGeneratorService create() => ReportGeneratorService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$reportGeneratorServiceHash() =>
    r'20ac7a848a8c6e5694c6a98f743bbbc70a5e362a';

abstract class _$ReportGeneratorService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
