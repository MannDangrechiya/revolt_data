// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Reminders)
final remindersProvider = RemindersProvider._();

final class RemindersProvider
    extends $StreamNotifierProvider<Reminders, List<Reminder>> {
  RemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersHash();

  @$internal
  @override
  Reminders create() => Reminders();
}

String _$remindersHash() => r'6b340a503f7e06e8af879e4d59873062a64e6e14';

abstract class _$Reminders extends $StreamNotifier<List<Reminder>> {
  Stream<List<Reminder>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Reminder>>, List<Reminder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Reminder>>, List<Reminder>>,
              AsyncValue<List<Reminder>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
