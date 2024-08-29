import 'dart:convert';
import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/services/org_id.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/auth/repo/auth_repo.dart';
import 'package:alibtisam/features/auth/view/screens/login.dart';
import 'package:alibtisam/features/auth/view/screens/otp_validation.dart';
import 'package:alibtisam/features/auth/view/screens/update_password.dart';
import 'package:alibtisam/features/bottomNav/bottom_nav.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

class AuthViewmodel extends GetxController {
  AuthViewmodel(this.authRepo);

  final AuthRepo authRepo;
  var isLoading = false.obs;

  Future checkUserExist(
      {required String email,
      required String mobile,
      required String password,
      required String name}) async {
    try {
      isLoading.value = true;
      final res = await authRepo.checkUserExist(mobile: mobile, email: email);

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        authRepo.sendOTP(mobile);
        Get.to(() => OtpValidation(
              email: email,
              phone: mobile,
              name: name,
              password: password,
            ));
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future updatePassword(
      {required String username, required String newPassword}) async {
    try {
      isLoading.value = true;
      final res = await authRepo.updatePassword(
          username: username, newPassword: newPassword);
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        Get.offAll(() => LoginScreen());
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future sendOTP(String phoneNumber) async {
    try {
      isLoading.value = true;
      final res = await authRepo.sendOTP(phoneNumber);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future register(
      {required String email,
      required String password,
      required String clubId,
      required String mobile,
      required String name}) async {
    try {
      isLoading.value = true;
      final res = await authRepo.register(
          email: email,
          password: password,
          clubId: clubId,
          mobile: mobile,
          name: name);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Get.offAll(() => LoginScreen());
        customSnackbar(data["message"], ContentType.success);
      } else {
        customSnackbar(data["message"], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future validateOTP({
    required String otp,
    required String email,
    required String password,
    required String mobile,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      final res = await authRepo.validateOTP(
          otp: otp,
          email: email,
          password: password,
          mobile: mobile,
          name: name);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        await register(
            email: email,
            password: password,
            clubId: orgId,
            mobile: mobile,
            name: name);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future validateOTPForgotPassword({
    required String otp,
    required String mobile,
  }) async {
    try {
      isLoading.value = true;
      final res =
          await authRepo.validateOTPForgotPassword(otp: otp, mobile: mobile);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Get.to(() => UpdatePasswordScreen(
              username: mobile,
            ));
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future login({required String userName, required String password}) async {
    try {
      isLoading.value = true;
      final res = await authRepo.login(userName: userName, password: password);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        saveToken(
          data['token'],
          data['user']['_id'],
        );
        Get.to(() => BottomNav());
        customSnackbar(data["message"], ContentType.success);
      } else {
        customSnackbar(data["message"], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }

  Future logout() async {
    try {
      isLoading.value = true;
      final res = await authRepo.logout();
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false;
    }
  }
}
