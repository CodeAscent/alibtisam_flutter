import 'package:SNP/features/bottomNav/controller/teams.dart';
import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/presentation/settings/presentation/profile/manageTeamPlayers/caoch_players_list.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_history_list.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance_tab_screen.dart';
import 'package:SNP/core/common/widgets/custom_empty_icon.dart';
import 'package:SNP/core/common/widgets/custom_gradient_button.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTeamsListForProfile extends StatefulWidget {
  const CoachTeamsListForProfile({super.key});

  @override
  State<CoachTeamsListForProfile> createState() =>
      _CoachTeamsListForProfileState();
}

class _CoachTeamsListForProfileState extends State<CoachTeamsListForProfile> {
  TeamsController teamsController = Get.find<TeamsController>();
  @override
  void initState() {
    super.initState();
    teamsController.fetchTeams();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(child: GetBuilder(
      builder: (TeamsController teamsController) {
        return Scaffold(
          appBar: AppBar(
            title: Text("teams".tr),
          ),
          body: teamsController.teams.length == 0
              ? CustomEmptyWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ...List.generate(teamsController.teams.length,
                            (int index) {
                          return CustomGradientButton(
                            onTap: () {
                              Get.to(() => CoachPlayersListForProfile(
                                  players:
                                      teamsController.teams[index].players));
                            },
                            label: teamsController.teams[index].name,
                          );
                        })
                      ],
                    ),
                  ),
                ),
        );
      },
    ));
  }
}
