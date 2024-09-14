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
    this.loading = false,
    this.color,
  });
  final String label;
  final void Function()? onTap;
  final double? flexibleHeight;
  final bool? loading;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          height: flexibleHeight,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              boxShadow: isAppThemeDark() ? [] : kBoxShadow(),
              color: color == null ? primaryColor() : color,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: loading!
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
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
      ),
    );
  }
}
