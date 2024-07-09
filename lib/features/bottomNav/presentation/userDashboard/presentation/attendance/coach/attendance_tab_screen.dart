import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_In_time.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_out_time.dart';
import 'package:SNP/core/common/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceTabScreen extends StatefulWidget {
  final String ageCategoryId;
  final String stage;
  const AttendanceTabScreen(
      {super.key, required this.ageCategoryId, required this.stage});

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
              ageCategoryId: widget.ageCategoryId, stage: widget.stage);
        } else {
          attendanceController.fetchAttendanceForOutTime();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 35,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.navigate_before,
                    size: 35,
                  )),
            ),
            CustomTabBar(tabController: _tabController, customTabs: [
              Tab(
                child: Text("IN"),
              ),
              Tab(
                child: Text("OUT"),
              )
            ], tabViewScreens: [
              AttendanceInTime(
                ageCategoryId: widget.ageCategoryId,
                stage: widget.stage,
              ),
              AttendanceOutTime()
            ]),
          ],
        ),
      ),
    );
  }
}
