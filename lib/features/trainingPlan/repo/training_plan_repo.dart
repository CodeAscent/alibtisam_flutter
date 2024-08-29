import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';

class TrainingPlanRepo {
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
      final res =
          await HttpWrapper.postRequest(base_url + 'training-plan/add', {
        "coachId": coachId,
        "groupId": groupId,
        "stage": stage,
        "planName": planName,
        "trainingDays": trainingDays,
        "trainingTime": trainingTime,
        "trainingDuration": trainingDuration,
        "additionalNotes": additionalNotes,
      });
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException(data['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  getTrainingPlan({required String groupId}) async {
    try {
      final res =
          await HttpWrapper.getRequest(base_url + 'training-plan/get/$groupId');
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      } else {
        throw ServerException(data['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
