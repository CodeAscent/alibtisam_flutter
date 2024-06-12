import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_single_history.dart';
import 'package:SNP/helper/common/widgets/custom_container_button.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/utils/custom_date_formatter.dart';
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
  @override
  void initState() {
    super.initState();
    attendanceController.fetchAttendanceHistoryListByCoach();
  }

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
                    ...List.generate(
                        attendanceController.attendancesHistory.length,
                        (int index) {
                      Map<String, dynamic> team =
                          attendanceController.attendancesHistory[index].teamId;
                      return GestureDetector(
                        onTap: () {
                          attendanceController.attendanceId =
                              attendanceController.attendancesHistory[index].id;
                          Get.to(() => AttendanceSingleHistory());
                        },
                        child: CustomContainerButton(
                            label:
                                "${team['name']} \n ${customDateTimeFormat(attendanceController.attendancesHistory[index].createdAt)}"),
                      );
                    })
                  ],
                );
              }),
            )));
  }
}
