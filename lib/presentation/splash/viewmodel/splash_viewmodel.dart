import 'package:flutter/foundation.dart';

import '../../../domain/repositories/auth_repository.dart';

/// Decides where the splash screen should navigate once its animation
/// has finished, based on the current auth state.
class SplashViewModel extends ChangeNotifier {
  SplashViewModel(this._authRepository);

  final AuthRepository _authRepository;

  bool get isLoggedIn => _authRepository.currentUser != null;
}
