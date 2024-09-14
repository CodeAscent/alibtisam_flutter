import 'dart:convert';

import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/enrollment/repo/enrollment_repo.dart';
import 'package:alibtisam/features/enrollment/views/pages/guardian_all_forms.dart';
import 'package:alibtisam/features/enrollment/views/pages/view_addmision_form.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

class EnrollmentViewmodel extends GetxController {
  final EnrollmentRepo enrollmentRepo;

  EnrollmentViewmodel(this.enrollmentRepo);
  var loading = false.obs;
  final userController = Get.find<UserController>();
  Future submitEnrollmentForm({
    required String name,
    required String fatherName,
    required String motherName,
    required String gender,
    required String dateOfBirth,
    required String bloodGroup,
    required String height,
    required String weight,
    required String phoneNumber,
    required String email,
    required String address,
    required String correspondenceAddress,
    required String city,
    required String state,
    required String relationWithApplicant,
    required XFile? idProofFrontPath,
    required XFile? idProofBackPath,
    required XFile? pic,
    required XFile? certificate,
    required String batch,
    required String gameId,
    required String stage,
    required String relationWithPlayer,
    required String playerGovId,
    required String guardianGovId,
    required String guardianGovIdExpiry,
    required String playerGovIdExpiry,
  }) async {
    try {
      loading.value = true;

      final response = await enrollmentRepo.submitEnrollmentForm(
          name: name,
          fatherName: fatherName,
          motherName: motherName,
          gender: gender,
          dateOfBirth: dateOfBirth,
          bloodGroup: bloodGroup,
          height: height,
          weight: weight,
          phoneNumber: phoneNumber,
          email: email,
          address: address,
          correspondenceAddress: correspondenceAddress,
          city: city,
          state: state,
          relationWithApplicant: relationWithApplicant,
          idProofFrontPath: idProofFrontPath,
          idProofBackPath: idProofBackPath,
          pic: pic,
          certificate: certificate,
          batch: batch,
          gameId: gameId,
          stage: stage,
          relationWithPlayer: relationWithPlayer,
          playerGovId: playerGovId,
          guardianGovId: guardianGovId,
          guardianGovIdExpiry: guardianGovIdExpiry,
          playerGovIdExpiry: playerGovIdExpiry);

      final res = await response.stream.bytesToString();
      final data = jsonDecode(res);
      Logger().w(data);

      if (data["success"] == false) {
        customSnackbar(data["error"], ContentType.failure);
      } else {
        customSnackbar(data["message"], ContentType.success);
      }
      if (relationWithApplicant == "me") {
        saveToken(data['token'], '');
        UserModel? user = await ApiRequests().getUser();
        Get.off(() => ViewPlayerByUserModel(
              player: user!,
            ));
      } else {
        if (userController.user!.role != "GUARDIAN") {
          UserModel? user = await ApiRequests().getUser();
          if (user!.role == "GUARDIAN") {
            Get.off(() => GuardianAllForms());
          }
        } else if (userController.user!.role == "GUARDIAN") {
          Get.off(() => GuardianAllForms());
        }
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  Future updateGameByUser({
    required String id,
    required String gameId,
    required String stage,
  }) async {
    try {
      loading.value = true;
      final res = await enrollmentRepo.changeGameAndStage(
          id: id, gameId: gameId, stage: stage);
      customSnackbar(res['message'].toString(), ContentType.success);
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }
}
