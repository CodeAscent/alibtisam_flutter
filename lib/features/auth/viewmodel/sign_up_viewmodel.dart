import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/auth/repo/firebase_otp_validation.dart';
import 'package:alibtisam/features/auth/repo/sign_up_repo.dart';
import 'package:alibtisam/features/auth/view/screens/otp_validation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class SignUpViewmodel {
  RxBool loading = false.obs;
  SignUpRepo signUpRepo = SignUpRepo();

  checkUserExist(
      {required String email,
      required String mobile,
      required String password,
      required String name}) async {
    try {
      loading.value = true;
      final res = await signUpRepo.checkUserExist(mobile: mobile, email: email);
      loading.value = false;
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        FirebaseOtpValidation.verifyPhoneNumber(mobile);
        Get.to(() => OtpValidation(email: email, phone: mobile, name: name, password: password,));
      } else {
        customSnackbar(message: data['message']);
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }
}
