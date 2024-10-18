import 'dart:convert';
import 'dart:io';

import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/clinic/models/player_appointment_model.dart';
import 'package:alibtisam/features/clinic/repo/clinic_appointment_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ClinicAppointmentViewmodel extends GetxController {
  final ClinicAppointmentRepo clinicAppointmentRepo;
  ClinicAppointmentViewmodel({required this.clinicAppointmentRepo});

  RxBool isLoading = false.obs;

  addClinicAppointment(
      {required String userId,
      required String userAppointmentType,
      required String injuryDescription,
      required File injuryBodyImage}) async {
    try {
      isLoading.value = true;
      final response = await clinicAppointmentRepo.createClinicAppointment(
          userId: userId,
          injuryDescription: injuryDescription,
          injuryBodyImage: injuryBodyImage,
          userAppointmentType: userAppointmentType);
      final res = await response.stream.bytesToString();
      final data = jsonDecode(res);

      if (data['success'] == true) {
        Get.back();
        customSnackbar(data['message'], ContentType.success);
      } else {
        throw data['message'];
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future getUserAppointment({required String userId}) async {
    try {
      final res =
          await clinicAppointmentRepo.getUserAppointment(userId: userId);
      Logger().w(res);
      if (res != null) {
        return PlayerAppointmentModel.fromMap(res);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  makePayment({required String id, required num paymentAmount}) async {
    try {
      final res = await clinicAppointmentRepo.makePayment(
          id: id, paymentAmount: paymentAmount);
      customSnackbar(res['message'], ContentType.success);
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
}
