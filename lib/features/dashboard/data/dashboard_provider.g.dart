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
    r'2b0d7cc8053e0f9812d61869bd1358d3a6859a08';

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
