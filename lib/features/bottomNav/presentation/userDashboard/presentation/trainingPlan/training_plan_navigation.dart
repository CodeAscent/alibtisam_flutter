import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/coach_training_plan.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/internal_training_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingPlanNavigation extends StatefulWidget {
  const TrainingPlanNavigation({super.key});

  @override
  State<TrainingPlanNavigation> createState() => _TrainingPlanNavigationState();
}

class _TrainingPlanNavigationState extends State<TrainingPlanNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return userController.user!.role == "INTERNAL USER"
        ? InternalTrainingPlan()
        : CoachTrainingPlan();
  }
}
