import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// White pill-shaped button with a leading SVG icon, used for
/// "Continue with ..." social auth actions.
class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        child: InkWell(
          borderRadius: BorderRadius.circular(27),
          onTap: isLoading ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                )
              else
                SvgPicture.asset(iconAsset, width: 22, height: 22),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B1B1B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
