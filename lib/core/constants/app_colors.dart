import 'package:flutter/material.dart';

/// Centralized color palette matching the Alive app UI reference.
class AppColors {
  AppColors._();

  static const Color primaryGreenLight = Color(0xFFB6F500);
  static const Color primaryGreenDark = Color(0xFF3DBE29);
  static const Color primaryGreen = Color(0xFF4CAF50);

  static const List<Color> primaryGradient = [
    primaryGreenLight,
    primaryGreenDark,
  ];

  static const Color scaffoldBackground = Color(0xFFF7F8FA);
  static const Color darkBackground = Color(0xFF121212);

  static const Color textPrimary = Color(0xFF1B1B1B);
  static const Color textSecondary = Color(0xFF7B7B7B);
  static const Color textHint = Color(0xFFB0B0B0);

  static const Color inputFill = Color(0xFFF2F3F5);
  static const Color divider = Color(0xFFE3E5E8);

  static const Color chipUnselected = Color(0xFFFFFFFF);
  static const Color chipBorder = Color(0xFFE3E5E8);

  static const Color followYellow = Color(0xFFFFC72C);
  static const Color overlayDark = Color(0x99000000);

  static const Color error = Color(0xFFE53935);
}
