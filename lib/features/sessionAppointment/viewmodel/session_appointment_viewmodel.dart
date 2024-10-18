import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/sessionAppointment/model/session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/model/session_coach.dart';
import 'package:alibtisam/features/sessionAppointment/repo/session_appointment.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SessionAppointmentViewmodel extends GetxController {
  final SessionAppointmentRepo sessionAppointmentRepo;

  SessionAppointmentViewmodel(this.sessionAppointmentRepo);

  List<SessionCoach> coaches = [];
  List<SessionAppointment> sessionAppointments = [];
  RxBool loading = false.obs;
  Future createSessionAppointment(
      {required String coachId,
      required String dateAndTime,
      required String description}) async {
    try {
      loading.value = true;
      final res = await sessionAppointmentRepo.createSessionAppointment(
        coachId: coachId,
        dateAndTime: dateAndTime,
        description: description,
      );

      customSnackbar(res['message'], ContentType.success);
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  Future fetchCoachesForGame({required String gameId}) async {
    try {
      loading.value = true;

      final res =
          await sessionAppointmentRepo.fetchCoachesForGame(gameId: gameId);

      coaches = List<SessionCoach>.from(
          res['dropdown'].map((e) => SessionCoach.fromMap(e)));

      update();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  Future getSessionAppointmentByUserId() async {
    try {
      sessionAppointments = [];

      loading.value = true;

      final res = await sessionAppointmentRepo.getSessionAppointmentByUserId();
      if (res != null) {
        sessionAppointments = List<SessionAppointment>.from(
            res['appointments'].map((e) => SessionAppointment.fromMap(e)));
      } else {
        sessionAppointments = [];
      }
      update();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  Future updateSessionAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    try {
      loading.value = true;

      final res = await sessionAppointmentRepo.updateSessionAppointmentStatus(
          appointmentId: appointmentId, status: status);
      if (res != null) {
        Get.back();
        customSnackbar(res['message'], ContentType.success);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }

  Future getSessionAppointmentByCoach(
      {required String date, required String status}) async {
    try {
      loading.value = true;

      final res = await sessionAppointmentRepo.getSessionAppointmentByCoach(
          date: date, status: status);
      if (res != null) {
        return List<SessionAppointment>.from(
            res['appointments'].map((e) => SessionAppointment.fromMap(e)));
      } else {
        return [];
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
      update();
    }
  }

  Future addFeedback(
      {required String role,
      required String appointmentId,
      required String feedback}) async {
    try {
      loading.value = true;

      final res = await sessionAppointmentRepo.addFeedback(
          role: role, appointmentId: appointmentId, feedback: feedback);
      if (res != null) {
        Get.back();
        customSnackbar(res['message'], ContentType.success);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      loading.value = false;
    }
  }
}
