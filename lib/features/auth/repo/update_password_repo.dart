import 'dart:convert';

import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/auth/view/screens/login.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UpdatePasswordRepo {
  updatePassword(
      {required String username, required String newPassword}) async {
    try {
      final res =
          await HttpWrapper.patchRequest(base_url + 'user/update-password', {
        "userName": username,
        "newPassword": newPassword,
      });

      final data = jsonDecode(res.body);
      Logger().w(data);
      if (res.statusCode == 200) {
        Get.offAll(() => LoginScreen());
      }
      customSnackbar(message: data['message']);
    } catch (e) {
      customSnackbar(message: e.toString());
    }
  }
}
