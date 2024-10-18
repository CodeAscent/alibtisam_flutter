import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/clinic/viewmodel/clinic_appointment_viewmodel.dart';
import 'package:alibtisam/features/clinic/views/screens/coach_clinic_tabs.dart';
import 'package:alibtisam/features/clinic/views/screens/injured_external_user.dart';
import 'package:alibtisam/features/clinic/views/screens/injured_player_details.dart';
import 'package:alibtisam/features/clinic/views/screens/view_appointment_date.dart';
import 'package:alibtisam/features/clinic/views/screens/view_external_appointment_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicNavigation extends StatefulWidget {
  const ClinicNavigation({super.key});

  @override
  State<ClinicNavigation> createState() => _ClinicNavigationState();
}

class _ClinicNavigationState extends State<ClinicNavigation> {
  final userController = Get.find<UserController>();
  final clinicAppointmentViewmodel = Get.find<ClinicAppointmentViewmodel>();
  Future<Widget> navigate() async {
    if (userController.user!.role == 'COACH') {
      return CoachClinicTabs();
    }
    if (userController.user!.role == 'INTERNAL USER') {
      return ViewAppointmentDetails(
        userId: userController.user!.id!,
      );
    } else {
      final res = await clinicAppointmentViewmodel.getUserAppointment(
          userId: userController.user!.id!);
      if (res == null) {
        return InjuredExternalUserForm();
      }
      return ViewExternalAppointmentDetails(
        userId: userController.user!.id!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: navigate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
