import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';

/// The "Alive" app logo: a rounded green-gradient squircle with the
/// wordmark and a video camera badge, precisely matching the UI reference.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.appLogo,
      width: size,
      height: size,
    );
  }
}
