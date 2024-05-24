import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/sports/coach/coach_sports.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/sports/external/external_sports.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/sports/internal/internal_sports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportsNavigation extends StatefulWidget {
  const SportsNavigation({super.key});

  @override
  State<SportsNavigation> createState() => _SportsNavigationState();
}

class _SportsNavigationState extends State<SportsNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return userController.user!.role == "EXTERNAL USER"
        ? ExternalSports()
        : userController.user!.role == "INTERNAL USER"
            ? InternalSports()
            : CoachSports();
  }
}
