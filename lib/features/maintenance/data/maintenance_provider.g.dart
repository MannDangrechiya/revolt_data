// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MaintenanceLogs)
final maintenanceLogsProvider = MaintenanceLogsProvider._();

final class MaintenanceLogsProvider
    extends $StreamNotifierProvider<MaintenanceLogs, List<MaintenanceLog>> {
  MaintenanceLogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'maintenanceLogsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$maintenanceLogsHash();

  @$internal
  @override
  MaintenanceLogs create() => MaintenanceLogs();
}

String _$maintenanceLogsHash() => r'fa151010ec44a1f5e3289039771c4fd21df8c780';

abstract class _$MaintenanceLogs extends $StreamNotifier<List<MaintenanceLog>> {
  Stream<List<MaintenanceLog>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MaintenanceLog>>, List<MaintenanceLog>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MaintenanceLog>>,
                List<MaintenanceLog>
              >,
              AsyncValue<List<MaintenanceLog>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(maintenanceByComponent)
final maintenanceByComponentProvider = MaintenanceByComponentProvider._();

final class MaintenanceByComponentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<MaintenanceComponent, List<MaintenanceLog>>>,
          Map<MaintenanceComponent, List<MaintenanceLog>>,
          FutureOr<Map<MaintenanceComponent, List<MaintenanceLog>>>
        >
    with
        $FutureModifier<Map<MaintenanceComponent, List<MaintenanceLog>>>,
        $FutureProvider<Map<MaintenanceComponent, List<MaintenanceLog>>> {
  MaintenanceByComponentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'maintenanceByComponentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$maintenanceByComponentHash();

  @$internal
  @override
  $FutureProviderElement<Map<MaintenanceComponent, List<MaintenanceLog>>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<MaintenanceComponent, List<MaintenanceLog>>> create(Ref ref) {
    return maintenanceByComponent(ref);
  }
}

String _$maintenanceByComponentHash() =>
    r'5e83fe204044eb7387b6891d37f8c02284069da4';
