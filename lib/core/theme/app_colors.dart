import 'package:alibtisam/core/theme/app_theme.dart';
import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor() =>
//fa3d9b
    isAppThemeDark() ? kAlibtisamPrimary() : kAlibtisamSecondary();
Color kAppGreyColor() {
  final themeController = Get.find<ThemeController>();
  return themeController.liveGreyColor.value;
}

dynamic kGradientColor() => LinearGradient(
      colors: [
        kAlibtisamPrimary(),
        kAlibtisamSecondary(),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
List<BoxShadow> kBoxShadow() => [
      BoxShadow(
        color: Colors.grey.shade400,
        blurRadius: 10,
        spreadRadius: 5,
        offset: Offset(0, 6),
      ),
    ];

Color kAlibtisamPrimary() => Color(0xFFFA3D9B);

Color kAlibtisamSecondary() => Color(0xFF7928CA);

Color kSnpPrimary() => Color(0xff780206);

Color kSnpSecondary() => Color(0xff061161);
