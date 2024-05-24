import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/coach_attendance.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/attendance/internal/internal_attendance.dart';
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
        ? InternalAttendance()
        : CoachAttendance();
  }
}
