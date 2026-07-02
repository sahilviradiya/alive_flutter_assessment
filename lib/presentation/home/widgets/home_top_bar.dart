import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_logo.dart';

/// Top app bar: logo, notification bell with badge, and profile/wallet button.
/// Precisely matched to the UI reference with correct colors and shadows.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, this.notificationCount = 0});

  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          const AppLogo(size: 38),
          const Spacer(),
          _IconCircle(
            icon: AppAssets.icBell,
            badgeCount: notificationCount,
            backgroundColor: Colors.white,
            iconColor: AppColors.textSecondary,
            hasShadow: true,
            onTap: () {},
          ),
          const SizedBox(width: 12),
          _IconCircle(
            icon: AppAssets.icWallet,
            backgroundColor: AppColors.primaryGreenDark,
            iconColor: Colors.white,
            isGradient: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    required this.icon,
    this.badgeCount = 0,
    required this.backgroundColor,
    required this.iconColor,
    this.hasShadow = false,
    this.isGradient = false,
    required this.onTap,
  });

  final String icon;
  final int badgeCount;
  final Color backgroundColor;
  final Color iconColor;
  final bool hasShadow;
  final bool isGradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGradient ? null : backgroundColor,
              gradient: isGradient
                  ? const LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              boxShadow: hasShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          if (badgeCount > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '$badgeCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
