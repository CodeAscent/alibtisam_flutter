import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/chat/chat.dart';
import 'package:alibtisam/features/groupsManagement/view_members.dart';
import 'package:alibtisam/features/statistics/coach/stages_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatStages extends StatefulWidget {
  const ChatStages({super.key});

  @override
  State<ChatStages> createState() => _ChatStagesState();
}

class _ChatStagesState extends State<ChatStages> with TickerProviderStateMixin {
  late TabController _tabController;
  UserController userController = Get.find<UserController>();
  final groupsController = Get.find<GroupsController>();
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
              externalOnTap: true,
              stage: e,
              onTap: () async {
                Get.to(() => ChatScreen(
                        groupId: groupsController.selectedGroupId,
                        name: groupsController.selectedGroup.name!))!
                    .then((val) => groupsController.fetchGroups(
                        stage: e, gameId: userController.user!.gameId!.id!));
              },
            )),
      ]),
    );
  }
}
