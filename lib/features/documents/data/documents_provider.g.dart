// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Documents)
final documentsProvider = DocumentsProvider._();

final class DocumentsProvider
    extends $StreamNotifierProvider<Documents, List<Document>> {
  DocumentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentsHash();

  @$internal
  @override
  Documents create() => Documents();
}

String _$documentsHash() => r'84cf020c7570c74744ec0ee2e676c479b57855f9';

abstract class _$Documents extends $StreamNotifier<List<Document>> {
  Stream<List<Document>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Document>>, List<Document>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Document>>, List<Document>>,
              AsyncValue<List<Document>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(documentById)
final documentByIdProvider = DocumentByIdFamily._();

final class DocumentByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Document?>,
          Document?,
          FutureOr<Document?>
        >
    with $FutureModifier<Document?>, $FutureProvider<Document?> {
  DocumentByIdProvider._({
    required DocumentByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'documentByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentByIdHash();

  @override
  String toString() {
    return r'documentByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Document?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Document?> create(Ref ref) {
    final argument = this.argument as String;
    return documentById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentByIdHash() => r'd912587fe57d5e6e6b230a089da517ab53ed1dcd';

final class DocumentByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Document?>, String> {
  DocumentByIdFamily._()
    : super(
        retry: null,
        name: r'documentByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DocumentByIdProvider call(String id) =>
      DocumentByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'documentByIdProvider';
}
