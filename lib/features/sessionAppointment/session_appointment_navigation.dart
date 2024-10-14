import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/appointment_list_by_user.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/create_session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/appointment_list_for_coach.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class SessionAppointmentNavigation extends StatefulWidget {
  const SessionAppointmentNavigation({super.key});

  @override
  State<SessionAppointmentNavigation> createState() =>
      _SessionAppointmentNavigationState();
}

class _SessionAppointmentNavigationState
    extends State<SessionAppointmentNavigation> {
  final userController = Get.find<UserController>();
  final sessionAppointmentViewmodel = Get.find<SessionAppointmentViewmodel>();

  Future<Widget> navigate() async {
    Logger().w(sessionAppointmentViewmodel.sessionAppointments);

    if (userController.user!.role != "COACH") {
      await sessionAppointmentViewmodel.getSessionAppointmentByUserId();
      if (sessionAppointmentViewmodel.sessionAppointments.isNotEmpty) {
        return AppointmentListByUser();
      }
      return CreateSessionAppointment();
    }
    return AppointmentListForCoach();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: navigate(), // Call navigate function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else if (snapshot.hasError) {
            // Optional: You can handle errors here
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        }
        // While the future is being resolved, show a loader
        return Material(color: Colors.white, child: CustomLoader());
      },
    );
  }
}
