import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/alRwaadClub/models/alRwaad_plans.dart';
import 'package:alibtisam/features/alRwaadClub/models/alRwaad_service.dart';
import 'package:alibtisam/features/alRwaadClub/repo/alrwaad_repo.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

import '../../enrollment/models/user.dart';

class AlrwaadViewmodel extends GetxController {
  final AlrwaadRepo alrwaadRepo;
  AlrwaadViewmodel(this.alrwaadRepo);
  RxBool loading = false.obs;
  final userController = Get.find<UserController>();

  Future joinAlRwaadClub({
    required String govIdExpiration,
    required String govIdNumber,
    required String dateOfBirth,
  }) async {
    try {
      final res = await alrwaadRepo.joinAlRwaadClub(
          govIdExpiration: govIdExpiration,
          govIdNumber: govIdNumber,
          dateOfBirth: dateOfBirth);

      customSnackbar(res['message'].toString(), ContentType.success);
      saveToken(res['token'], res['alRwaadUser']['_id']);

      await userController.fetchUser();
      Get.back();
      await userController.fetchUser();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future getAllServices() async {
    try {
      final res = await alrwaadRepo.getAllServices();
      //   customSnackbar(res['message'].toString(), ContentType.success);

      return List<AlRwaadService>.from(
          res['alRwaadServices'].map((e) => AlRwaadService.fromMap(e)));
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future getPlans() async {
    try {
      final res = await alrwaadRepo.getPlans();
      //   customSnackbar(res['message'].toString(), ContentType.success);

      return List<AlrwaadPlan>.from(
          res['plans'].map((e) => AlrwaadPlan.fromMap(e)));
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  Future subscribe({required String plan}) async {
    try {
      final res = await alrwaadRepo.subscribe(plan: plan);
      await userController.fetchUser();
      Get.back();

      customSnackbar(res['message'], ContentType.success);
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
}
