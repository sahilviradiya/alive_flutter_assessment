import '../../core/utils/result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Encapsulates the "sign in with Google" business action so the
/// view model doesn't talk to the repository directly.
class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserEntity>> call() => _repository.signInWithGoogle();
}
