import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/coach_training_plan.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/internal_training_plan.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/view_training_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingPlanNavigation extends StatefulWidget {
  const TrainingPlanNavigation({super.key});

  @override
  State<TrainingPlanNavigation> createState() => _TrainingPlanNavigationState();
}

class _TrainingPlanNavigationState extends State<TrainingPlanNavigation> {
  final userController = Get.find<UserController>();
  final groupController = Get.find<GroupsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupsController>(initState: (state) async {
      if (userController.user!.role == 'INTERNAL USER') {
        await groupController.fetchGroupsForPlayer();
        await groupController
            .updateSelectedGroup(groupController.groups!.first);
        groupController.selectedGroupId = groupController.groups!.first.id!;
      }
    }, builder: (controller) {
      return controller.isLoading
          ? Material(child: Center(child: CircularProgressIndicator()))
          : userController.user!.role == "INTERNAL USER"
              ? ViewTrainingPlan()
              : CoachTrainingPlan();
    });
  }
}
