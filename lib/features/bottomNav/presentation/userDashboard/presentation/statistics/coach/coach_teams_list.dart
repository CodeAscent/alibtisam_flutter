import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_players_list.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_container_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_dashboard_card.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTeamsList extends StatefulWidget {
  const CoachTeamsList({super.key});

  @override
  State<CoachTeamsList> createState() => _CoachTeamsListState();
}

class _CoachTeamsListState extends State<CoachTeamsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Teams"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...List.generate(5, (int index) {
                  return GestureDetector(
                      onTap: () {},
                      child: CustomGradientButton(
                        onTap: () {
                          Get.to(() => CoachPlayersList());
                        },
                        label: "Team $index",
                      ));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
