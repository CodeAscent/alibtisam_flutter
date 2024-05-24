import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/external/external_enrollment_form.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/guardian/guardian_all_forms.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EnrollmentNavigation extends StatefulWidget {
  const EnrollmentNavigation({super.key});

  @override
  State<EnrollmentNavigation> createState() => _EnrollmentNavigationState();
}

class _EnrollmentNavigationState extends State<EnrollmentNavigation> {
  final userController = Get.find<UserController>();

  Widget navigate() {
    if (userController.user!.role == "EXTERNAL USER" &&
        userController.user!.guardianId == '') {
      if (userController.user!.request.isNotEmpty) {
        print(userController.user!.request);
        return ViewAddmisionForm(player: userController.user!);
      } else {
        return ExternalEnrollmentForm();
      }
    } else if (userController.user!.role == "EXTERNAL USER" &&
        userController.user!.guardianId != '') {
      return ViewAddmisionForm(player: userController.user!);
    }
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
