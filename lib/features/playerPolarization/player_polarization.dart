import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/groupsManagement/view_members.dart';
import 'package:alibtisam/features/playerPolarization/controller/fetch_players.dart';
import 'package:alibtisam/features/playerPolarization/polarize_player.dart';
import 'package:alibtisam/features/statistics/coach/stages_tab_bar.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';
import 'package:alibtisam/core/services/api_requests.dart';
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
  PlayerPolarizationController playerPolarizationController =
      Get.find<PlayerPolarizationController>();
  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length:
            userController.user!.stage.where((e) => e != 'PROFESSIONAL').length,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Player Polarization'.tr),
        ),
        body: CustomTabBar(tabController: _tabController, customTabs: [
          ...userController.user!.stage.where((e) => e != 'PROFESSIONAL').map(
                (e) => Text(e),
              )
        ], tabViewScreens: [
          ...userController.user!.stage
              .where((e) => e != 'PROFESSIONAL')
              .map((e) => GetBuilder<PlayerPolarizationController>(
                    initState: (state) {
                      playerPolarizationController.fetchPlayersByStage(e);
                    },
                    builder: (controller) {
                      return controller.loading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: controller.players.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                UserModel user = controller.players[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => PolarizePlayer(player: user))!
                                        .then((val) {
                                      controller.fetchPlayersByStage(e);
                                    });
                                  },
                                  child: PlayerCard(
                                      name: user.name!,
                                      image: user.pic!,
                                      playerId: user.pId.toString()),
                                );
                              },
                            );
                    },
                  ))
        ]),
      );
    });
  }
}
