import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/model/attendance_history.dart';
import 'package:alibtisam/core/common/controller/custom_loading_controller.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
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
                appBar: AppBar(
                  title: Text('Attendance'),
                ),
                body: SafeArea(
                  child:
                      CustomTabBar(tabController: _tabController, customTabs: [
                    Tab(
                      text: "Attendance",
                    ),
                    Tab(
                      text: "Statistics",
                    )
                  ], tabViewScreens: [
                    InternalAttendance(),
                    InternalAttendanceStatistics(),
                  ]),
                )));
      },
    );
  }
}

class InternalAttendanceStatistics extends StatefulWidget {
  const InternalAttendanceStatistics({super.key});

  @override
  State<InternalAttendanceStatistics> createState() =>
      _InternalAttendanceStatisticsState();
}

class _InternalAttendanceStatisticsState
    extends State<InternalAttendanceStatistics> {
  final ValueNotifier<double> _valueNotifierMonth = ValueNotifier(0);
  final ValueNotifier<double> _valueNotifierYear = ValueNotifier(0);

  final attendanceController = Get.find<AttendanceController>();
  final customLoadingController = Get.find<CustomLoadingController>();
  String selectedYear = '';
  String selectedMonth = '';
  @override
  void initState() {
    super.initState();
    attendanceController.fetchPlayerAttendanceStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AttendanceController attendanceController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Total Present Days: ${attendanceController.attendanceStatistics!.presentDays}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Monthly Stats  ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    DropdownButton(
                        value: attendanceController
                            .attendanceStatistics!.monthlyStats.keys.first
                            .toString(),
                        items: attendanceController
                            .attendanceStatistics!.monthlyStats.keys
                            .map((val) =>
                                DropdownMenuItem(value: val, child: Text(val)))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedMonth = val!;
                          });
                        }),
                  ],
                ),
                DashedCircularProgressBar(
                  valueNotifier: _valueNotifierMonth,
                  progress: selectedMonth == ''
                      ? attendanceController
                          .attendanceStatistics!
                          .monthlyStats[attendanceController
                              .attendanceStatistics!.monthlyStats.keys.first]
                          .toDouble()
                      : attendanceController
                          .attendanceStatistics!.monthlyStats[selectedMonth]
                          .toDouble(),
                  maxProgress: 365,
                  corners: StrokeCap.round,
                  foregroundColor: primaryColor(),
                  foregroundStrokeWidth: 26,
                  animation: true,
                  backgroundColor: kAppGreyColor(),
                  width: 200,
                  height: 200,
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: _valueNotifierMonth,
                      builder: (_, double value, __) => Text(
                        '${value.toInt()}\nDays',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Yearly Stats  ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    DropdownButton(
                        value: attendanceController
                            .attendanceStatistics!.yearlyStats.keys.first
                            .toString(),
                        items: attendanceController
                            .attendanceStatistics!.yearlyStats.keys
                            .map((val) =>
                                DropdownMenuItem(value: val, child: Text(val)))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedYear = val!;
                          });
                        }),
                  ],
                ),
                DashedCircularProgressBar(
                  backgroundColor: kAppGreyColor(),
                  valueNotifier: _valueNotifierYear,
                  progress: selectedYear == ''
                      ? attendanceController
                          .attendanceStatistics!
                          .yearlyStats[attendanceController
                              .attendanceStatistics!.yearlyStats.keys.first]
                          .toDouble()
                      : attendanceController
                          .attendanceStatistics!.yearlyStats[selectedYear]
                          .toDouble(),
                  maxProgress: 365,
                  corners: StrokeCap.round,
                  foregroundColor: primaryColor(),
                  foregroundStrokeWidth: 26,
                  animation: true,
                  width: 200,
                  height: 200,
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: _valueNotifierYear,
                      builder: (_, double value, __) => Text(
                        '${value.toInt()}\nDays',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        attendanceController.fetchPlayerAttendanceStatistics();
      },
      builder: (AttendanceController attendanceController) {
        return CustomLoader(
            child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  ...List.generate(
                      attendanceController.attendancesHistory.length,
                      (int index) {
                    AttendanceHistoryModel attendanceHistory =
                        attendanceController.attendancesHistory[index];
                    return CustomContainerButton(
                        flexibleHeight: null,
                        label:
                            '\n Marked ${customDateTimeFormat(attendanceHistory.createdAt)} \n In-Time: ${customTimeFormat(attendanceHistory.players[0].inTime)} \n Out-Time: ${attendanceHistory.players[0].outTime == '' ? '??' : customTimeFormat(attendanceHistory.players[0].outTime)}, \n Remarks: ${attendanceHistory.players[0].remark}\n');
                  })
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
