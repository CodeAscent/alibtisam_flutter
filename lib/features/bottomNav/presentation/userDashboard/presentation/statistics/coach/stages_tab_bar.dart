import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_players_list.dart';
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
        title: Text('selectstage'.tr),
      ),
      body: CustomTabBar(tabController: _tabController, customTabs: [
        ...user.stage.map(
          (e) => Text(e),
        )
      ], tabViewScreens: [
        ...user.stage.map((e) => GroupsByStage(
              stage: e,
              onTap: () {},
            )),
      ]),
    );
  }
}

class GroupsByStage extends StatelessWidget {
  final void Function()? onTap;
  final bool? externalOnTap;
  final String stage;
  final bool? showSelected;

  const GroupsByStage(
      {super.key,
      required this.stage,
      this.onTap,
      this.externalOnTap,
      this.showSelected = false});
  @override
  Widget build(BuildContext context) {
    final groupsController = Get.find<GroupsController>();
    final userController = Get.find<UserController>();
    return GetBuilder<GroupsController>(
      initState: (state) {
        groupsController.fetchGroups(
            stage: stage, gameId: userController.user!.gameId!.id!);
      },
      builder: (controller) {
        return groupsController.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : groupsController.groups!.length == 0
                ? Center(child: Text('noGroupsFound'.tr))
                : SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: groupsController.groups!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        GroupModel group = groupsController.groups![index];
                        return GestureDetector(
                          onTap: () async {
                            groupsController.selectedGroupId = group.id!;
                            groupsController.updateSelectedGroup(group);

                            if (externalOnTap == true) {
                              onTap!();
                            } else {
                              Get.to(() => CoachPlayersList());
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: showSelected == true &&
                                          groupsController.selectedGroupId ==
                                              group.id
                                      ? Colors.blue.shade100
                                      : null,
                                ),
                                child: kCustomListTile(
                                    key: group.name!.capitalize!,
                                    value: "totalMembers".tr +
                                        "${group.totalMembers}"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
      },
    );
  }
}
