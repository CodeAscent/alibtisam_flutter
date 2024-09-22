import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';

class AlrwaadRepo {
  Future joinAlRwaadClub({
    required String govIdExpiration,
    required String govIdNumber,
    required String dateOfBirth,
  }) async {
    try {
      final res = await HttpWrapper.postRequest(base_url + 'al-rwaad/join', {
        "govIdExpiration": govIdExpiration,
        "govIdNumber": govIdNumber,
        "dateOfBirth": dateOfBirth,
      });
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      }
      throw Exception([data['message']]);
    } catch (e) {
      rethrow;
    }
  }

  Future getAllServices() async {
    try {
      final res = await HttpWrapper.getRequest(base_url + 'al-rwaad/all');

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      }
      throw Exception([data['message']]);
    } catch (e) {
      rethrow;
    }
  }

  Future getPlans() async {
    try {
      final res = await HttpWrapper.getRequest(base_url + 'al-rwaad/plans');

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      }
      throw Exception([data['message']]);
    } catch (e) {
      rethrow;
    }
  }

  Future subscribe({required String plan}) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + 'al-rwaad/subscribe', {'plan': plan});

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data;
      }
      throw Exception([data['message']]);
    } catch (e) {
      rethrow;
    }
  }
}
