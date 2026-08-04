// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_clear_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clearAllData)
final clearAllDataProvider = ClearAllDataProvider._();

final class ClearAllDataProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  ClearAllDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearAllDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearAllDataHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return clearAllData(ref);
  }
}

String _$clearAllDataHash() => r'2e116954c3ea995fbe254961e8ba465ec4f1ff66';
