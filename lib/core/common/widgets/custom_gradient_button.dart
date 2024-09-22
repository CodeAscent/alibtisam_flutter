import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.disabled = false,
    this.loading = false,
  });
  final String label;
  final void Function()? onTap;
  final bool? disabled;
  final IconData? icon;
  final bool? loading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled!
          ? () {
              print('disabled');
            }
          : onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
            boxShadow: isAppThemeDark() ? [] : kBoxShadow(),
            color: disabled! ? kAppGreyColor() : null,
            gradient: !disabled! ? kGradientColor() : null,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: loading!
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  label!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: disabled! ? Colors.grey : Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
        ),
      ),
    );
  }
}
