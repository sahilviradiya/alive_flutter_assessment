import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

/// Concrete [AuthRepository] backed by [AuthRemoteDataSource], translating
/// Firebase exceptions into the app's [Result] type.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Stream<UserEntity?> get authStateChanges => _remoteDataSource.authStateChanges;

  @override
  UserEntity? get currentUser => _remoteDataSource.currentUser;

  @override
  Future<Result<UserEntity>> signInWithGoogle() async {
    try {
      final user = await _remoteDataSource.signInWithGoogle();
      return Result.success(user);
    } on fb.FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Google sign-in failed.');
    } catch (_) {
      return Result.failure('Something went wrong. Please try again.');
    }
  }

  @override
  Future<void> signOut() => _remoteDataSource.signOut();
}
