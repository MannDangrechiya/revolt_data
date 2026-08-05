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

String _$remindersHash() => r'77ec47ebeeddbe81e831f20f45c3aea10f40678f';

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

@ProviderFor(reminderById)
final reminderByIdProvider = ReminderByIdFamily._();

final class ReminderByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Reminder?>,
          Reminder?,
          FutureOr<Reminder?>
        >
    with $FutureModifier<Reminder?>, $FutureProvider<Reminder?> {
  ReminderByIdProvider._({
    required ReminderByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'reminderByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reminderByIdHash();

  @override
  String toString() {
    return r'reminderByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Reminder?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Reminder?> create(Ref ref) {
    final argument = this.argument as String;
    return reminderById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReminderByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reminderByIdHash() => r'0333c710a98660b5359bb73d6b6fbcaf1d816d01';

final class ReminderByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Reminder?>, String> {
  ReminderByIdFamily._()
    : super(
        retry: null,
        name: r'reminderByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReminderByIdProvider call(String id) =>
      ReminderByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'reminderByIdProvider';
}
