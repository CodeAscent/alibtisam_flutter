import 'package:SNP/features/bottomNav/model/team.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/player_statistics.dart';
import 'package:SNP/helper/common/widgets/custom_empty_icon.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/theme/app_colors.dart';
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          widget.players[index].playerId.pic,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(widget.players[index].playerId.name
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
                                            widget.players[index].playerId.pId,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0),
                                          ),
                                        ],
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
