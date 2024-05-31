import 'package:alibtisam_flutter/features/bottomNav/model/team.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/player_statistics.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachPlayersList extends StatefulWidget {
  final List<PlayersModel> players;
  const CoachPlayersList({
    super.key,
    required this.players,
  });

  @override
  State<CoachPlayersList> createState() => _CoachPlayersListState();
}

class _CoachPlayersListState extends State<CoachPlayersList> {
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
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.players.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 250,
                                  maxCrossAxisExtent: 220),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => PlayerStatistics(
                                      playerId:
                                          widget.players[index].playerId.id,
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kAppGreyColor(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        widget.players[index].playerId.pic,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                      Spacer(),
                                      Text(widget.players[index].playerId.name
                                          .capitalize!),
                                      Text(
                                        widget.players[index].playerId.userName,
                                        maxLines: 1,
                                      ),
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
                )
          // FutureBuilder(
          //   future: AppApi()
          //       .getPlayersByTeamId(teamId: widget.teamsModel.id.toString()),
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     if (snapshot.hasData) {
          //       return SingleChildScrollView(
          //         child: Column(
          //           children: List.generate(snapshot.data.length, (index) {
          //             final data = snapshot.data[index];
          //             return Card(
          //               color: Colors.white,
          //               surfaceTintColor: Colors.white,
          //               child: SizedBox(
          //                 height: 85,
          //                 child: Column(
          //                   children: [
          //                     SizedBox(height: 10),
          //                     ListTile(
          //                       onTap: () {
          //                         HttpWrapper.dummyLoading();
          //                         Get.to(() => CoachMonitering(
          //                               player: snapshot.data[index],
          //                             ));
          //                       },
          //                       title: Text(
          //                         data["name"],
          //                         maxLines: 1,
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                       subtitle: Text(
          //                           "playerId".tr + data["playerId"].toString()),
          //                       trailing: Icon(Icons.navigate_next),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           }),
          //         ),
          //       );
          //     } else {
          //       return SizedBox();
          //     }
          //   },
          // ),
          ),
    );
  }
}
