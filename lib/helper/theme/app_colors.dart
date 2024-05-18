import 'package:alibtisam_flutter/features/commons/home/presentation/settings/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor() => kStatistics();
Color kAppGreyColor() {
  final themeController = Get.find<ThemeController>();
  return themeController.liveGreyColor.value;
}

Color kAboutColor() => Color.fromARGB(210, 246, 139, 189);

Color kCollectionColor() => Color.fromARGB(210, 139, 246, 157);

Color kNewEnrollmentColor() => Color.fromARGB(211, 246, 152, 139);

Color kLoanApplicationColor() => Color.fromARGB(210, 170, 117, 165);

Color kSessionAppointmentColor() => Color.fromARGB(210, 246, 139, 198);

Color kMakeRequestColor() => Color.fromARGB(210, 139, 246, 212);

Color kPracticeColor() => Color.fromARGB(210, 246, 139, 166);

Color kAttendanceColor() => Color.fromARGB(210, 139, 246, 157);

Color kStatistics() => Color.fromARGB(210, 246, 139, 166);
// Color kStatistics() => Color.fromARGB(210, 187, 139, 246);

Color kSportsColor() => Color.fromARGB(210, 239, 246, 139);

Color kEventsColor() => Color.fromARGB(212, 139, 198, 246);
