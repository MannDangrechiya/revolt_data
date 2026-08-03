// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardDataNotifier)
final dashboardDataProvider = DashboardDataNotifierProvider._();

final class DashboardDataNotifierProvider
    extends $StreamNotifierProvider<DashboardDataNotifier, DashboardData> {
  DashboardDataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardDataNotifierHash();

  @$internal
  @override
  DashboardDataNotifier create() => DashboardDataNotifier();
}

String _$dashboardDataNotifierHash() =>
    r'c02d22e780db9f5c4e98ff3f7a02cbe57eb30cf1';

abstract class _$DashboardDataNotifier extends $StreamNotifier<DashboardData> {
  Stream<DashboardData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DashboardData>, DashboardData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardData>, DashboardData>,
              AsyncValue<DashboardData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
