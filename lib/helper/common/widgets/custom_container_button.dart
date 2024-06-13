import 'package:SNP/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    required this.label,
    this.onTap,
    this.flexibleHeight,
    this.child,
  });
  final String label;
  final void Function()? onTap;
  final bool? flexibleHeight;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: flexibleHeight ?? false ? null : 100,
        decoration: BoxDecoration(
            color: primaryColor(), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: child != null
              ? child
              : Text(
                  label,
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
