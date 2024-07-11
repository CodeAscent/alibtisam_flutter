import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_history_list.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance_tab_screen.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/features/bottomNav/viewModel/age_category_view_model.dart';
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
    if (userController.user!.stage != 'SCHOOL-AND-ACADEMY') {
      attendanceController.currentStage = userController.user!.stage;
    } else {
      attendanceController.currentStage = 'SCHOOL';
    }
  }

  fetchData() async {
    ageCategory = await AgeCategoryViewModel().fetchAgeCategory();
    setState(() {});
  }

  final attendanceController = Get.find<AttendanceController>();
  final userController = Get.find<UserController>();
  bool schoolVal = true;
  bool academyVal = false;
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
                    if (userController.user!.stage == 'SCHOOL-AND-ACADEMY')
                      Row(
                        children: [
                          CupertinoCheckbox(
                              value: schoolVal,
                              onChanged: (val) {
                                setState(() {
                                  academyVal = false;
                                  schoolVal = true;
                                  attendanceController.currentStage = 'SCHOOL';
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
                                  attendanceController.currentStage = 'ACADEMY';
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
                          attendanceController.clearAttendanceId();
                          Get.to(() => AttendanceTabScreen(
                                ageCategoryId: ageCategory[index].id,
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
