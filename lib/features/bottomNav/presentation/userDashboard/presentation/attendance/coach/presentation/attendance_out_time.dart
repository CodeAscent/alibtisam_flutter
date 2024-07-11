import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/model/attendance.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/widgets/player_card.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceOutTime extends StatefulWidget {
  const AttendanceOutTime({super.key});

  @override
  State<AttendanceOutTime> createState() => _AttendanceOutTimeState();
}

class _AttendanceOutTimeState extends State<AttendanceOutTime> {
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();
  List<PlayersAttendance> playersAttendance = [];
  @override
  void initState() {
    super.initState();
    attendanceController.fetchAttendanceForOutTime();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AttendanceController attendanceController) {
        return CustomLoader(
          child: Scaffold(
            body: attendanceController.attendance.length == 0
                ? CustomEmptyWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: attendanceController.attendance.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              UserModel player = attendanceController
                                  .attendance[index].playerId;
                              return GestureDetector(
                                onTap: () {
                                  if (playersAttendance.contains(
                                      PlayersAttendance(id: player.id))) {
                                    playersAttendance.remove(
                                        PlayersAttendance(id: player.id));
                                  } else {
                                    playersAttendance.add(PlayersAttendance(
                                        id: player.id,
                                        outTime: DateTime.now().toString()));
                                  }
                                  setState(() {});
                                },
                                child: Stack(
                                  children: [
                                    PlayerCard(
                                      name: player.name,
                                      image: player.pic,
                                      playerId: player.pId,
                                      showArrow: false,
                                      extraWidget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'In Time :- ${customTimeFormat(attendanceController.attendance[index].inTime)}'),
                                          SizedBox(
                                            child: Text(
                                              attendanceController
                                                  .attendance[index].remark,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (playersAttendance.contains(
                                        PlayersAttendance(id: player.id)))
                                      Positioned(
                                        top: 50,
                                        right: 15,
                                        child: CircleAvatar(
                                            backgroundColor: primaryColor(),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )),
                                      ),
                                  ],
                                ),

                                // Container(
                                //   decoration: BoxDecoration(
                                //       color: kAppGreyColor(),
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(bottom: 5),
                                //     child: Column(
                                //       children: [
                                //         Stack(
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(10),
                                //               child: Image.network(
                                //                 attendanceController
                                //                     .attendance[index]
                                //                     .playerId
                                //                     .pic,
                                //                 fit: BoxFit.cover,
                                //                 height: 220,
                                //                 width: double.infinity,
                                //               ),
                                //             ),
                                //             if (playersAttendance.contains(
                                //                 PlayersAttendance(
                                //                     id: player.id)))
                                //               Positioned(
                                //                 top: 10,
                                //                 right: 10,
                                //                 child: CircleAvatar(
                                //                     backgroundColor:
                                //                         kAppGreyColor(),
                                //                     child: Icon(
                                //                       Icons.check,
                                //                       color: Colors.green,
                                //                     )),
                                //               )
                                //           ],
                                //         ),
                                //         Spacer(),
                                //         Text(attendanceController
                                //             .attendance[index]
                                //             .playerId
                                //             .name
                                //             .capitalize!),
                                //         Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             Text(
                                //               "PlayerId: ",
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w800,
                                //                   letterSpacing: 0),
                                //             ),
                                //             Text(
                                //               attendanceController
                                //                   .attendance[index]
                                //                   .playerId
                                //                   .pId,
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w800,
                                //                   letterSpacing: 0),
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           attendanceController
                                //               .attendance[index].remark,
                                //           maxLines: 2,
                                //           style:
                                //               TextStyle(color: primaryColor()),
                                //           overflow: TextOverflow.ellipsis,
                                //         ),
                                //         Text("In Time: " +
                                //             customTimeFormat(
                                //                 attendanceController
                                //                     .attendance[index].inTime)),
                                //         Text("Out Time: " +
                                //             "${attendanceController.attendance[index].outTime == '' ? "" : customTimeFormat(attendanceController.attendance[index].outTime)}")
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
            bottomNavigationBar: Container(
                margin: EdgeInsets.all(10),
                height: 70,
                child: CustomGradientButton(
                  onTap: () async {
                    await ApiRequests().markAttendance(
                        attendanceId: attendanceController.attendanceId,
                        playersAttendance: playersAttendance);
                    attendanceController.fetchAttendanceForOutTime();
                  },
                  label: "Submit",
                  disabled: attendanceController.attendance.isEmpty,
                )),
          ),
        );
      },
    );
  }
}
