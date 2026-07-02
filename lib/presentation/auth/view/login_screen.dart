import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/social_auth_button.dart';
import '../viewmodel/login_viewmodel.dart';
import '../widgets/login_form_field.dart';
import '../widgets/login_wave_clipper.dart';
import '../widgets/or_divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  void _showGoogleOnlyNotice(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text(AppStrings.googleOnlyNotice)));
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final viewModel = context.read<LoginViewModel>();
    final success = await viewModel.signInWithGoogle();
    if (!context.mounted) return;

    if (success) {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    } else if (viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: AppLogo(size: 54)),
                    const SizedBox(height: 10),
                    const Text(
                      AppStrings.welcomeBack,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      AppStrings.loginSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const LoginFormField(
                      label: AppStrings.emailOrPhoneLabel,
                      hint: AppStrings.emailOrPhoneHint,
                    ),
                    const SizedBox(height: 10),
                    LoginFormField(
                      label: AppStrings.passwordLabel,
                      hint: AppStrings.passwordHint,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textHint,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _showGoogleOnlyNotice(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          AppStrings.forgotPassword,
                          style: TextStyle(
                            color: AppColors.primaryGreenDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GradientButton(
                      label: AppStrings.login,
                      onPressed: () => _showGoogleOnlyNotice(context),
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ClipPath(
                clipper: LoginWaveClipper(),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 44, 24, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const OrDivider(),
                      const SizedBox(height: 16),
                      Consumer<LoginViewModel>(
                        builder: (context, viewModel, _) {
                          return SocialAuthButton(
                            label: AppStrings.continueWithGoogle,
                            iconAsset: AppAssets.icGoogle,
                            isLoading: viewModel.isLoading,
                            onPressed: () => _handleGoogleSignIn(context),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      SocialAuthButton(
                        label: AppStrings.continueWithFacebook,
                        iconAsset: AppAssets.icFacebook,
                        onPressed: () => _showGoogleOnlyNotice(context),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _showGoogleOnlyNotice(context),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            children: [
                              TextSpan(text: AppStrings.dontHaveAccount),
                              TextSpan(
                                text: AppStrings.signUp,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
