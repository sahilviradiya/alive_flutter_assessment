import 'package:flutter/foundation.dart';

import '../../../core/utils/result.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/sign_in_with_google_usecase.dart';

enum LoginStatus { idle, loading, success, error }

/// Holds the login screen's state and coordinates the Google sign-in
/// use case, keeping Firebase details out of the view.
class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._signInWithGoogleUseCase);

  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  LoginStatus _status = LoginStatus.idle;
  String? _errorMessage;
  UserEntity? _user;

  LoginStatus get status => _status;
  String? get errorMessage => _errorMessage;
  UserEntity? get user => _user;
  bool get isLoading => _status == LoginStatus.loading;

  Future<bool> signInWithGoogle() async {
    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _signInWithGoogleUseCase();
    switch (result) {
      case Success<UserEntity>(data: final user):
        _user = user;
        _status = LoginStatus.success;
        notifyListeners();
        return true;
      case Failure<UserEntity>(message: final message):
        _errorMessage = message;
        _status = LoginStatus.error;
        notifyListeners();
        return false;
    }
  }
}
