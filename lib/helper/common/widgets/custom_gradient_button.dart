import 'package:SNP/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.disabled = false,
  });
  final String label;
  final void Function()? onTap;
  final bool? disabled;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled!
          ? () {
              print('disabled');
            }
          : onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: 100,
        decoration: BoxDecoration(
            color: disabled! ? kAppGreyColor() : null,
            gradient: !disabled! ? kGradientColor() : null,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: disabled! ? Colors.grey : Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
