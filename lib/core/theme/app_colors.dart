import 'package:SNP/core/theme/app_theme.dart';
import 'package:SNP/core/theme/controller/theme_controller.dart';
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
        color: Colors.grey.shade700,
        blurRadius: 8,
        offset: Offset(0, 6),
      ),
    ];

Color kAlibtisamPrimary() => Color.fromARGB(255, 250, 61, 155);

Color kAlibtisamSecondary() => Color.fromARGB(255, 121, 40, 202);

Color kSnpPrimary() => Color(0xff780206);

Color kSnpSecondary() => Color(0xff061161);
