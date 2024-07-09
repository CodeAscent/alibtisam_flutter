import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/controller/teams.dart';
import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/model/age_category.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_history_list.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_In_time.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance_tab_screen.dart';
import 'package:SNP/core/common/widgets/custom_empty_icon.dart';
import 'package:SNP/core/common/widgets/custom_gradient_button.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/features/bottomNav/viewModel/age_category_view_model.dart';
import 'package:SNP/features/bottomNav/viewModel/players_by_age_and_stage_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class CoachAttendanceAgeCategoryList extends StatefulWidget {
  const CoachAttendanceAgeCategoryList({super.key});

  @override
  State<CoachAttendanceAgeCategoryList> createState() =>
      _CoachAttendanceAgeCategoryListState();
}

class _CoachAttendanceAgeCategoryListState
    extends State<CoachAttendanceAgeCategoryList> {
  List<AgeCategoryModel> ageCategory = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    ageCategory = await AgeCategoryViewModel().fetchAgeCategory();
    setState(() {});
  }

  final attendanceController = Get.find<AttendanceController>();
  bool schoolVal = true;
  bool academyVal = false;
  String currentStage = 'SCHOOL';
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Attendance".tr),
        actions: [
          TextButton(
              onPressed: () {
                Get.to(() => AttendanceHistoryList());
              },
              child: Text("History"))
        ],
      ),
      body: ageCategory.length == 0
          ? CustomEmptyWidget()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CupertinoCheckbox(
                            value: schoolVal,
                            onChanged: (val) {
                              setState(() {
                                academyVal = false;
                                schoolVal = true;
                                currentStage = 'SCHOOL';
                                attendanceController.clearAttendanceId();
                              });
                            }),
                        Text('School'),
                        SizedBox(width: 20),
                        CupertinoCheckbox(
                            value: academyVal,
                            onChanged: (val) {
                              setState(() {
                                academyVal = !false;
                                schoolVal = !true;
                                currentStage = 'ACADEMY';
                                attendanceController.clearAttendanceId();
                              });
                            }),
                        Text('Academy'),
                      ],
                    ),
                    ...List.generate(ageCategory.length, (int index) {
                      return CustomGradientButton(
                        onTap: () {
                          Logger().w(ageCategory[index].id);

                          Get.to(() => AttendanceTabScreen(
                                ageCategoryId: ageCategory[index].id,
                                stage: currentStage,
                              ));
                        },
                        label: ageCategory[index].name,
                      );
                    })
                  ],
                ),
              ),
            ),
    ));
  }
}
