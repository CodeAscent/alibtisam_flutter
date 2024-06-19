import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/model/attendance.dart';
import 'package:SNP/features/bottomNav/model/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_In_time.dart';
import 'package:SNP/core/common/widgets/custom_empty_icon.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/theme/app_colors.dart';
import 'package:SNP/core/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceSingleHistory extends StatefulWidget {
  const AttendanceSingleHistory({super.key});

  @override
  State<AttendanceSingleHistory> createState() =>
      _AttendanceSingleHistoryState();
}

class _AttendanceSingleHistoryState extends State<AttendanceSingleHistory> {
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();
  List<PlayersAttendance> playersAttendance = [];
  @override
  void initState() {
    super.initState();
    attendanceController.fetchSingleAttendanceById();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AttendanceController attendanceController) {
        return CustomLoader(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              title: Text("history".tr),
            ),
            body: attendanceController.attendance.length == 0
                ? CustomEmptyWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: attendanceController.attendance.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 340,
                                    maxCrossAxisExtent: 220),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kAppGreyColor(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            attendanceController
                                                .attendance[index].playerId.pic,
                                            fit: BoxFit.cover,
                                            height: 220,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(attendanceController
                                            .attendance[index]
                                            .playerId
                                            .name
                                            .capitalize!),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "PlayerId: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 0),
                                            ),
                                            Text(
                                              attendanceController
                                                  .attendance[index]
                                                  .playerId
                                                  .pId,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          attendanceController
                                              .attendance[index].remark,
                                          maxLines: 2,
                                          style:
                                              TextStyle(color: primaryColor()),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text("In Time: " +
                                            customTimeFormat(
                                                attendanceController
                                                    .attendance[index].inTime)),
                                        Text("Out Time: " +
                                            "${attendanceController.attendance[index].outTime == '' ? "" : customTimeFormat(attendanceController.attendance[index].outTime)}")
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
