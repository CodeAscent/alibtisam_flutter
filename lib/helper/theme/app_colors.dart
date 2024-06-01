import 'package:SNP/helper/theme/app_theme.dart';
import 'package:SNP/helper/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor() =>
    isAppThemeDark() ? Color.fromARGB(255, 250, 61, 155) : Color(0xff7928ca);
Color kAppGreyColor() {
  final themeController = Get.find<ThemeController>();
  return themeController.liveGreyColor.value;
}

dynamic kGradientColor() => LinearGradient(
      colors: [
        Color.fromARGB(255, 250, 61, 155),
        Color.fromARGB(255, 121, 40, 202),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
// Color kAboutColor() => Color.fromARGB(210, 246, 139, 189);

// Color kCollectionColor() => Color.fromARGB(210, 139, 246, 157);

// Color kNewEnrollmentColor() => Color.fromARGB(211, 246, 152, 139);

// Color kLoanApplicationColor() => Color.fromARGB(210, 170, 117, 165);

Color kOverviewColor() => Color.fromARGB(210, 243, 49, 156);

// Color kMakeRequestColor() => Color.fromARGB(210, 139, 246, 212);

// Color kPracticeColor() => Color.fromARGB(210, 246, 139, 166);

Color kTrainingLoadColor() => Color.fromARGB(210, 51, 237, 82);

// Color kStatistics() => Color.fromARGB(210, 246, 139, 166);
Color kReadiness() => Color.fromARGB(210, 143, 62, 243);

// Color kSportsColor() => Color.fromARGB(210, 239, 246, 139);

Color kTestResults() => Color.fromARGB(211, 44, 152, 240);
