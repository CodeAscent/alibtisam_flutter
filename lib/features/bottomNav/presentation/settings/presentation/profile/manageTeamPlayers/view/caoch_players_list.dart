import 'package:alibtisam/features/bottomNav/model/team.dart';
import 'package:alibtisam/features/bottomNav/presentation/settings/presentation/profile/manageTeamPlayers/view/player_data.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/widgets/player_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachPlayersListForProfile extends StatefulWidget {
  final List<PlayersModel> players;
  const CoachPlayersListForProfile({
    super.key,
    required this.players,
  });

  @override
  State<CoachPlayersListForProfile> createState() =>
      _CoachPlayersListForProfileState();
}

class _CoachPlayersListForProfileState
    extends State<CoachPlayersListForProfile> {
  final monitoringController = Get.find<MonitoringController>();
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
          appBar: AppBar(
            title: Text("players".tr),
          ),
          body: widget.players.length == 0
              ? CustomEmptyWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.players.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.to(() => PlayerDataForProfile(
                                      player: widget.players[index].playerId))!;
                                },
                                child: PlayerCard(
                                    name: widget.players[index].playerId.name,
                                    image: widget.players[index].playerId.pic,
                                    playerId: widget.players[index].playerId.pId
                                        .toString())
                                //   Container(
                                //     decoration: BoxDecoration(
                                //         color: kAppGreyColor(),
                                //         borderRadius: BorderRadius.circular(10)),
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(bottom: 5),
                                //       child: Column(
                                //         children: [
                                //           ClipRRect(
                                //             borderRadius: BorderRadius.circular(10),
                                //             child: Image.network(
                                //               widget.players[index].playerId.pic,
                                //               fit: BoxFit.cover,
                                //               height: 200,
                                //               width: double.infinity,
                                //             ),
                                //           ),
                                //           Spacer(),
                                //           Text(widget.players[index].playerId.name
                                //               .capitalize!),
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [
                                //               Text(
                                //                 "PlayerId: ",
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.w800,
                                //                     letterSpacing: 0),
                                //               ),
                                //               Text(
                                //                 widget.players[index].playerId.pId,
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.w800,
                                //                     letterSpacing: 0),
                                //               ),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),

                                );
                          },
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
