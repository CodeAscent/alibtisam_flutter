import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/external/external_enrollment_form.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/guardian/guardian_all_forms.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/internal/internal_enrollment_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EnrollmentNavigation extends StatefulWidget {
  const EnrollmentNavigation({super.key});

  @override
  State<EnrollmentNavigation> createState() => _EnrollmentNavigationState();
}

class _EnrollmentNavigationState extends State<EnrollmentNavigation> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return userController.user.role == "EXTERNAL USER" &&
            userController.user.guardianId == ''
        ? ExternalEnrollmentForm()
        : userController.user.role == "INTERNAL USER"
            ? InternalEnrollmentForm()
            : GuardianAllForms();
  }
}
