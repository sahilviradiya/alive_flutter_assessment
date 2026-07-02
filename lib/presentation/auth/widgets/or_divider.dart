import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Colors.white.withValues(alpha: 0.35);
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: color)),
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
        Expanded(child: Container(height: 1, color: color)),
      ],
    );
  }
}
