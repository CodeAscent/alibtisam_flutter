// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance/attendance_sqf_model.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance/services/sql_db_attendance.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachMarkAttendance extends StatefulWidget {
  const CoachMarkAttendance({
    super.key,
  });

  @override
  State<CoachMarkAttendance> createState() => _CoachMarkAttendanceState();
}

class _CoachMarkAttendanceState extends State<CoachMarkAttendance> {
  List presentPlayers = [];
  List<AttendanceDB>? attendance = [];
  TextEditingController remarkController = TextEditingController();

  setRemark(data, remark) async {
    for (var element in attendance!) {
      if (element.playerId == data["playerId"]) {
        element.remark = remark;
        await DatabaseHelper.updateAttendance(element);
      }
    }
    await getAttendance();
  }

  checkIfBothBoxesChecked() {
    for (var element in attendance!) {
      if (element.inTime != "" && element.outTime == "") {
        Get.snackbar("message".tr, "pleaseFillOutTimeForAllPresentPlayers".tr,
            backgroundColor: Colors.white);
        return false;
      }
    }
    return true;
  }

  getAttendance() async {
    attendance = await DatabaseHelper.getAttendance() ?? [];
  }

  fillAttendance() async {
    if (attendance!.isEmpty) {
      setState(() {
        isLoading = true;
      });
      for (var data in snapshot) {
        await DatabaseHelper.addAttendance(AttendanceDB(
            // id: widget.teamsModel.id!,
            playerId: data["playerId"],
            name: data['name'],
            inTime: "",
            outTime: "",
            remark: "",
            id: ''));
      }
      await getAttendance();
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
  List<dynamic> snapshot = [];
  Future loadApi() async {
    setState(() {
      isLoading = true;
    });
    // snapshot = await AppApi()
    //     .getPlayersByTeamId(teamId: widget.teamsModel.id.toString());
    // HttpWrapper.dummyLoading();

    await getAttendance();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadApi().whenComplete(() => fillAttendance());
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("teamAttendance".tr),
          toolbarHeight: 175,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            children: [
              Card(
                surfaceTintColor: Colors.white,
                color: primaryColor().withOpacity(0.7),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        "player".tr,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            Text("in".tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800)),
                            SizedBox(width: 35),
                            Text("out".tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "markAttendanceNote".tr,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(snapshot.length, (index) {
                final data = snapshot[index];

                return Stack(
                  children: [
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: SizedBox(
                        height: 85,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ListTile(
                              title: Text(
                                data["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                  "playerId".tr + data["playerId"].toString()),
                              trailing: SizedBox(
                                width: 130,
                                child: Row(
                                  children: [
                                    Checkbox(
                                        activeColor: primaryColor(),
                                        value: attendance!.any((element) =>
                                            element.playerId ==
                                                data["playerId"] &&
                                            element.inTime != ""),
                                        onChanged: (val) async {
                                          for (var element in attendance!) {
                                            if (element.playerId ==
                                                data["playerId"]) {
                                              if (element.inTime == "") {
                                                element.inTime =
                                                    DateTime.now().toString();
                                                await DatabaseHelper
                                                    .updateAttendance(element);
                                              } else {
                                                element.inTime = "";
                                                element.outTime = "";
                                                await DatabaseHelper
                                                    .updateAttendance(element);
                                              }
                                            }
                                            setState(() {});
                                          }
                                          await getAttendance;
                                        }),
                                    SizedBox(width: 15),
                                    Visibility(
                                      visible: attendance!.any((element) =>
                                          element.playerId ==
                                              data["playerId"] &&
                                          element.inTime != ""),
                                      child: Checkbox(
                                          value: attendance!.any((element) {
                                            if (element.playerId ==
                                                data["playerId"])
                                              return element.outTime != "";
                                            return false;
                                          }),
                                          activeColor: primaryColor(),
                                          onChanged: (val) async {
                                            for (var element in attendance!) {
                                              if (element.playerId ==
                                                  data["playerId"]) {
                                                if (element.outTime == "") {
                                                  element.outTime =
                                                      DateTime.now().toString();
                                                  await DatabaseHelper
                                                      .updateAttendance(
                                                          element);
                                                } else {
                                                  element.outTime = "";
                                                  await DatabaseHelper
                                                      .updateAttendance(
                                                          element);
                                                }
                                              }
                                              setState(() {});
                                            }
                                            await getAttendance;
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                          onTap: () {
                            for (var e in attendance!) {
                              if (e.playerId == data["playerId"]) {
                                remarkController.text = e.remark;
                                setState(() {});
                              }
                            }
                            kRemarkPopUp(data)
                                .then((value) => remarkController.clear());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor(),
                                  // boxShadow: commonBoxShadow(),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                  )),
                              child: attendance!.any((element) {
                                if (element.playerId == data["playerId"]) {
                                  return element.remark != '';
                                }
                                return false;
                              })
                                  ? Text("edit".tr,
                                      style: TextStyle(color: Colors.white))
                                  : Text(
                                      "remark".tr,
                                      style: TextStyle(color: Colors.white),
                                    )),
                        ))
                  ],
                );
              })
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: GestureDetector(
            onTap: () async {
              await getAttendance();
              setState(() {});
              if (checkIfBothBoxesChecked()) {
                // await AppApi().markAttendanceByCoachId(
                //   teamId: widget.teamsModel.id.toString(),
                //   players: attendance!,
                // );
              }
              ;
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor(),
                  borderRadius: BorderRadius.circular(5)),
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "submitAttendance".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> kRemarkPopUp(data) {
    return Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "remark".tr,
        titleStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        content: TextFormField(
          controller: remarkController,
          maxLines: 3,
          decoration: InputDecoration(
              isDense: true,
              hintText: "writeAremarkHere".tr,
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder()),
        ),
        onCancel: () {},
        onConfirm: () {
          if (remarkController.text == '') {
            if (!Get.isSnackbarOpen) {
              Get.snackbar("message".tr, "pleasewriteAremarkFirst".tr,
                  backgroundColor: Colors.white);
            }
          } else {
            setRemark(data, remarkController.text);
            setState(() {});
            Get.back();
            if (!Get.isSnackbarOpen) {
              Get.snackbar("message".tr, "remarkAddedSuccessfully".tr,
                  backgroundColor: Colors.white);
            }
          }
        });
  }
}
