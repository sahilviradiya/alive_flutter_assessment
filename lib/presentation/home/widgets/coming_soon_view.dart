import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// Placeholder body for tabs outside this assignment's scope (Party,
/// Chats) so switching tabs always shows real, distinct content
/// instead of leaving the previous tab's UI on screen.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: AppColors.textHint),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          const Text(AppStrings.comingSoon, style: TextStyle(color: AppColors.textHint)),
        ],
      ),
    );
  }
}
