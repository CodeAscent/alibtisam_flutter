import 'dart:convert';

import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:alibtisam/network/api_urls.dart';
import 'package:alibtisam/network/http_wrapper.dart';
import 'package:alibtisam/network/org_id.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:logger/logger.dart';

class OtpValidationRepo {
  static void sendOTP(String phoneNumber) async {
    await HttpWrapper.postRequest(
      base_url + 'user/send-otp',
      {"to": phoneNumber},
    );
  }

  static Future<void> validateOTP({
    required String otp,
    required String email,
    required String password,
    required String mobile,
    required String name,
  }) async {
    final res = await HttpWrapper.postRequest(
      base_url + 'user/verify-otp',
      {
        "to": mobile,
        "code": otp,
      },
    );
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      await ApiRequests().register(
          email: email,
          password: password,
          clubId: orgId,
          mobile: mobile,
          name: name);
    } else {
      customSnackbar(message: data['message']);
    }

    // User is signed in, you can access user information here
  }
}
