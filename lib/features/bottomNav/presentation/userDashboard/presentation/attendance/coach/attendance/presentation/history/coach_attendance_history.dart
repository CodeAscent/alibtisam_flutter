import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachAttendanceHistory extends StatefulWidget {
  const CoachAttendanceHistory({super.key});

  @override
  State<CoachAttendanceHistory> createState() => _CoachAttendanceHistoryState();
}

class _CoachAttendanceHistoryState extends State<CoachAttendanceHistory> {
  bool isLoading = false;
  List<dynamic> attendance = [];
  getAttendance() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("attendance".tr),
          toolbarHeight: 80,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...List.generate(
                attendance.length,
                (index) => Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                            attendance[index]["teamId"]["teamName"].toString()),
                        // subtitle: Text("markedOn".tr +
                        //     customDateFormatter(
                        //         format: "dd/MM/yyyy hh:mm a",
                        //         dateString:
                        //             attendance[index]["createdAt"].toString())),
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.45,
                                  child: Text(
                                    "present".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    "absent".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                )
                              ]),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: Get.width * 0.45,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                      attendance[index]['players']
                                          .where((e) =>
                                              e["attendance"] == "present")
                                          .length, (presentIndex) {
                                    final present = [];

                                    for (var element in attendance[index]
                                        ["players"]) {
                                      if (element["attendance"] == "present") {
                                        present.add(element);
                                      }
                                    }
                                    return Card(
                                      color: Colors.green,
                                      child: ListTile(
                                        title: Text(present[presentIndex]
                                                ["name"]
                                            .split(" ")[0]),
                                        subtitle: Text(present[presentIndex]
                                                ["playerId"]
                                            .toString()),
                                        textColor: Colors.white,
                                        titleTextStyle: TextStyle(fontSize: 12),
                                        trailing: IconButton(
                                            onPressed: () {
                                              Get.bottomSheet(
                                                kRepeatedSheet(
                                                    present[presentIndex],
                                                    Colors.green),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.info,
                                              color: Colors.white,
                                            )),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.45,
                                child: Column(
                                  children: List.generate(
                                      attendance[index]['players']
                                          .where((e) =>
                                              e["attendance"] == "absent")
                                          .length, (absentIndex) {
                                    final absent = [];

                                    for (var element in attendance[index]
                                        ["players"]) {
                                      if (element["attendance"] == "absent") {
                                        absent.add(element);
                                      }
                                    }
                                    return Card(
                                      color: Colors.red,
                                      child: ListTile(
                                        title: Text(absent[absentIndex]["name"]
                                            .split(" ")[0]),
                                        subtitle: Text(absent[absentIndex]
                                                ["playerId"]
                                            .toString()),
                                        textColor: Colors.white,
                                        titleTextStyle: TextStyle(fontSize: 12),
                                        trailing: IconButton(
                                            onPressed: () {
                                              Get.bottomSheet(
                                                kRepeatedSheet(
                                                    absent[absentIndex],
                                                    Colors.red),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.info,
                                              color: Colors.white,
                                            )),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )).reversed
          ],
        )),
      ),
    );
  }

  SizedBox kRepeatedSheet(player, Color color) {
    return SizedBox(
      height: 300,
      width: Get.width,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                "playerId".tr + player["playerId"].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            kRepeatedText(player["name"]),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    "remark".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  Text(
                    player["remark"].toString() == ''
                        ? "noRemarkAdded".tr
                        : player["remark"].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            if (player["attendance"] == "present")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // kRepeatedText("In-Time: " +
                  //     customDateFormatter(
                  //         format: "dd MMM, yyyy At hh:mm a",
                  //         dateString: player["inTime"].toString())),
                  // kRepeatedText("Out-Time: " +
                  //     customDateFormatter(
                  //         format: "dd MMM, yyyy At hh:mm a",
                  //         dateString: player["outTime"].toString())),
                ],
              ),
          ]),
        ),
      ),
    );
  }

  Text kRepeatedText(text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
    );
  }
}
