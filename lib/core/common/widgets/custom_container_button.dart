import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    required this.label,
    this.onTap,
    this.flexibleHeight,
  });
  final String label;
  final void Function()? onTap;
  final double? flexibleHeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        height: flexibleHeight,
        decoration: BoxDecoration(
            boxShadow: isAppThemeDark() ? [] : kBoxShadow(),
            color: primaryColor(),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            label.capitalize!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
