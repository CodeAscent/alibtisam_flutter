import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class ChangePasswordRepo {
  updatePassword(
      {required String newPassword, required String oldPassword}) async {
    try {
      final res = await HttpWrapper.patchRequest(
          base_url + 'user/update-old-password', {
        "newPassword": newPassword,
        "oldPassword": oldPassword,
      });
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        Get.back();
        customSnackbar(message: data['message']);
      } else {
        customSnackbar(message: data['message']);
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }
}
