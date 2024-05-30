import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    required this.label,
    this.onTap,
  });
  final String label;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: 100,
        decoration: BoxDecoration(
            color: primaryColor(), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
