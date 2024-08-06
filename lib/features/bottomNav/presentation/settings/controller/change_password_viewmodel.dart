import 'package:alibtisam/features/auth/repo/update_password_repo.dart';
import 'package:alibtisam/features/bottomNav/presentation/settings/repo/change_password.dart';
import 'package:get/get.dart';

class ChangePasswordViewmodel extends GetxController {
  ChangePasswordRepo changePasswordRepo = ChangePasswordRepo();

  RxBool loading = false.obs;
  updatePassword(
      {required String newPassword, required String oldPassword}) async {
    loading.value = true;
    await changePasswordRepo.updatePassword(
        newPassword: newPassword, oldPassword: oldPassword);
    loading.value = false;
    update();
  }
}
