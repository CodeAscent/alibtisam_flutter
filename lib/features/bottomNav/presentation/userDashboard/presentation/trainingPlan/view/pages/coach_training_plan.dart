import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/view_training_plan.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTrainingPlan extends StatefulWidget {
  const CoachTrainingPlan({super.key});

  @override
  State<CoachTrainingPlan> createState() => _CoachTrainingPlanState();
}

class _CoachTrainingPlanState extends State<CoachTrainingPlan> {
  final userController = Get.find<UserController>();
  final groupsController = Get.find<GroupsController>();
  final stageController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupIdController = TextEditingController();
  final planNameController = TextEditingController();
  final trainingDatesController = TextEditingController();
  final trainingTimesController = TextEditingController();
  final trainingDurationController = TextEditingController();
  final additionalNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel user = userController.user!;
    return GetBuilder<GroupsController>(initState: (state) async {
      await groupsController.fetchGroups(
          stage: '', gameId: userController.user!.gameId!.id!);
    }, builder: (GroupsController gcController) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Training Plan'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (contex, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ViewTrainingPlan());
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      'Plan for 12 - 16',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    trailing:
                                        Icon(Icons.navigate_next_outlined),
                                  )),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              final List<DayInWeek> _days = [
                DayInWeek("MON", dayKey: "MONDAY"),
                DayInWeek("TUE", dayKey: "TUESDAY"),
                DayInWeek("WED", dayKey: "WEDNESDAY"),
                DayInWeek("THU", dayKey: "THURSDAY"),
                DayInWeek("FRI", dayKey: "FRIDAY"),
                DayInWeek("SAT", dayKey: "SATURDAY"),
                DayInWeek("SUN", dayKey: "SUNDAY"),
              ];
              showCupertinoDialog(
                  context: context,
                  builder: (context) =>
                      StatefulBuilder(builder: (context, setState) {
                        return Material(
                          color: Colors.transparent,
                          child: CupertinoActionSheet(
                            actions: [
                              SizedBox(
                                height: 70,
                                child: CustomGradientButton(label: 'Submit'),
                              ),
                            ],
                            title: Text('Create Training Plan'),
                            message: Container(
                              height: 500,
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                        controller: planNameController,
                                        label: 'Plan Name',
                                      ),
                                      CustomTextField(
                                          controller: stageController,
                                          label: 'Select Stage',
                                          suffix: DropdownButton(
                                              iconSize: 40,
                                              underline: SizedBox(),
                                              items: user.stage
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((val) =>
                                                      DropdownMenuItem<String>(
                                                        value: val,
                                                        child: Text(
                                                            val.toString()),
                                                      ))
                                                  .toList(),
                                              onChanged: (val) async {
                                                groupNameController.clear();
                                                groupIdController.clear();
                                                stageController.clear();
                                                setState(() {});
                                                await gcController.fetchGroups(
                                                    stage: val.toString(),
                                                    gameId: userController
                                                        .user!.gameId!.id!);
                                                stageController.text =
                                                    val.toString();
                                                setState(() {});
                                              })),
                                      Visibility(
                                        visible: stageController.text != '',
                                        child: CustomTextField(
                                          controller: groupNameController,
                                          label: 'Select Group',
                                          suffix: DropdownButton(
                                              underline: SizedBox(),
                                              iconSize: 40,
                                              items: gcController.groups!
                                                  .map((GroupModel val) =>
                                                      DropdownMenuItem(
                                                          value: val,
                                                          child:
                                                              Text(val.name!)))
                                                  .toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  groupNameController.text =
                                                      val!.name!;
                                                  groupIdController.text =
                                                      val.id!;
                                                });
                                              }),
                                        ),
                                      ),
                                      Divider(),
                                      Text('Schedule'),
                                      SizedBox(height: 10),
                                      SelectWeekDays(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        days: _days,
                                        border: false,
                                        boxDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            gradient: kGradientColor()),
                                        onSelect: (values) {
                                          // <== Callback to handle the selected days
                                          print(values);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      CustomTextField(
                                          readOnly: true,
                                          controller: trainingTimesController,
                                          suffix: IconButton(
                                              onPressed: () async {
                                                TimeOfDay? time =
                                                    await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                DateTime
                                                                    .now()));

                                                if (time != null) {
                                                  trainingTimesController.text =
                                                      time.format(context);

                                                  setState(() {});
                                                }
                                              },
                                              icon: Icon(CupertinoIcons.time)),
                                          label: 'Training times'),
                                      CustomTextField(
                                          controller:
                                              trainingDurationController,
                                          label: 'Duration of each session'),
                                      Divider(),
                                      CustomTextField(
                                          controller: additionalNotesController,
                                          maxLines: 4,
                                          label: 'Additional notes (Optional)'),
                                    ]),
                              ),
                            ),
                            cancelButton: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(CupertinoIcons.xmark)),
                          ),
                        );
                      })).then((val) {
                stageController.clear();
                groupNameController.clear();
                groupIdController.clear();
                planNameController.clear();
                trainingDatesController.clear();
                trainingTimesController.clear();
                trainingDurationController.clear();
                additionalNotesController.clear();
              });
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  gradient: kGradientColor(),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                CupertinoIcons.add,
                size: 45,
                color: Colors.white,
              ),
            ),
          ));
    });
  }
}
