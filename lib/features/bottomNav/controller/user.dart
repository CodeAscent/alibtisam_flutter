import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late UserModel user;

  void setUserData(UserModel data) {
    try {
      user = data;
      update();
    } catch (e) {
      customSnackbar(message: e.toString());
    }
  }

  UserModel? getUserData() {
    try {
      return user;
    } catch (e) {
      customSnackbar(message: e.toString());
    }
    return null;
  }
}
