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
            // White section — non-flex: takes exactly its content height, no more.
            // In a Column with an Expanded sibling, Flutter gives non-flex children
            // unconstrained height, so this shrink-wraps to content size (~380dp).
            // SingleChildScrollView activates only when the keyboard pushes content up.
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
                    _LabeledField(
                      label: AppStrings.emailOrPhoneLabel,
                      hint: AppStrings.emailOrPhoneHint,
                    ),
                    const SizedBox(height: 10),
                    _LabeledField(
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
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
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

            // Green wave section — Expanded: fills ALL remaining height after white content.
            // This eliminates the empty gap that appeared when white was Expanded.
            Expanded(
              child: ClipPath(
                clipper: _TopWaveClipper(),
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
                      const _OrDivider(),
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

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscureText,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.textHint,
              fontSize: 14,
            ),
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            fillColor: const Color(0xFFF2F3F5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1, color: Colors.white.withValues(alpha: 0.35)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            AppStrings.orContinueWith,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Container(height: 1, color: Colors.white.withValues(alpha: 0.35)),
        ),
      ],
    );
  }
}

class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Left edge starts below top to create wave effect
    path.lineTo(0, 48);

    // First curve: rises to create left hill, dips to center valley
    path.cubicTo(
      size.width * 0.18, -8,
      size.width * 0.40, 68,
      size.width * 0.66, 56,
    );
    // Second curve: smoothly rises toward right edge
    path.cubicTo(
      size.width * 0.80, 48,
      size.width * 0.90, 20,
      size.width, 12,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
