// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:SNP/features/bottomNav/model/attendance.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance/complete_attendance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:SNP/features/bottomNav/controller/attendance.dart';
import 'package:SNP/features/bottomNav/model/team.dart';
import 'package:SNP/features/bottomNav/model/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/player_statistics.dart';
import 'package:SNP/helper/common/widgets/custom_empty_icon.dart';
import 'package:SNP/helper/common/widgets/custom_gradient_button.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/theme/app_colors.dart';
import 'package:SNP/network/api_requests.dart';

class AttendancePlayersList extends StatefulWidget {
  final String teamId;
  const AttendancePlayersList({
    super.key,
    required this.teamId,
  });

  @override
  State<AttendancePlayersList> createState() => _AttendancePlayersListState();
}

class _AttendancePlayersListState extends State<AttendancePlayersList> {
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();
  List<PlayersAttendance> playersAttendance = [];
  @override
  void initState() {
    super.initState();
    attendanceController.fetchAttendance(teamId: widget.teamId);
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
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: attendanceController.attendance.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 320,
                                    maxCrossAxisExtent: 220),
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
                                    ));
                                  }
                                  setState(() {});
                                  print(playersAttendance);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kAppGreyColor(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                attendanceController
                                                    .attendance[index]
                                                    .playerId
                                                    .pic,
                                                fit: BoxFit.cover,
                                                height: 220,
                                                width: double.infinity,
                                              ),
                                            ),
                                            if (playersAttendance.contains(
                                                PlayersAttendance(
                                                    id: player.id)))
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        kAppGreyColor(),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )),
                                              )
                                          ],
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
                                        Visibility(
                                            replacement: SizedBox(
                                              height: 30,
                                            ),
                                            visible: playersAttendance.contains(
                                                PlayersAttendance(
                                                    id: player.id)),
                                            child: TextButton(onPressed: () {
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
                                                        print(players.remark);
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
                                                          "Write your remark.."),
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
                                                                  print(
                                                                      'updating remark.... ');
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
                                            }, child: Builder(
                                              builder: (context) {
                                                String text = '';
                                                for (var players
                                                    in playersAttendance) {
                                                  if (players.id == player.id) {
                                                    if (players.remark == '') {
                                                      text = "ADD REMARK";
                                                    } else {
                                                      text = players.remark!;
                                                    }
                                                  }
                                                }
                                                return Text(
                                                  text,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                              },
                                            )))
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
            bottomNavigationBar: Container(
                margin: EdgeInsets.all(10),
                height: 70,
                child: CustomGradientButton(
                  onTap: () async {
                    await ApiRequests().markAttendance(
                        attendanceId: attendanceController.attendanceId,
                        playersAttendance: playersAttendance);
                    attendanceController.fetchAttendance(teamId: widget.teamId);
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
