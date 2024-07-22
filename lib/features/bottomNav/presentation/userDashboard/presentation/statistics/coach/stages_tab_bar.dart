import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_players_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StagesTabBar extends StatefulWidget {
  const StagesTabBar({super.key});

  @override
  State<StagesTabBar> createState() => _StagesTabBarState();
}

class _StagesTabBarState extends State<StagesTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  UserController userController = Get.find<UserController>();
  late UserModel user;
  @override
  void initState() {
    super.initState();
    user = userController.user!;
    _tabController = TabController(length: user.stage.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Stage'),
      ),
      body: CustomTabBar(tabController: _tabController, customTabs: [
        ...user.stage.map(
          (e) => Text(e),
        )
      ], tabViewScreens: [
        ...user.stage.map((e) => PlayersByStage(
              stage: e,
              onTap: () {},
            )),
      ]),
    );
  }
}

class PlayersByStage extends StatelessWidget {
  final void Function()? onTap;
  final String stage;
  const PlayersByStage({super.key, required this.stage, this.onTap});
  @override
  Widget build(BuildContext context) {
    final groupsController = Get.find<GroupsController>();
    final userController = Get.find<UserController>();
    return GetBuilder<GroupsController>(
      initState: (state) {
        groupsController.fetchGroups(
            stage: stage, gameId: userController.user!.gameId!.id);
      },
      builder: (controller) {
        return groupsController.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: groupsController.groups!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  GroupModel group = groupsController.groups![index];
                  return GestureDetector(
                    onTap: () async {
                      groupsController.selectedGroupId = group.id!;
                      //  final users=     await groupsController.fetchGroupMembers();
                      //   Get.to(() => CoachPlayersList(players: users));

                      onTap!();
                    },
                    child: Column(
                      children: [
                        kCustomListTile(
                            key: group.name!.capitalize!,
                            value: "Total members: ${group.totalMembers}"),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
