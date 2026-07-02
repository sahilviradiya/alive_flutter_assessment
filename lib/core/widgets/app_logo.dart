import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// The "Alive" app logo: a rounded green-gradient squircle with the
/// wordmark and a video camera badge, precisely matching the UI reference.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    // Proportional dimensions based on the target UI
    final borderRadius = size * 0.28;
    final fontSize = size * 0.26;
    final badgeWidth = size * 0.55;
    final badgeHeight = size * 0.28;
    final iconSize = badgeHeight * 0.7;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Alive',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          SizedBox(height: size * 0.04),
          Container(
            width: badgeWidth,
            height: badgeHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(badgeHeight / 2),
            ),
            child: Center(
              child: Icon(
                Icons.videocam_rounded,
                size: iconSize,
                color: AppColors.primaryGreenDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
