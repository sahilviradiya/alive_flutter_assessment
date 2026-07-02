// Basic smoke test verifying the Login screen renders its Google
// sign-in CTA without needing a live Firebase connection.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:alive_flutter_assessment/core/constants/app_strings.dart';
import 'package:alive_flutter_assessment/core/utils/result.dart';
import 'package:alive_flutter_assessment/domain/entities/user_entity.dart';
import 'package:alive_flutter_assessment/domain/repositories/auth_repository.dart';
import 'package:alive_flutter_assessment/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:alive_flutter_assessment/presentation/auth/view/login_screen.dart';
import 'package:alive_flutter_assessment/presentation/auth/viewmodel/login_viewmodel.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Stream<UserEntity?> get authStateChanges => const Stream.empty();

  @override
  UserEntity? get currentUser => null;

  @override
  Future<Result<UserEntity>> signInWithGoogle() async =>
      const Result.success(UserEntity(uid: 'uid', name: 'Test User', email: 'test@example.com'));

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets('LoginScreen shows the Continue with Google button', (WidgetTester tester) async {
    final authRepository = _FakeAuthRepository();

    await tester.pumpWidget(
      ChangeNotifierProvider<LoginViewModel>(
        create: (_) => LoginViewModel(SignInWithGoogleUseCase(authRepository)),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.text(AppStrings.continueWithGoogle), findsOneWidget);
    expect(find.text(AppStrings.welcomeBack), findsOneWidget);
  });
}
