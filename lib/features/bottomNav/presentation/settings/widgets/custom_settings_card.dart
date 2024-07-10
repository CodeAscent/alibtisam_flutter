import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSettingsCard extends StatelessWidget {
  const CustomSettingsCard({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kAppGreyColor(), borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1),
      ),
    );
  }
}
