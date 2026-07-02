import '../repositories/auth_repository.dart';

/// Encapsulates the "sign out" business action.
class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.signOut();
}
