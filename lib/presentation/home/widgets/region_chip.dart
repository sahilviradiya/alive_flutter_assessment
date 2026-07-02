import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';

/// Region filter chip. When selected it expands into a labeled pill;
/// unselected chips collapse into a plain circular flag icon, matching
/// the UI reference.
class RegionChip extends StatelessWidget {
  const RegionChip({
    super.key,
    required this.label,
    required this.flagAsset,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String flagAsset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!selected) {
      return InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: AppColors.chipBorder),
          ),
          padding: const EdgeInsets.all(7),
          child: SvgPicture.asset(flagAsset, fit: BoxFit.contain),
        ),
      );
    }

    return Material(
      color: AppColors.primaryGreen.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primaryGreen),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(flagAsset, width: 18, height: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreenDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
