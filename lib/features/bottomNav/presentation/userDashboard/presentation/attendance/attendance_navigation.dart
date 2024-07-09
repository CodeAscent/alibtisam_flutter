import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_age_list.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/internal/internal_attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AttendanceNavigation extends StatefulWidget {
  const AttendanceNavigation({super.key});

  @override
  State<AttendanceNavigation> createState() => _AttendanceNavigationState();
}

class _AttendanceNavigationState extends State<AttendanceNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return userController.user!.role == "INTERNAL USER"
        ? InternalAttendanceTab()
        : CoachAttendanceAgeCategoryList();
  }
}
