import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_In_time.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_history_list.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_out_time.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceTabScreen extends StatefulWidget {
  final String groupId;
  const AttendanceTabScreen({
    super.key,
    required this.groupId,
  });

  @override
  State<AttendanceTabScreen> createState() => _AttendanceTabScreenState();
}

class _AttendanceTabScreenState extends State<AttendanceTabScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController.index == 0) {
          attendanceController.fetchAttendanceForInTime(
              groupId: widget.groupId);
        } else {
          attendanceController.fetchAttendanceForOutTime();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AttendanceHistoryList())!.then((val) {
                  if (_tabController.index == 0) {
                    attendanceController.fetchAttendanceForInTime(
                        groupId: widget.groupId);
                  } else {
                    attendanceController.fetchAttendanceForOutTime();
                  }
                });
              },
              icon: Icon(Icons.history))
        ],
      ),
      body: SafeArea(
        child: CustomTabBar(tabController: _tabController, customTabs: [
          Tab(
            child: Text("IN"),
          ),
          Tab(
            child: Text("OUT"),
          )
        ], tabViewScreens: [
          AttendanceInTime(
            groupId: widget.groupId,
          ),
          AttendanceOutTime()
        ]),
      ),
    );
  }
}
