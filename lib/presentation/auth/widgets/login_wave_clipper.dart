import 'package:flutter/material.dart';

class LoginWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 48);

    path.cubicTo(
      size.width * 0.18, -8,
      size.width * 0.40, 68,
      size.width * 0.66, 56,
    );

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
