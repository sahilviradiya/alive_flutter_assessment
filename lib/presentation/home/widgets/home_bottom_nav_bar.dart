import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key, required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    // Bottom padding for system navigation (buttons or home indicator)
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double barHeight = 66.0; 
    const double protrusionHeight = 20.0;
    final double totalHeight = barHeight + protrusionHeight + bottomPadding;

    return Container(
      height: totalHeight,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Background Gradient Layer (Extends to screen bottom) ─────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: protrusionHeight,
            child: ClipPath(
              clipper: _MockupNotchClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),

          // ── Nav Items Layer (Safe above system buttons) ──────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomPadding + 6, // Raised slightly for better visual balance
            height: barHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavItem(
                  icon: AppAssets.icHome,
                  label: AppStrings.navHome,
                  selected: selectedIndex == 0,
                  onTap: () => onTap(0),
                ),
                _NavItem(
                  icon: AppAssets.icParty,
                  label: AppStrings.navParty,
                  selected: selectedIndex == 1,
                  onTap: () => onTap(1),
                ),
                // Center Gap for Go Live
                const Expanded(flex: 3, child: SizedBox()),
                _NavItem(
                  icon: AppAssets.icChats,
                  label: AppStrings.navChats,
                  selected: selectedIndex == 3,
                  onTap: () => onTap(3),
                ),
                _NavItem(
                  icon: AppAssets.icProfile,
                  label: AppStrings.navProfile,
                  selected: selectedIndex == 4,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),

          // ── Go Live Button & Label (The Scoop Centerpiece) ────────────
          Positioned(
            top: 2, // Slight offset from stack top
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.icGoLive,
                          width: 32,
                          height: 32,
                          // Use the specific broadcast icon style from mockup
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryGreenDark,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.navGoLive,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : Colors.white.withValues(alpha: 0.7);
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 25,
              height: 25,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A clipper that creates a smooth, continuous "scoop" notch that exactly
/// matches the premium UI reference provided.
class _MockupNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    const double cornerRadius = 28.0;
    const double notchWidth = 92.0;
    const double notchDepth = 38.0;

    // Start from left side, with rounded corner
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);
    
    // Line to the start of the notch scoop
    path.lineTo((w - notchWidth) / 2, 0);
    
    // Smooth Bezier Notch: Perfectly continuous curve
    path.cubicTo(
      (w - notchWidth * 0.6) / 2, 0,
      (w - notchWidth * 0.6) / 2, notchDepth,
      w / 2, notchDepth,
    );
    path.cubicTo(
      (w + notchWidth * 0.6) / 2, notchDepth,
      (w + notchWidth * 0.6) / 2, 0,
      (w + notchWidth) / 2, 0,
    );
    
    // Line to right corner
    path.lineTo(w - cornerRadius, 0);
    path.quadraticBezierTo(w, 0, w, cornerRadius);
    
    // Complete the box
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
