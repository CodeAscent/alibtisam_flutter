import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CustomGradientListTile extends StatelessWidget {
    final String label;
    final String subtitle;
  const CustomGradientListTile({
    super.key, required this.label, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 18),
        ),
        GradientText(
          subtitle,
          colors: kColorsArray(),
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
