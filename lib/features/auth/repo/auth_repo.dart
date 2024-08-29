import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/localStorage/fcm_token.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/services/org_id.dart';

class AuthRepo {
  Future checkUserExist({required String mobile, required String email}) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + 'user/check', {'email': email, 'mobile': mobile});
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future updatePassword(
      {required String username, required String newPassword}) async {
    try {
      final res =
          await HttpWrapper.patchRequest(base_url + 'user/update-password', {
        "userName": username,
        "newPassword": newPassword,
      });
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future sendOTP(String phoneNumber) async {
    try {
      final res = await HttpWrapper.postRequest(
        base_url + 'user/send-otp',
        {"to": phoneNumber},
      );
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future validateOTP({
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
    return res;
  }

  Future validateOTPForgotPassword({
    required String otp,
    required String mobile,
  }) async {
    final res = await HttpWrapper.postRequest(
      base_url + 'user/verify-otp',
      {
        "to": mobile,
        "code": otp,
      },
    );
    return res;
  }

  Future register(
      {required String email,
      required String password,
      required String clubId,
      required String mobile,
      required String name}) async {
    try {
      var body = {
        "role": "EXTERNAL USER",
        "email": email,
        "organizationId": clubId,
        "password": password,
        "mobile": num.parse(mobile),
        "name": name
      };
      final res = await HttpWrapper.postRequest(register_user, body);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future login({required String userName, required String password}) async {
    try {
      final fcmToken = await FcmToken().getFcmToken();
      var body = {
        "userName": userName,
        "password": password,
        "fcmToken": fcmToken,
        "device": "mobile"
      };
      final res = await HttpWrapper.postRequest(login_user, body);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future logout() async {
    try {
      final fcmToken = await FcmToken().getFcmToken();
      var body = {"fcmToken": fcmToken};
      final res = await HttpWrapper.postRequest(logout_user, body);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
