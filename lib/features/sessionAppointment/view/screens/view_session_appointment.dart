import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/sessionAppointment/model/session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSessionAppointment extends StatefulWidget {
  final SessionAppointment session;
  const ViewSessionAppointment({super.key, required this.session});

  @override
  State<ViewSessionAppointment> createState() => _ViewSessionAppointmentState();
}

class _ViewSessionAppointmentState extends State<ViewSessionAppointment> {
  final _feedback = TextEditingController();
  final sessionAppointmentViewmodel = Get.find<SessionAppointmentViewmodel>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Appointment'),
      ),
      body: Obx(
        () => sessionAppointmentViewmodel.loading.value
            ? CustomLoader()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment On: \n${customDateTimeFormat(widget.session.dateAndTime!)}',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    if (widget.session.isCompleted!)
                      Text(
                        "COMPLETED",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: Colors.blue),
                      ),
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          widget.session.status!,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: widget.session.status == 'PENDING'
                                ? Colors.orange
                                : widget.session.status == 'REJECTED'
                                    ? Colors.red
                                    : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (widget.session.status == 'PENDING' &&
                        userController.user!.role == 'COACH')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              sessionAppointmentViewmodel
                                  .updateSessionAppointmentStatus(
                                      appointmentId: widget.session.id!,
                                      status: 'REJECTED');
                            },
                            child: Text('REJECT',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              sessionAppointmentViewmodel
                                  .updateSessionAppointmentStatus(
                                      appointmentId: widget.session.id!,
                                      status: 'APPROVED');
                            },
                            child: Text(
                              'ACCEPT',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          )
                        ],
                      ),
                    SizedBox(height: 40),
                    Text(
                      widget.session.description!,
                    ),
                    SizedBox(height: 20),
                    if (widget.session.feedbackByCoach != null)
                      Text(
                        "COACH: " + widget.session.feedbackByCoach!,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    SizedBox(height: 20),
                    if (widget.session.feedbackByUser != null)
                      Text(
                        "USER: " + widget.session.feedbackByUser!,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: widget.session.status! == 'APPROVED' &&
              widget.session.isCompleted! == false
          ? kAddFeedbackButton()
          : null,
    );
  }

  GestureDetector kAddFeedbackButton() {
    return GestureDetector(
      onTap: () {
        if (_feedback.text != '') {
          sessionAppointmentViewmodel.addFeedback(
              role: userController.user!.role!,
              appointmentId: widget.session.id!,
              feedback: _feedback.text);
        }
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: CustomTextField(
                    controller: _feedback, label: 'Write a feedback')),
            SizedBox(width: 10),
            SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                  backgroundColor: primaryColor(),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
