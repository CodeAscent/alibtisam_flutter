import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserModel? user;
  RxBool loading = false.obs;
  Future fetchUser() async {
    try {
      loading.value = true;
      user = await ApiRequests().getUser();
      loading.value = false;

      update();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }
}
