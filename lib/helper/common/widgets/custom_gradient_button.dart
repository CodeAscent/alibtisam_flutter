import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.label,
    this.onTap,
  });
  final String label;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              gradient: kGradientColor(),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2),
            ),
          ),
        ),
      ),
    );
  }
}
