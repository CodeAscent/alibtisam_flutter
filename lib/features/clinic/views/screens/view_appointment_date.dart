import 'dart:typed_data';

import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/clinic/models/player_appointment_model.dart';
import 'package:alibtisam/features/clinic/viewmodel/clinic_appointment_viewmodel.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAppointmentDetails extends StatefulWidget {
  final String userId;
  const ViewAppointmentDetails({super.key, required this.userId});

  @override
  State<ViewAppointmentDetails> createState() => _ViewAppointmentDetailsState();
}

class _ViewAppointmentDetailsState extends State<ViewAppointmentDetails> {
  final clinicAppointmentViewmodel = Get.find<ClinicAppointmentViewmodel>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          clinicAppointmentViewmodel.getUserAppointment(userId: widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PlayerAppointmentModel data = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Appointment Details'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 250,
                        width: 250,
                        child:
                            HttpWrapper.networkImageRequest(data.userId!.pic!)),
                    Text(data.userId!.name!),
                    if (data.userId!.pId != null)
                      Text(data.userId!.pId!.toString()),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Appointment Status: '),
                        Text(data.status!)
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    Text(data.injuryDescription!),
                    ClipRect(
                        child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: 0.88,
                            child: HttpWrapper.networkImageRequest(
                                data.injuryBodyImage!))),
                    SizedBox(height: 20),
                    Text(
                      'Appointments: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    Column(
                      children: [
                        ...List.generate(data.clinicAppointments!.length,
                            (int index) {
                          final appointment = data.clinicAppointments![index]!;
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (appointment.appointmentDate != null)
                                  Row(
                                    children: [
                                      Text(index ==
                                              data.clinicAppointments!.length -
                                                  1
                                          ? 'Next Appointment '
                                          : ""),
                                      Text(customDateTimeFormat(
                                          appointment.appointmentDate!)),
                                    ],
                                  ),
                                if (appointment.recoveryStatus != null)
                                  Text('Recovery Status: ' +
                                      appointment.recoveryStatus!),
                                if (appointment.feedback != null)
                                  Text('Feedback: ' + appointment.feedback!),
                              ],
                            ),
                          );
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Appointment Details'),
            ),
            body: Center(
              child: Text('No Appointments found'),
            ),
          );
        }
      },
    );
  }
}
