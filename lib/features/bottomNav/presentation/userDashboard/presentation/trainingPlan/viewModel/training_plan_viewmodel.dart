import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/models/training_plan.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/repo/training_plan_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TrainingPlanViewmodel extends GetxController {
  RxBool loading = false.obs;
  final trainingPlanRepo = TrainingPlanRepo();
  final groupsController = Get.find<GroupsController>();
  TrainingPlan? trainingPlan;
  addTrainingPlan({
    required String coachId,
    required String groupId,
    required String stage,
    required String planName,
    required List<dynamic> trainingDays,
    required String trainingTime,
    required String trainingDuration,
    required String additionalNotes,
  }) async {
    try {
      loading.value = true;

      final res = await trainingPlanRepo.addTrainingPlan(
          coachId: coachId,
          groupId: groupId,
          stage: stage,
          planName: planName,
          trainingDays: trainingDays,
          trainingTime: trainingTime,
          trainingDuration: trainingDuration,
          additionalNotes: additionalNotes);
      Get.back();

      update();
      if (res != null) {
        customSnackbar(message: res['message']);
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    } finally {
      loading.value = false;
      update();
    }
  }

  getTrainingPlan() async {
    try {
      trainingPlan = null;
      loading.value = true;

      final res = await trainingPlanRepo.getTrainingPlan(
          groupId: groupsController.selectedGroupId);
      Logger().w(res);
      if (res != null) {
        trainingPlan = TrainingPlan.fromMap(res['data']);
        return trainingPlan;
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    } finally {
      loading.value = false;
      update();
    }
  }
}
