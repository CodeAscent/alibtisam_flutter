import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/appointment_list_by_user.dart';
import 'package:alibtisam/features/sessionAppointment/view/screens/session_booked_message.dart';
import 'package:alibtisam/features/sessionAppointment/viewmodel/session_appointment_viewmodel.dart';
import 'package:alibtisam/features/sports/viewmodel/sports_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CreateSessionAppointment extends StatefulWidget {
  const CreateSessionAppointment({super.key});

  @override
  State<CreateSessionAppointment> createState() =>
      _CreateSessionAppointmentState();
}

class _CreateSessionAppointmentState extends State<CreateSessionAppointment> {
  final sessionAppointmentViewmodel = Get.find<SessionAppointmentViewmodel>();
  final _coach = TextEditingController();
  final _coachId = TextEditingController();
  final _dateAndTime = TextEditingController();
  final _formattedDateAndTime = TextEditingController();
  final _description = TextEditingController();
  final _selectedGame = TextEditingController();
  final _selectedGameId = TextEditingController();
  final userController = Get.find<UserController>();
  final sportsViewmodel = Get.find<SportsViewmodel>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionAppointmentViewmodel>(
      initState: (state) async {
        sportsViewmodel.getClubSports().then((val) => setState(() {}));
        if (userController.user!.role == 'INTERNAL USER') {
          sessionAppointmentViewmodel.fetchCoachesForGame(
              gameId: userController.user!.gameId!.id!);
        }
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Session Appointment'),
          ),
          body: controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      if (userController.user!.role != 'INTERNAL USER')
                        CustomTextField(
                          controller: _selectedGame,
                          readOnly: true,
                          label: 'Select Game',
                          suffix: DropdownButton(
                            underline: Icon(
                              Icons.arrow_downward,
                              size: 30,
                            ),
                            icon: Text(''),
                            items: sportsViewmodel.clubSports
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: 60,
                                            height: 60,
                                            child:
                                                HttpWrapper.networkImageRequest(
                                                    e.icon!)),
                                        Text(e.name.toString()),
                                      ],
                                    )))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGame.text = value!.name.toString();
                                _selectedGameId.text = value.id.toString();
                                _coach.clear();
                                _coachId.clear();
                                sessionAppointmentViewmodel.fetchCoachesForGame(
                                    gameId: _selectedGameId.text);
                              });
                            },
                          ),
                        ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _coach,
                        readOnly: true,
                        label: 'Select Coach',
                        suffix: DropdownButton(
                          underline: Icon(
                            Icons.arrow_downward,
                            size: 30,
                          ),
                          icon: Text(''),
                          items: controller.coaches
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: SizedBox(
                                      width: 180,
                                      height: 60,
                                      child: Text(e.name.toString()))))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _coach.text = value!.name.toString();
                              _coachId.text = value.id.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _formattedDateAndTime,
                        label: 'Date and time',
                        readOnly: true,
                        suffix: IconButton(
                            onPressed: () async {
                              final dateAndTime = await showOmniDateTimePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 1));

                              if (dateAndTime != null) {
                                _dateAndTime.text = dateAndTime.toString();
                                _formattedDateAndTime.text =
                                    customDateTimeFormat(_dateAndTime.text);
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.calendar,
                            )),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _description,
                        label: 'Description(Optional)',
                        maxLines: 3,
                      ),
                      Spacer(),
                      CustomGradientButton(
                        label: 'Submit',
                        onTap: () {
                          Logger().w({
                            "coachId": _coachId.text,
                            "dateAndTime": _dateAndTime.text,
                            "description": _description.text
                          });
                          sessionAppointmentViewmodel.createSessionAppointment(
                            coachId: _coachId.text,
                            dateAndTime: _dateAndTime.text,
                            description: _description.text,
                          );
                          Get.to(() => SessionBookedMessage());
                        },
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
