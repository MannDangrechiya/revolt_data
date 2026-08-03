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

String _$maintenanceLogsHash() => r'407e8f25e6089d6cf43fd97fc42dd33de423627b';

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

@ProviderFor(maintenanceLogById)
final maintenanceLogByIdProvider = MaintenanceLogByIdFamily._();

final class MaintenanceLogByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<MaintenanceLog?>,
          MaintenanceLog?,
          FutureOr<MaintenanceLog?>
        >
    with $FutureModifier<MaintenanceLog?>, $FutureProvider<MaintenanceLog?> {
  MaintenanceLogByIdProvider._({
    required MaintenanceLogByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'maintenanceLogByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$maintenanceLogByIdHash();

  @override
  String toString() {
    return r'maintenanceLogByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MaintenanceLog?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MaintenanceLog?> create(Ref ref) {
    final argument = this.argument as String;
    return maintenanceLogById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MaintenanceLogByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$maintenanceLogByIdHash() =>
    r'6312e9f47b1ba3d6e9d2670ffb9c1940ed54db90';

final class MaintenanceLogByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MaintenanceLog?>, String> {
  MaintenanceLogByIdFamily._()
    : super(
        retry: null,
        name: r'maintenanceLogByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MaintenanceLogByIdProvider call(String id) =>
      MaintenanceLogByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'maintenanceLogByIdProvider';
}
