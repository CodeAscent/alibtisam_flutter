import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/model/attendance_history.dart';
import 'package:SNP/helper/common/widgets/custom_container_button.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/common/widgets/custom_tab_bar.dart';
import 'package:SNP/helper/utils/custom_date_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternalAttendanceTab extends StatefulWidget {
  const InternalAttendanceTab({super.key});

  @override
  State<InternalAttendanceTab> createState() => _InternalAttendanceTabState();
}

class _InternalAttendanceTabState extends State<InternalAttendanceTab>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;
  final attendanceController = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AttendanceController attendanceController) {
        return CustomLoader(
            child: Scaffold(
                body: SafeArea(
          child: CustomTabBar(tabController: _tabController, customTabs: [
            Tab(
              text: "Attendance",
            ),
            Tab(
              text: "Analysis",
            )
          ], tabViewScreens: [
            InternalAttendance(),
            InternalAttendanceAnalysis(),
          ]),
        )));
      },
    );
  }
}

class InternalAttendanceAnalysis extends StatelessWidget {
  const InternalAttendanceAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class InternalAttendance extends StatelessWidget {
  const InternalAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.find<AttendanceController>();

    return GetBuilder(
      initState: (state) {
        attendanceController.fetchAttendanceHistoryByPlayer();
      },
      builder: (AttendanceController attendanceController) {
        return CustomLoader(
            child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ...List.generate(attendanceController.attendancesHistory.length,
                    (int index) {
                  AttendanceHistoryModel attendanceHistory =
                      attendanceController.attendancesHistory[index];
                  return Card(
                    child: CustomContainerButton(
                        flexibleHeight: true,
                        label:
                            '\n Marked ${customDateTimeFormat(attendanceHistory.createdAt)} \n In-Time: ${customTimeFormat(attendanceHistory.players[0].inTime)} \n Out-Time: ${customTimeFormat(attendanceHistory.players[0].outTime)}, \n Remarks: ${attendanceHistory.players[0].remark}\n'),
                  );
                })
              ],
            ),
          ),
        ));
      },
    );
  }
}
