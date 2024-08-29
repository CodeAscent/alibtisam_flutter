import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/enrollment/view_addmision_form.dart';
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
  }

  fetchData() async {
    players = (await groupsController.fetchGroupMembers())!;
    setState(() {});
  }

  final userController = Get.find<UserController>();
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
                            child: CupertinoActionSheet(
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
                              message: Container(
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
                                        label: 'submit')
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
          title: Text(groupsController.selectedGroup.name!.capitalize!),
        ),
        body: groupsController.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ListView.builder(
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
                            Get.to(() => ViewPlayerByUserModel(player: player));
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
                          extraWidget: Text('Age ' +
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
              ));
  }
}
