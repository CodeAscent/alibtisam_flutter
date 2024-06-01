import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/theme/app_colors.dart';
import 'package:SNP/network/http_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachAttendanceTeamsList extends StatefulWidget {
  const CoachAttendanceTeamsList({super.key});

  @override
  State<CoachAttendanceTeamsList> createState() =>
      _CoachAttendanceTeamsListState();
}

class _CoachAttendanceTeamsListState extends State<CoachAttendanceTeamsList> {
  @override
  void initState() {
    super.initState();
    // getTeams();
  }

  // List<TeamsModel> teamsModel = [];
  // getTeams() async {
  //   List data = await AppApi().getTeamsByCoachId();
  //   teamsModel.assignAll(data.map((e) => TeamsModel.fromMap(e)));
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("teamAttendance".tr),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  // HttpWrapper.startLoading();

                  // Get.to(() => CoachAttendanceHistory());
                },
                icon: Icon(Icons.receipt_rounded)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ...List.generate(
              //     teamsModel.length,
              //     (i) => Card(
              //           color: i % 2 == 0
              //               ? primaryColor().withOpacity(0.6)
              //               : Colors.grey.shade300,
              //           child: SizedBox(
              //             height: 70,
              //             child: ListTile(
              //               onTap: () {
              //                 HttpWrapper.startLoading();
              //                 Get.to(() => CoachMarkAttendance(
              //                     teamsModel: teamsModel[i]));
              //               },
              //               title: Text(teamsModel[i].teamName.toString()),
              //               titleTextStyle: TextStyle(
              //                   fontWeight: FontWeight.w700,
              //                   color: blackColor(),
              //                   fontSize: 16),
              //               subtitle: Text("Team Size " +
              //                   teamsModel[i].teamSize.toString()),
              //               trailing: Icon(
              //                 Icons.navigate_next,
              //                 size: 40,
              //                 color: blackColor(),
              //               ),
              //             ),
              //           ),
              //         ))
            ],
          ),
        ),
      ),
    );
  }
}
