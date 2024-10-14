// ignore_for_file: deprecated_member_use

import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam/features/sessionAppointment/model/session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/create_session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/view_session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/view/widgets/appointment_card.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentListByUser extends StatefulWidget {
  const AppointmentListByUser({super.key});

  @override
  State<AppointmentListByUser> createState() => _AppointmentListByUserState();
}

class _AppointmentListByUserState extends State<AppointmentListByUser> {
  final sessionAppointmentViewmodel = Get.find<SessionAppointmentViewmodel>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => BottomNav());
        return true;
      },
      child: GetBuilder<SessionAppointmentViewmodel>(builder: (controller) {
        return Scaffold(
            bottomNavigationBar: Container(
              child: CustomGradientButton(
                label: 'Create New Appointment',
                onTap: () {
                  Get.to(() => CreateSessionAppointment());
                },
              ),
            ),
            appBar: AppBar(
              title: Text('My Appointments'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.sessionAppointments.length,
                    itemBuilder: (context, index) {
                      SessionAppointment sessionAppointment =
                          controller.sessionAppointments[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ViewSessionAppointment(
                                  session: sessionAppointment))!
                              .then((val) =>
                                  controller.getSessionAppointmentByUserId());
                        },
                        child: AppointmentCard(
                            requestedBy: sessionAppointment.userId!.name!,
                            date: sessionAppointment.dateAndTime!,
                            status: sessionAppointment.status!,
                            description: sessionAppointment.description!),
                      );
                    },
                  ),
                  SizedBox(height: 150),
                ],
              ),
            ));
      }),
    );
  }
}
