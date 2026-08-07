import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'revolt_remote_repository.dart';

/// Provider for the single instance of [RevoltRemoteRepository].
final revoltRemoteRepositoryProvider = Provider<RevoltRemoteRepository>((ref) {
  final repo = RevoltRemoteRepository();
  ref.onDispose(() => repo.dispose());
  return repo;
});
