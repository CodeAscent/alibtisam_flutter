import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserModel? user;

  Future fetchUser() async {
    try {
      user = await ApiRequests().getUser();

      update();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
}
