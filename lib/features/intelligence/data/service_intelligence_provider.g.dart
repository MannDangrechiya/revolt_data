// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_intelligence_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Predicts the next service using whatever the last MaintenanceLog actually
/// recorded (nextServiceDueOdometer / nextServiceDueDate), falling back to a
/// generic interval only when the log didn't set one. Ride frequency
/// converts a km target into an estimated day count for the overdue case.

@ProviderFor(serviceIntelligence)
final serviceIntelligenceProvider = ServiceIntelligenceProvider._();

/// Predicts the next service using whatever the last MaintenanceLog actually
/// recorded (nextServiceDueOdometer / nextServiceDueDate), falling back to a
/// generic interval only when the log didn't set one. Ride frequency
/// converts a km target into an estimated day count for the overdue case.

final class ServiceIntelligenceProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Predicts the next service using whatever the last MaintenanceLog actually
  /// recorded (nextServiceDueOdometer / nextServiceDueDate), falling back to a
  /// generic interval only when the log didn't set one. Ride frequency
  /// converts a km target into an estimated day count for the overdue case.
  ServiceIntelligenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceIntelligenceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceIntelligenceHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return serviceIntelligence(ref);
  }
}

String _$serviceIntelligenceHash() =>
    r'7a739dd83f240a2fba52eb3b5bbd40c27b542f0d';
