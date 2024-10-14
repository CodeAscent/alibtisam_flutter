import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/sessionAppointment/model/session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/view_session_appointment.dart';
import 'package:alibtisam/features/sessionAppointment/view/widgets/appointment_card.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AppointmentListForCoach extends StatefulWidget {
  const AppointmentListForCoach({super.key});

  @override
  State<AppointmentListForCoach> createState() =>
      _AppointmentListForCoachState();
}

class _AppointmentListForCoachState extends State<AppointmentListForCoach> {
  final sessionAppointmentViewmodel = Get.find<SessionAppointmentViewmodel>();
  List<SessionAppointment> sessions = [];
  Future<List<SessionAppointment>> fetchSessions() async {
    sessions = await sessionAppointmentViewmodel.getSessionAppointmentByCoach(
        date: _date.text, status: _statusFilter.text);
    return sessions;
  }

  refresh() {
    fetchSessions();
    setState(() {});
  }

  List statusArray = ['ALL', 'PENDING', 'APPROVED', 'REJECTED'];
  final _date = TextEditingController();
  final _statusFilter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchSessions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Appoinments'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2500));
                              if (date != null) {
                                _date.text = date.toString();
                                setState(() {});
                              }
                            },
                            child: Text('Date Filter')),
                        Spacer(),
                        PopupMenuButton<int>(
                          onSelected: (value) {
                            if (value == 0) {
                              _statusFilter.text = '';
                            } else {
                              _statusFilter.text = statusArray[value];
                            }
                            refresh();
                          },
                          surfaceTintColor: Colors.transparent,
                          offset: const Offset(0, -500),
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                                value: 0,
                                child: Text(
                                  'ALL',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue),
                                )),
                            PopupMenuItem<int>(
                                value: 1,
                                child: Text(
                                  'PENDING',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange),
                                )),
                            PopupMenuItem<int>(
                                value: 2,
                                child: Text(
                                  'APPROVED',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green),
                                )),
                            PopupMenuItem<int>(
                                value: 3,
                                child: Text(
                                  'REJECTED',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                )),
                          ],
                          child: Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    if (_date.text != '')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                                'Showing results for : ${customDateMMMFormat(_date.text)}'),
                            Spacer(),
                            if (_date.text != '')
                              TextButton(
                                  onPressed: () {
                                    _date.clear();
                                    refresh();
                                  },
                                  child: Text('Clear')),
                          ],
                        ),
                      ),
                    ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        return GestureDetector(
                          onTap: () {
                            refresh();
                            Get.to(() =>
                                    ViewSessionAppointment(session: session))!
                                .then((val) => refresh());
                          },
                          child: AppointmentCard(
                              requestedBy: session.userId!.name!,
                              date: session.dateAndTime!,
                              status: session.status!,
                              description: session.description!),
                        );
                      },
                    ),
                  ],
                ),
              ));
        }
        if (snapshot.hasError) {
          Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        }
        return Scaffold(
          body: CustomLoader(),
        );
      },
    );
  }
}
