import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/group_members_view_model.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/enrollment/views/pages/view_addmision_form.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewGroupMembers extends StatefulWidget {
  final bool canUpdate;
  const ViewGroupMembers({super.key, required this.canUpdate});

  @override
  State<ViewGroupMembers> createState() => _ViewGroupMembersState();
}

class _ViewGroupMembersState extends State<ViewGroupMembers> {
  List<UserModel> players = [];
  final groupsController = Get.find<GroupsController>();
  String newGroupId = '';
  @override
  void initState() {
    super.initState();
    fetchData();
    fetchAnathPlayers();
  }

  fetchData() async {
    players = (await groupsController.fetchGroupMembers()) ?? [];

    setState(() {});
  }

  fetchAnathPlayers() {
    groupMembersViewModel.fetchNonGroupMembers(
        stage: groupsController.selectedGroup.stage!,
        gameId: userController.user!.gameId!.id!);
  }

  final userController = Get.find<UserController>();
  final groupMembersViewModel = Get.find<GroupMembersViewModel>();
  bool isSelecting = false;
  List<String> selectedMembers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Visibility(
          visible: isSelecting,
          child: Container(
            color: Colors.blue.shade100,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isSelecting = false;
                        selectedMembers.clear();
                      });
                    },
                    child: Text(
                      'cancel'.tr,
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(width: 50),
                ElevatedButton(
                    onPressed: () async {
                      final selectedGroupController = TextEditingController();
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => Material(
                            color: Colors.transparent,
                            child: CupertinoAlertDialog(
                              title: Row(
                                children: [
                                  Text("selectGroup".tr),
                                  Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("cancel".tr)),
                                ],
                              ),
                              content: Container(
                                child: Column(
                                  children: [
                                    StatefulBuilder(
                                      builder: (context, newState) =>
                                          CustomTextField(
                                        controller: selectedGroupController,
                                        label: 'group'.tr,
                                        suffix: DropdownButton(
                                            items: groupsController.groups!
                                                .where((i) =>
                                                    i.id !=
                                                    groupsController
                                                        .selectedGroupId)
                                                .map((dynamic e) =>
                                                    DropdownMenuItem(
                                                        value: e,
                                                        child: Text(e.name)))
                                                .toList(),
                                            onChanged: (dynamic val) {
                                              selectedGroupController.text =
                                                  val.name;
                                              newGroupId = val.id;
                                              newState(() {});
                                            }),
                                      ),
                                    ),
                                    CustomContainerButton(
                                        onTap: () async {
                                          Get.back();
                                          groupsController.isLoading = true;
                                          await ApiRequests()
                                              .updateGroupMembers(
                                                  groupId: newGroupId,
                                                  members: selectedMembers);
                                          fetchData();
                                          isSelecting = false;
                                          selectedMembers.clear();
                                          setState(() {});
                                        },
                                        label: 'submit'.tr)
                                  ],
                                ),
                              ),
                            )),
                      ).then((val) => groupsController.isLoading = true);
                    },
                    child: Text(
                      'move'.tr,
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  List selectedPlayers = [];

                  showDialog(
                    context: Get.context ?? context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Material(
                          color: Colors.transparent,
                          child: AlertDialog(
                            title: Text('Players'.tr),
                            content: groupMembersViewModel.loading.value
                                ? Center(child: CircularProgressIndicator())
                                : Container(
                                    height: Get.height *
                                        0.55, // Use height instead of width
                                    width: Get.width,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: groupMembersViewModel
                                                .users.length,
                                            itemBuilder: (context, index) {
                                              UserModel user =
                                                  groupMembersViewModel
                                                      .users[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  if (selectedPlayers
                                                      .contains(user.id)) {
                                                    selectedPlayers
                                                        .remove(user.id);
                                                  } else {
                                                    selectedPlayers
                                                        .add(user.id);
                                                  }
                                                  setState(() {});
                                                },
                                                child: PlayerCard(
                                                  extraWidget: Text('age'.tr +
                                                      AgeCalculator.age(DateTime
                                                              .parse(user
                                                                  .dateOfBirth!))
                                                          .years
                                                          .toString()),
                                                  showArrow: false,
                                                  selected: selectedPlayers
                                                      .contains(user.id),
                                                  name: user.name ?? '',
                                                  image: user.pic ?? '',
                                                  playerId: user.pId.toString(),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                            actions: [
                              TextButton(
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: Text('Confirm',
                                    style: TextStyle(color: Colors.blue)),
                                onPressed: () async {
                                  if (selectedPlayers.isNotEmpty) {
                                    await groupMembersViewModel
                                        .addMembersToGroup(
                                            groupId: groupsController
                                                .selectedGroupId,
                                            memberIds: selectedPlayers);
                                  }
                                  fetchData();
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
                child: Text('Add Members'.tr))
          ],
          title: Text(groupsController.selectedGroup.name!.capitalize!),
        ),
        body: groupsController.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        final UserModel player = players[index];
                        return GestureDetector(
                          onLongPress: () {
                            if (widget.canUpdate) {
                              setState(() {
                                isSelecting = true;
                                selectedMembers.clear();
                                selectedMembers.add(player.id!);
                              });
                            }
                          },
                          onTap: () {
                            if (!isSelecting) {
                              Get.to(() => ViewPlayerByUserModel(
                                        player: player,
                                        changeGame: true,
                                      ))!
                                  .then((val) => fetchData());
                            } else {
                              if (selectedMembers.contains(player.id)) {
                                selectedMembers.remove(player.id!);
                                if (selectedMembers.isEmpty) {
                                  isSelecting = false;
                                  selectedMembers.clear();
                                }
                              } else {
                                selectedMembers.add(player.id!);
                              }
                            }
                            setState(() {});
                          },
                          child: PlayerCard(
                            extraWidget: Text('age'.tr +
                                AgeCalculator.age(
                                        DateTime.parse(player.dateOfBirth!))
                                    .years
                                    .toString()),
                            selected: selectedMembers.contains(player.id),
                            name: player.name!,
                            image: player.pic!,
                            playerId: player.pId.toString(),
                            showArrow: false,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ));
  }
}
