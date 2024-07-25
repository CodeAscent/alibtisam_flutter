import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/groupsManagement/view_members.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/playerPolarization/polarize_player.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/stages_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/widgets/player_card.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerPolarization extends StatefulWidget {
  const PlayerPolarization({super.key});

  @override
  State<PlayerPolarization> createState() => _PlayerPolarizationState();
}

class _PlayerPolarizationState extends State<PlayerPolarization>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserController userController = Get.find<UserController>();
  GroupsController groupsController = Get.find<GroupsController>();
  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length:
            userController.user!.stage.where((e) => e != 'PROFESSIONAL').length,
        vsync: this);
  }

  fetchData(e) {
    return ApiRequests().getPlayersByStage(stage: e);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Player Polarization'),
        ),
        body: CustomTabBar(tabController: _tabController, customTabs: [
          ...userController.user!.stage.where((e) => e != 'PROFESSIONAL').map(
                (e) => Text(e),
              )
        ], tabViewScreens: [
          ...userController.user!.stage
              .where((e) => e != 'PROFESSIONAL')
              .map((e) => FutureBuilder<List<UserModel>?>(
                    future: fetchData(e),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            UserModel user = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => PolarizePlayer(player: user));
                              },
                              child: PlayerCard(
                                  name: user.name!,
                                  image: user.pic!,
                                  playerId: user.pId.toString()),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ))
        ]),
      );
    });
  }
}
