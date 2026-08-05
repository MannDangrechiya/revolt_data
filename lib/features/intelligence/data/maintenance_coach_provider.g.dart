// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_coach_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(maintenanceCoach)
final maintenanceCoachProvider = MaintenanceCoachProvider._();

final class MaintenanceCoachProvider
    extends
        $FunctionalProvider<
          AsyncValue<MaintenanceCoachTip>,
          MaintenanceCoachTip,
          FutureOr<MaintenanceCoachTip>
        >
    with
        $FutureModifier<MaintenanceCoachTip>,
        $FutureProvider<MaintenanceCoachTip> {
  MaintenanceCoachProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'maintenanceCoachProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$maintenanceCoachHash();

  @$internal
  @override
  $FutureProviderElement<MaintenanceCoachTip> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MaintenanceCoachTip> create(Ref ref) {
    return maintenanceCoach(ref);
  }
}

String _$maintenanceCoachHash() => r'7f5b682fa3d79895a0d6d1152742d3b53bcd2d0e';
