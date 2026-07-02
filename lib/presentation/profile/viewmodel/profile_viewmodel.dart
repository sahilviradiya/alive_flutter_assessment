import 'package:flutter/foundation.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

/// Exposes the signed-in Google account's details (fetched straight from
/// Firebase Auth via [AuthRepository]) and the sign-out action.
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._authRepository, this._signOutUseCase);

  final AuthRepository _authRepository;
  final SignOutUseCase _signOutUseCase;

  UserEntity? get user => _authRepository.currentUser;

  Future<void> signOut() => _signOutUseCase();
}
