import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:logger/logger.dart';

class SessionAppointmentRepo {
  Future createSessionAppointment(
      {required String coachId,
      required String dateAndTime,
      required String description}) async {
    try {
      final res = await HttpWrapper.postRequest(
        base_url + 'request/create-session-appointment',
        {
          "coachId": coachId,
          "dateAndTime": dateAndTime,
          "description": description,
        },
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future fetchCoachesForGame({required String gameId}) async {
    try {
      final res = await HttpWrapper.getRequest(
          base_url + 'coach/player-category?gameId=$gameId');
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getSessionAppointmentByUserId() async {
    try {
      final res = await HttpWrapper.getRequest(
          base_url + 'request/get-appointment-by-user');
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getSessionAppointmentByCoach(
      {required String date, required String status}) async {
    try {
      final res = await HttpWrapper.getRequest(base_url +
          'request/get-appointment-by-coach?date=$date&status=$status');
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateSessionAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + 'request/update-appointment-status/$appointmentId',
          {"status": status});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addFeedback(
      {required String role,
      required String appointmentId,
      required String feedback}) async {
    try {
      final body = role == 'COACH'
          ? {"feedbackByCoach": feedback}
          : {"feedbackByUser": feedback};
      final res = await HttpWrapper.postRequest(
          base_url + 'request/add-feedback/$appointmentId', body);
      final data = jsonDecode(res.body);
      Logger().w(data);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
