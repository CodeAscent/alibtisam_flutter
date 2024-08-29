import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/statistics/controller/monitoring.dart';
import 'package:alibtisam/features/statistics/player_statistics.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachPlayersList extends StatefulWidget {
  const CoachPlayersList({
    super.key,
  });

  @override
  State<CoachPlayersList> createState() => _CoachPlayersListState();
}

class _CoachPlayersListState extends State<CoachPlayersList> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    players = (await groupsController.fetchGroupMembers())!;
    setState(() {});
  }

  List<UserModel> players = [];
  final groupsController = Get.find<GroupsController>();

  final monitoringController = Get.find<MonitoringController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text("players".tr),
          ),
          body: groupsController.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : players.length == 0
                  ? CustomEmptyWidget()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: players.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => PlayerStatistics(
                                            playerId: players[index].id!,
                                          ));
                                    },
                                    child: PlayerCard(
                                        name: players[index].name!.capitalize!,
                                        image: players[index].pic!,
                                        playerId:
                                            players[index].pId!.toString()));
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
          
    );
  }
}
