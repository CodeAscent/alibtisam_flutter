import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late UserModel? user;

  Future fetchUser() async {
    try {
      user = await ApiRequests().getUser();

      update();
    } catch (e) {
      customSnackbar(message: e.toString());
    }
  }
}
