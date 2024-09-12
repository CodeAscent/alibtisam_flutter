import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/trainingPlan/view/widgets/custom_gradient_listtile.dart';
import 'package:alibtisam/features/trainingPlan/viewModel/training_plan_viewmodel.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ViewTrainingPlan extends StatefulWidget {
  const ViewTrainingPlan({super.key});

  @override
  State<ViewTrainingPlan> createState() => _ViewTrainingPlanState();
}

class _ViewTrainingPlanState extends State<ViewTrainingPlan> {
  List<DayInWeek> _days = [
    DayInWeek("MON", dayKey: "MONDAY"),
    DayInWeek("TUE", dayKey: "TUESDAY"),
    DayInWeek("WED", dayKey: "WEDNESDAY"),
    DayInWeek("THU", dayKey: "THURSDAY"),
    DayInWeek("FRI", dayKey: "FRIDAY"),
    DayInWeek("SAT", dayKey: "SATURDAY"),
    DayInWeek("SUN", dayKey: "SUNDAY"),
  ];
  List<DayInWeek> tempDays = [];
  @override
  Widget build(BuildContext context) {
    final trainingPlanController = Get.find<TrainingPlanViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Plan'.tr),
      ),
      body: GetBuilder<TrainingPlanViewmodel>(
        init: TrainingPlanViewmodel(),
        initState: (state) async {
            
          await trainingPlanController.getTrainingPlan();
          tempDays = [
            DayInWeek(
              "MON",
              dayKey: "MONDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('MONDAY'),
            ),
            DayInWeek(
              "TUE",
              dayKey: "TUESDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('TUESDAY'),
            ),
            DayInWeek(
              "WED",
              dayKey: "WEDNESDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('WEDNESDAY'),
            ),
            DayInWeek(
              "THU",
              dayKey: "THURSDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('THURSDAY'),
            ),
            DayInWeek(
              "FRI",
              dayKey: "FRIDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('FRIDAY'),
            ),
            DayInWeek(
              "SAT",
              dayKey: "SATURDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('SATURDAY'),
            ),
            DayInWeek(
              "SUN",
              dayKey: "SUNDAY",
              isSelected: trainingPlanController.trainingPlan!.trainingDays!
                  .contains('SUNDAY'),
            ),
          ];
          _days = tempDays;
        },
        builder: (TrainingPlanViewmodel controller) {
          return controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.trainingPlan == null
                  ? Center(
                      child: Text('No Training plan found for this group'.tr),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomGradientListTile(
                              label: 'Plan Name'.tr,
                              subtitle: controller.trainingPlan!.planName!,
                            ),
                            CustomGradientListTile(
                              label: 'Training Time'.tr,
                              subtitle: controller.trainingPlan!.trainingTime!,
                            ),
                            CustomGradientListTile(
                              label: 'Training Duration'.tr,
                              subtitle:
                                  controller.trainingPlan!.trainingDuration!,
                            ),
                            CustomGradientListTile(
                              label: 'Stage'.tr,
                              subtitle: controller.trainingPlan!.stage!,
                            ),
                            CustomGradientListTile(
                              label: 'Additional Notes'.tr,
                              subtitle:
                                  controller.trainingPlan!.additionalNotes!,
                            ),
                            Text(
                              'Schedule'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            SelectWeekDays(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              days: _days,
                              border: true,
                              boxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  gradient: kGradientColor()),
                              onSelect: (values) {
                                setState(() {
                                  _days = tempDays;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
