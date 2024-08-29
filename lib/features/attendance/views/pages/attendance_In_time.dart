import 'package:alibtisam/features/attendance/models/attendance.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/services/api_requests.dart';

class AttendanceInTime extends StatefulWidget {
  final String groupId;
  const AttendanceInTime({
    super.key,
    required this.groupId,
  });

  @override
  State<AttendanceInTime> createState() => _AttendanceInTimeState();
}

class _AttendanceInTimeState extends State<AttendanceInTime> {
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();
  List<PlayersAttendance> playersAttendance = [];
  @override
  void initState() {
    super.initState();
    attendanceController.fetchAttendanceForInTime(
      groupId: widget.groupId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (AttendanceController attendanceController) {
        return 
 Scaffold(
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
                                      PlayersAttendance(id: player.id!))) {
                                    playersAttendance.remove(
                                        PlayersAttendance(id: player.id!));
                                  } else {
                                    playersAttendance.add(PlayersAttendance(
                                      id: player.id!,
                                    ));
                                  }
                                  setState(() {});
                                },
                                child: Stack(
                                  children: [
                                    PlayerCard(
                                      name: player.name!,
                                      image: player.pic!,
                                      playerId: player.pId.toString(),
                                      showArrow: false,
                                      extraWidget: SizedBox(
                                        child: Visibility(
                                          replacement: SizedBox(
                                            height: 30,
                                          ),
                                          visible: playersAttendance.contains(
                                              PlayersAttendance(
                                                  id: player.id!)),
                                          child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    TextEditingController
                                                        remarkController =
                                                        TextEditingController();
                                                    for (var players
                                                        in playersAttendance) {
                                                      if (players.id ==
                                                          player.id) {
                                                        if (players.remark !=
                                                            '') {
                                                          remarkController
                                                                  .text =
                                                              players.remark!;
                                                        }
                                                      }
                                                    }
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Write your remark.."
                                                              .tr),
                                                      content: TextFormField(
                                                        controller:
                                                            remarkController,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                                "cancel".tr)),
                                                        TextButton(
                                                            onPressed: () {
                                                              for (var players
                                                                  in playersAttendance) {
                                                                if (players
                                                                        .id ==
                                                                    player.id) {
                                                                  players.remark =
                                                                      remarkController
                                                                          .text;

                                                                  setState(
                                                                      () {});
                                                                }
                                                              }

                                                              Get.back();
                                                            },
                                                            child:
                                                                Text("ok".tr))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Builder(
                                              builder: (context) {
                                                String text = '';
                                                for (var players
                                                    in playersAttendance) {
                                                  if (players.id == player.id) {
                                                    if (players.remark == '') {
                                                      text = "ADD REMARK".tr;
                                                    } else {
                                                      text = players.remark!;
                                                    }
                                                  }
                                                }
                                                return Text(
                                                  text,
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (playersAttendance.contains(
                                        PlayersAttendance(id: player.id!)))
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
                    attendanceController.fetchAttendanceForInTime(
                      groupId: widget.groupId,
                    );
                  },
                  label: "submit".tr,
                  disabled: attendanceController.attendance.isEmpty,
                )),
          );
        
      },
    );
  }
}
