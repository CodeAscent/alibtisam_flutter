import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/view_members.dart';
import 'package:alibtisam/features/statistics/coach/stages_tab_bar.dart';
import 'package:alibtisam/features/trainingPlan/view/pages/view_training_plan.dart';
import 'package:alibtisam/features/trainingPlan/viewModel/training_plan_viewmodel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class CoachTrainingPlan extends StatefulWidget {
  const CoachTrainingPlan({super.key});

  @override
  State<CoachTrainingPlan> createState() => _CoachTrainingPlanState();
}

class _CoachTrainingPlanState extends State<CoachTrainingPlan>
    with TickerProviderStateMixin {
  final userController = Get.find<UserController>();
  final groupsController = Get.find<GroupsController>();
  final stageController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupIdController = TextEditingController();
  final planNameController = TextEditingController();
  final trainingDatesController = TextEditingController();
  final trainingTimeController = TextEditingController();
  final trainingDurationController = TextEditingController();
  final additionalNotesController = TextEditingController();
  final trainingPlanController = Get.find<TrainingPlanViewmodel>();
  List<dynamic> scheduledDays = [];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: userController.user!.stage.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = userController.user!;
    return GetBuilder<GroupsController>(
        initState: (state) async {},
        builder: (GroupsController gcController) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Training Plan'.tr),
              ),
              body: CustomTabBar(tabController: _tabController, customTabs: [
                ...user.stage.map(
                  (e) => Text(e),
                )
              ], tabViewScreens: [
                ...user.stage.map((e) => GroupsByStage(
                      externalOnTap: true,
                      stage: e,
                      onTap: () async {
                        Get.to(() => ViewTrainingPlan())!.then((val) =>
                            groupsController.fetchGroups(
                                stage: e,
                                gameId: userController.user!.gameId!.id!));
                      },
                    )),
              ]),
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
                  final formKey = GlobalKey<FormState>();

                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) {
                        return Form(
                          key: formKey,
                          child: Material(
                            color: Colors.transparent,
                            child: AlertDialog(
                              actions: [
                                SizedBox(
                                  height: 70,
                                  child: Obx(
                                    () => CustomGradientButton(
                                      loading:
                                          trainingPlanController.loading.value,
                                      label: 'submit'.tr,
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          if (scheduledDays.length == 0) {
                                            customSnackbar(
                                                'Please schedule days for the training'
                                                    .tr,
                                                ContentType.warning);
                                          } else {
                                            await trainingPlanController
                                                .addTrainingPlan(
                                                    coachId: user.id!,
                                                    groupId:
                                                        groupIdController.text,
                                                    stage: stageController.text,
                                                    planName:
                                                        planNameController.text,
                                                    trainingDays: scheduledDays,
                                                    trainingTime:
                                                        trainingTimeController
                                                            .text,
                                                    trainingDuration:
                                                        trainingDurationController
                                                            .text,
                                                    additionalNotes:
                                                        additionalNotesController
                                                            .text);
                                            Logger().w([
                                              planNameController.text,
                                              stageController.text,
                                              groupIdController.text,
                                              scheduledDays,
                                              trainingTimeController.text,
                                              trainingDurationController.text,
                                              additionalNotesController.text,
                                            ]);
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                              title: Row(
                                children: [
                                  Text(
                                    'Training Plan'.tr,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(CupertinoIcons.xmark)),
                                ],
                              ),
                              content: Container(
                                height: 500,
                                child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          controller: planNameController,
                                          label: 'Plan Name'.tr,
                                        ),
                                        CustomTextField(
                                            controller: stageController,
                                            label: 'Select Stage'.tr,
                                            suffix: DropdownButton(
                                                iconSize: 40,
                                                underline: SizedBox(),
                                                items: user.stage
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>((val) =>
                                                        DropdownMenuItem<
                                                            String>(
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
                                                  await gcController
                                                      .fetchGroups(
                                                          stage: val.toString(),
                                                          gameId: userController
                                                              .user!
                                                              .gameId!
                                                              .id!);
                                                  stageController.text =
                                                      val.toString();
                                                  setState(() {});
                                                })),
                                        Visibility(
                                          visible: stageController.text != '',
                                          child: CustomTextField(
                                            controller: groupNameController,
                                            label: 'Select Group'.tr,
                                            suffix: DropdownButton(
                                                underline: SizedBox(),
                                                iconSize: 40,
                                                items: gcController.groups!
                                                    .map((GroupModel val) =>
                                                        DropdownMenuItem(
                                                            value: val,
                                                            child: Text(
                                                                val.name!)))
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
                                        Text('Schedule'.tr),
                                        SizedBox(height: 10),
                                        SelectWeekDays(
                                          padding: 0,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                          days: _days,
                                          border: false,
                                          boxDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              gradient: kGradientColor()),
                                          onSelect: (values) {
                                            // <== Callback to handle the selected days
                                            scheduledDays = values;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        CustomTextField(
                                            readOnly: true,
                                            controller: trainingTimeController,
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
                                                    trainingTimeController
                                                            .text =
                                                        time.format(context);

                                                    setState(() {});
                                                  }
                                                },
                                                icon:
                                                    Icon(CupertinoIcons.time)),
                                            label: 'Training time'.tr),
                                        CustomTextField(
                                            controller:
                                                trainingDurationController,
                                            label:
                                                'Duration of each session'.tr),
                                        Divider(),
                                        CustomTextField(
                                            controller:
                                                additionalNotesController,
                                            maxLines: 4,
                                            label: 'Additional notes (Optional)'
                                                .tr),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ).then((val) {
                    stageController.clear();
                    groupNameController.clear();
                    groupIdController.clear();
                    planNameController.clear();
                    trainingDatesController.clear();
                    trainingTimeController.clear();
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
