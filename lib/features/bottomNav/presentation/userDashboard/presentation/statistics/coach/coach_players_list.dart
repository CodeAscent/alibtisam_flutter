import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/caoch_statistics.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/coach_player_monitoring.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
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
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
          appBar: AppBar(
            title: Text("players".tr),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 250,
                        maxCrossAxisExtent: 220),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CoachStatistics());
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
                                  'https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg',
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                                Spacer(),
                                Text("PLAYER ID"),
                                Text(
                                  "PLAYER Name",
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
