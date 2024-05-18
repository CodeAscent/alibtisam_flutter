import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDashboardCard extends StatelessWidget {
  const CustomDashboardCard({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
  });
  final String label;
  final Color color;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
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
