import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/requestPortal/coach/coach_request_portal.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/requestPortal/internal/internal_request_portal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPortalNavigation extends StatefulWidget {
  const RequestPortalNavigation({super.key});

  @override
  State<RequestPortalNavigation> createState() =>
      _RequestPortalNavigationState();
}

class _RequestPortalNavigationState extends State<RequestPortalNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return userController.user!.role == "INTERNAL USER"
        ? InternalRequestPortal()
        : CoachRequestPortal();
  }
}
