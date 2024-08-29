import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/views/pages/external_enrollment_form.dart';
import 'package:alibtisam/features/enrollment/views/pages/guardian_all_forms.dart';
import 'package:alibtisam/features/enrollment/views/pages/view_addmision_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class EnrollmentNavigation extends StatefulWidget {
  const EnrollmentNavigation({super.key});

  @override
  State<EnrollmentNavigation> createState() => _EnrollmentNavigationState();
}

class _EnrollmentNavigationState extends State<EnrollmentNavigation> {
  final userController = Get.find<UserController>();

  Widget navigate() {
    Logger().w("----------> ${userController.user!.request}");
    if (userController.user!.role == "EXTERNAL USER" &&
        userController.user!.guardianId == null) {
      Logger().w("----------> 1");

      if (userController.user!.request != null) {
        print(userController.user!.request);
        Logger().w("----------> 2");

        return ViewPlayerByUserModel(player: userController.user!);
      } else {
        Logger().w("----------> 3");

        return ExternalEnrollmentForm();
      }
    } else if (userController.user!.role == "EXTERNAL USER" &&
        userController.user!.guardianId != null) {
      Logger().w("----------> 4");

      return ViewPlayerByUserModel(player: userController.user!);
    }
    Logger().w("----------> 5");

    return GuardianAllForms();
  }

  @override
  Widget build(BuildContext context) {
    return navigate();

    // ? ViewAddmisionForm(player: userController.user!)
    // : userController.user!.role == "EXTERNAL USER" &&
    //         userController.user!.guardianId == ''
    //     ? ExternalEnrollmentForm()
    //     : userController.user!.role == "EXTERNAL USER" &&
    //             userController.user!.guardianId == '' &&
    //             userController.user!.requests != {}
    //         ? ViewAddmisionForm(player: userController.user!)
    //         : GuardianAllForms();
  }
}
