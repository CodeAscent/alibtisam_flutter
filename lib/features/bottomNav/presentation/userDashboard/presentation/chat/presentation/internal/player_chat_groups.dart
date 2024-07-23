import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/chat/chat.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PlayerChatGroups extends StatelessWidget {
  const PlayerChatGroups({super.key});

  @override
  Widget build(BuildContext context) {
    final groupsController = Get.find<GroupsController>();

    return GetBuilder<GroupsController>(
      initState: (state) {
        groupsController.fetchGroupsForPlayer();
      },
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Chat Groups'),
            ),
            body: groupsController.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: groupsController.groups!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        GroupModel group = groupsController.groups![index];
                        return GestureDetector(
                          onTap: () async {
                            groupsController.updateSelectedGroup(group);
                            groupsController.selectedGroupId = group.id!;
                            Get.to(() => ChatScreen(
                                    groupId: group.id!, name: group.name!))!
                                .then((val) =>
                                    groupsController.fetchGroupsForPlayer());
                          },
                          child: Column(
                            children: [
                              kCustomListTile(
                                  key: group.name!.capitalize!,
                                  value:
                                      "Total members: ${group.totalMembers}"),
                            ],
                          ),
                        );
                      },
                    ),
                  ));
      },
    );
  }
}
