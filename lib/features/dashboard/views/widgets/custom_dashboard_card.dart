import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDashboardCard extends StatefulWidget {
  const CustomDashboardCard({
    super.key,
    required this.label,
    required this.icon,
  });
  final String label;
  final String icon;

  @override
  State<CustomDashboardCard> createState() => _CustomDashboardCardState();
}

class _CustomDashboardCardState extends State<CustomDashboardCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth > 650
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                height: 170,
                width: 250,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                    LottieBuilder.asset(
                      widget.icon,
                      height: 100,
                      width: 100,
                      animate: false,
                      
                      frameRate: FrameRate.max,
                      repeat: false,
                      fit: BoxFit.contain,
                    ),
                  ],
                )),
              )
            : Container(
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
                height: 120,
                child: Center(
                    child: Row(
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Spacer(),
                    LottieBuilder.asset(
                      widget.icon,
                      height: 80,
                      width: 100,
                      animate: true,
                      frameRate: FrameRate.composition,
                      repeat: false,
                      fit: BoxFit.contain,
                    ),
                  ],
                )),
              );
      },
    );
  }
}
