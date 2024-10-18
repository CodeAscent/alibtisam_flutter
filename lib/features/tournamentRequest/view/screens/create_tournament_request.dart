import 'dart:math';

import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/enrollment/views/pages/view_addmision_form.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/view_members.dart';
import 'package:alibtisam/features/tournamentRequest/viewmodel/tournament_request_viewmodel.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTournamentRequestScreen extends StatefulWidget {
  const CreateTournamentRequestScreen({super.key});

  @override
  State<CreateTournamentRequestScreen> createState() =>
      _CreateTournamentRequestScreenState();
}

class _CreateTournamentRequestScreenState
    extends State<CreateTournamentRequestScreen> {
  List<DateTime?>? selectedDateRange = [];
  List<String> transportMediumEnum = ['BUS', 'TRAIN', 'AIRPLANE'];
  List<String> tournamentTypeEnum = ['INTERNAL', 'EXTERNAL'];
  final name = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final selectedStartDateAndEndDate = TextEditingController();
  final transportMedium = TextEditingController(text: 'BUS');
  final travelDate = TextEditingController();
  final expectedArrivalDate = TextEditingController();
  final expectedDepartureDate = TextEditingController();
  final from = TextEditingController();
  final to = TextEditingController();
  final type = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();
  final selectedTravelDate = TextEditingController();
  final selectedExpectedArrivalDate = TextEditingController();
  final selectedExpectedDepartureDate = TextEditingController();
  final teamName = TextEditingController();
  final requestedAmount = TextEditingController();
  List<String> selectedCoachIds = [];
  List<String> selectedPlayerIds = [];

  final tournamentRequestViewmodel = Get.find<TournamentRequestViewmodel>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text('createRequest'.tr),
          ),
          bottomNavigationBar: SafeArea(
            child: Obx(
              () => CustomContainerButton(
                loading: tournamentRequestViewmodel.loading.value,
                onTap: () async {
                  if (selectedPlayerIds.isEmpty) {
                    return customSnackbar(
                        'Please select players for the tournament'.tr,
                        ContentType.failure);
                  } else if (selectedCoachIds.isEmpty) {
                    return customSnackbar(
                        'Please select coaches for the tournament'.tr,
                        ContentType.failure);
                  } else if (formKey.currentState!.validate()) {
                    await tournamentRequestViewmodel.createTournamentRequest(
                        name: name.text,
                        startDate: startDate.text,
                        endDate: endDate.text,
                        type: type.text,
                        location: location.text,
                        description: description.text,
                        travelDate: selectedTravelDate.text,
                        transportMedium: transportMedium.text,
                        expectedDeparture: selectedExpectedDepartureDate.text,
                        expectedArrival: selectedExpectedArrivalDate.text,
                        from: from.text,
                        to: to.text,
                        teamName: teamName.text,
                        playerIds: selectedPlayerIds,
                        coachIds: selectedCoachIds,
                        requestedAmount: int.parse(requestedAmount.text));
                  }
                },
                flexibleHeight: 50,
                label: 'submit'.tr,
              ),
            ),
          ),
          body: GetBuilder<TournamentRequestViewmodel>(
            initState: (state) {
              tournamentRequestViewmodel.fetchPlayers();
              tournamentRequestViewmodel.fetchCoaches();
              type.text = tournamentTypeEnum[0];
            },
            builder: (controller) {
              return controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Wrap(
                              children: [
                                Row(
                                  children: [
                                    CupertinoRadio(
                                        value: tournamentTypeEnum[0],
                                        groupValue: type.text,
                                        onChanged: (dynamic val) {
                                          setState(() {
                                            type.text = val;
                                          });
                                        }),
                                    Text(
                                      'internalTournament'.tr,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CupertinoRadio(
                                        value: tournamentTypeEnum[1],
                                        groupValue: type.text,
                                        onChanged: (dynamic val) {
                                          setState(() {
                                            type.text = val;
                                          });
                                        }),
                                    Text(
                                      'externalTournament'.tr,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              label: 'name'.tr,
                              controller: name,
                            ),
                            CustomTextField(
                              label: 'location'.tr,
                              controller: location,
                            ),
                            CustomTextField(
                              label: 'Description'.tr,
                              maxLines: 3,
                              controller: description,
                            ),
                            Divider(),
                            CustomTextField(
                              label: 'Team Name'.tr,
                              controller: teamName,
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Select Players'.tr,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('Done'.tr))
                                        ],
                                        content: StatefulBuilder(
                                          builder: (context, setState) =>
                                              Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: SingleChildScrollView(
                                              child: SafeArea(
                                                child: SizedBox(
                                                  height: 450,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SizedBox(height: 30),
                                                        ...List.generate(
                                                            controller
                                                                .players.length,
                                                            (int index) {
                                                          UserModel player =
                                                              controller
                                                                      .players[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (!selectedPlayerIds
                                                                    .contains(
                                                                        player
                                                                            .id)) {
                                                                  selectedPlayerIds
                                                                      .add(player
                                                                          .id!);
                                                                } else {
                                                                  selectedPlayerIds
                                                                      .remove(player
                                                                          .id!);
                                                                }
                                                              });
                                                            },
                                                            child: PlayerCard(
                                                              selected:
                                                                  selectedPlayerIds
                                                                      .contains(
                                                                          player
                                                                              .id),
                                                              name:
                                                                  player.name!,
                                                              image:
                                                                  player.pic!,
                                                              playerId: player
                                                                  .pId
                                                                  .toString(),
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Select Players'.tr)),
                                TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Select Coaches'.tr,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('Done'.tr)),
                                        ],
                                        content: StatefulBuilder(
                                          builder: (context, setState) =>
                                              Container(
                                            color: Colors.white,
                                            child: SingleChildScrollView(
                                              child: SafeArea(
                                                child: SizedBox(
                                                  height: 450,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SizedBox(height: 30),
                                                        SizedBox(height: 10),
                                                        ...List.generate(
                                                            controller
                                                                .coaches.length,
                                                            (int index) {
                                                          UserModel coach =
                                                              controller
                                                                      .coaches[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (!selectedCoachIds
                                                                    .contains(coach
                                                                        .id)) {
                                                                  selectedCoachIds
                                                                      .add(coach
                                                                          .id!);
                                                                } else {
                                                                  selectedCoachIds
                                                                      .remove(coach
                                                                          .id!);
                                                                }
                                                              });
                                                            },
                                                            child: PlayerCard(
                                                              isCoach: true,
                                                              selected:
                                                                  selectedCoachIds
                                                                      .contains(
                                                                          coach
                                                                              .id),
                                                              name: coach.name!,
                                                              image: coach.pic!,
                                                              playerId:
                                                                  ''.toString(),
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Select Coaches'.tr)),
                              ],
                            ),
                            CustomTextField(
                              label: 'Requested Amount'.tr,
                              digitsOnly: true,
                              controller: requestedAmount,
                            ),
                            Divider(),
                            CustomTextField(
                              readOnly: true,
                              controller: selectedStartDateAndEndDate,
                              label: 'Start Date & End Date'.tr,
                              suffix: IconButton(
                                  onPressed: () async {
                                    var results =
                                        await showCalendarDatePicker2Dialog(
                                      context: context,
                                      config:
                                          CalendarDatePicker2WithActionButtonsConfig(
                                        firstDate: DateTime.now(),
                                        calendarType:
                                            CalendarDatePicker2Type.range,
                                      ),
                                      dialogSize: const Size(325, 500),
                                      value: [],
                                      borderRadius: BorderRadius.circular(15),
                                    );
                                    setState(() {
                                      if (results!.length == 2) {
                                        selectedDateRange = results;
                                        startDate.text =
                                            selectedDateRange![0].toString();
                                        endDate.text =
                                            selectedDateRange![1].toString();
                                        selectedStartDateAndEndDate.text =
                                            '${'From'.tr} ${customDateFormat(selectedDateRange![0].toString())} ${'To'.tr} ${customDateFormat(selectedDateRange![1].toString())}';
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.calendar_month)),
                            ),
                            CustomTextField(
                              readOnly: true,
                              controller: transportMedium,
                              label: 'Transport Medium'.tr,
                              suffix: DropdownButton(
                                  underline: SizedBox(),
                                  items: transportMediumEnum
                                      .map((dynamic val) => DropdownMenuItem(
                                          value: val,
                                          child: Text(val.toString())))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      transportMedium.text = val.toString();
                                    });
                                  }),
                            ),
                            CustomTextField(
                              controller: travelDate,
                              label: 'Travel Date'.tr,
                              suffix: IconButton(
                                onPressed: () async {
                                  var results =
                                      await showCalendarDatePicker2Dialog(
                                    context: context,
                                    config:
                                        CalendarDatePicker2WithActionButtonsConfig(
                                      firstDate: DateTime.now(),
                                      calendarType:
                                          CalendarDatePicker2Type.single,
                                    ),
                                    dialogSize: const Size(325, 500),
                                    value: [],
                                    borderRadius: BorderRadius.circular(15),
                                  );

                                  travelDate.text =
                                      customDateFormat(results![0].toString());
                                  selectedTravelDate.text =
                                      results[0].toString();
                                  print(travelDate.text);
                                },
                                icon: Icon(Icons.calendar_month),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: CustomTextField(
                                    readOnly: true,
                                    controller: expectedDepartureDate,
                                    label: 'Expected Departure'.tr,
                                    suffix: IconButton(
                                      onPressed: () async {
                                        var results =
                                            await showCalendarDatePicker2Dialog(
                                          context: context,
                                          config:
                                              CalendarDatePicker2WithActionButtonsConfig(
                                            firstDate: DateTime.now(),
                                            calendarType:
                                                CalendarDatePicker2Type.single,
                                          ),
                                          dialogSize: const Size(325, 500),
                                          value: [],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        );
                                        expectedDepartureDate.text =
                                            customDateFormat(
                                                results![0].toString());
                                        selectedExpectedDepartureDate.text =
                                            results[0].toString();
                                        print(expectedDepartureDate.text);
                                      },
                                      icon: Icon(Icons.calendar_month),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: CustomTextField(
                                    readOnly: true,
                                    controller: expectedArrivalDate,
                                    label: 'Expected Arrival'.tr,
                                    suffix: IconButton(
                                      onPressed: () async {
                                        var results =
                                            await showCalendarDatePicker2Dialog(
                                          context: context,
                                          config:
                                              CalendarDatePicker2WithActionButtonsConfig(
                                            firstDate: DateTime(
                                                DateTime.parse(
                                                        expectedDepartureDate
                                                            .text)
                                                    .year,
                                                DateTime.parse(
                                                        expectedDepartureDate
                                                            .text)
                                                    .month,
                                                DateTime.parse(
                                                        expectedDepartureDate
                                                            .text)
                                                    .day),
                                            calendarType:
                                                CalendarDatePicker2Type.single,
                                          ),
                                          dialogSize: const Size(325, 500),
                                          value: [],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        );
                                        expectedArrivalDate.text =
                                            customDateFormat(
                                                results![0].toString());
                                        selectedExpectedArrivalDate.text =
                                            results[0].toString();
                                        print(expectedArrivalDate.text);
                                      },
                                      icon: Icon(Icons.calendar_month),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: CustomTextField(
                                    controller: from,
                                    label: 'From'.tr,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: CustomTextField(
                                    controller: to,
                                    label: 'To'.tr,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
            },
          )),
    );
  }
}
