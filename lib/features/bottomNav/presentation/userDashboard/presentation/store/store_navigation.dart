import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/coach/coach_store.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/external/external_store.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/internal/internal_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreNavigation extends StatefulWidget {
  const StoreNavigation({super.key});

  @override
  State<StoreNavigation> createState() => _StoreNavigationState();
}

class _StoreNavigationState extends State<StoreNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return userController.user!.role == "EXTERNAL USER"
        ? ExternalStore()
        : userController.user!.role == "INTERNAL USER"
            ? InternalStore()
            : CoachStore();
  }
}
