import '../../core/utils/result.dart';
import '../entities/user_entity.dart';

/// Contract the data layer must fulfil. The presentation layer only
/// ever depends on this abstraction, never on Firebase directly.
abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;

  UserEntity? get currentUser;

  Future<Result<UserEntity>> signInWithGoogle();

  Future<void> signOut();
}
