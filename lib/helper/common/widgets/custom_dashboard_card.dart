import 'package:alibtisam_flutter/helper/theme/controller/theme_controller.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDashboardCard extends StatelessWidget {
  const CustomDashboardCard({
    super.key,
    required this.label,
    required this.icon,
  });
  final String label;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: kGradientColor(),
          boxShadow: isAppThemeDark()
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    blurRadius: 8,
                    offset: Offset(0, 6),
                  ),
                ]),
      height: 140,
      child: Center(
          child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          Spacer(),
          LottieBuilder.asset(
            icon,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ],
      )),
    );
  }
}
