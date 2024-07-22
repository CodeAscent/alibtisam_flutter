import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_single_history.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceHistoryList extends StatefulWidget {
  const AttendanceHistoryList({super.key});

  @override
  State<AttendanceHistoryList> createState() => _AttendanceHistoryListState();
}

class _AttendanceHistoryListState extends State<AttendanceHistoryList> {
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();
  final groupsController = Get.find<GroupsController>();
  @override
  void initState() {
    super.initState();

    attendanceController.fetchAttendanceHistory(
        groupId: groupsController.selectedGroupId);
  }

  final userController = Get.find<UserController>();

  bool schoolVal = true;
  bool academyVal = false;
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
        child: Scaffold(
            appBar: AppBar(
              title: Text("attendanceHistory".tr),
            ),
            body: SingleChildScrollView(
              child: GetBuilder(
                  builder: (AttendanceController attendanceController) {
                return Column(
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
                                  attendanceController.clearAttendanceId();
                                  attendanceController.fetchAttendanceHistory(
                                      groupId:
                                          groupsController.selectedGroupId);
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
                                  attendanceController.clearAttendanceId();
                                  attendanceController.fetchAttendanceHistory(
                                      groupId:
                                          groupsController.selectedGroupId);
                                });
                              }),
                          Text('Academy'),
                        ],
                      ),
                    ...List.generate(
                        attendanceController.attendancesHistory.length,
                        (int index) {
                      return GestureDetector(
                        onTap: () {
                          attendanceController.attendanceId =
                              attendanceController.attendancesHistory[index].id;
                          Get.to(() => AttendanceSingleHistory());
                        },
                        child: CustomContainerButton(
                            flexibleHeight: 100,
                            label:
                                "  ${customDateTimeFormat(attendanceController.attendancesHistory[index].createdAt)}"
                                    .capitalize!),
                      );
                    })
                  ],
                );
              }),
            )));
  }
}
