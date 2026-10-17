// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_export_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exportAllData)
final exportAllDataProvider = ExportAllDataProvider._();

final class ExportAllDataProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  ExportAllDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportAllDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportAllDataHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return exportAllData(ref);
  }
}

String _$exportAllDataHash() => r'54059ab6b74d6ffcebd549d1b43ca2752c8d6181';
