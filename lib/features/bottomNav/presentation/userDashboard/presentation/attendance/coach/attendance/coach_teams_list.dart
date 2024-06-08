import 'package:SNP/features/bottomNav/controller/teams.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_players_list.dart';
import 'package:SNP/helper/common/widgets/custom_empty_icon.dart';
import 'package:SNP/helper/common/widgets/custom_gradient_button.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTeamsList extends StatefulWidget {
  const CoachTeamsList({super.key});

  @override
  State<CoachTeamsList> createState() => _CoachTeamsListState();
}

class _CoachTeamsListState extends State<CoachTeamsList> {
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
                              Get.to(() => CoachPlayersList(
                                    players:
                                        teamsController.teams[index].players,
                                  ));
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
