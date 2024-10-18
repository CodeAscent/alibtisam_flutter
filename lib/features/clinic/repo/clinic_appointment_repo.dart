import 'dart:convert';
import 'dart:io';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class ClinicAppointmentRepo {
  Future createClinicAppointment(
      {required String userId,
      required String userAppointmentType,
      required String injuryDescription,
      required File injuryBodyImage}) async {
    try {
      List<http.MultipartFile> files = [];
      files.add(
          await http.MultipartFile.fromPath('image', injuryBodyImage.path));
      final res = await HttpWrapper.multipartRequest(
          base_url + 'clinic/add-appointment', files,
          fields: {
            "userId": userId,
            "injuryDescription": injuryDescription,
            "userAppointmentType": userAppointmentType
          });
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future getUserAppointment({required String userId}) async {
    try {
      final res =
          await HttpWrapper.getRequest(base_url + 'clinic/all?userId=$userId');
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data['appointments'][0];
      } else {
        throw data['message'];
      }
    } catch (e) {
      // rethrow;
    }
  }

  Future makePayment({required String id, required num paymentAmount}) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + 'clinic/make-payment/$id',
          {"paymentAmount": paymentAmount});
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
}
