import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/groupsManagement/view_members.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/stages_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsManagement extends StatefulWidget {
  const GroupsManagement({super.key});

  @override
  State<GroupsManagement> createState() => _GroupsManagementState();
}

class _GroupsManagementState extends State<GroupsManagement>
    with TickerProviderStateMixin {
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
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: primaryColor(),
        onPressed: () {
          final groupStageController = TextEditingController();
          final groupNameController = TextEditingController();
          showCupertinoDialog(
            context: context,
            builder: (context) => Material(
                color: Colors.transparent,
                child: CupertinoActionSheet(
                  title: Row(
                    children: [
                      Text("Create Group"),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel")),
                    ],
                  ),
                  message: Container(
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: groupNameController,
                            label: 'GroupName'),
                        StatefulBuilder(
                          builder: (context, newState) => Row(
                            children: [
                              Visibility(
                                visible: user.gameId!.stage!.contains('SCHOOL'),
                                child: Row(
                                  children: [
                                    CupertinoCheckbox(
                                        value: groupStageController.text ==
                                            'SCHOOL',
                                        onChanged: (val) {
                                          groupStageController.text = 'SCHOOL';
                                          newState(() {});
                                        }),
                                    Text(' SCHOOL')
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    user.gameId!.stage!.contains('ACADEMY'),
                                child: Row(
                                  children: [
                                    CupertinoCheckbox(
                                        value: groupStageController.text ==
                                            'ACADEMY',
                                        onChanged: (val) {
                                          newState(() {
                                            groupStageController.text =
                                                'ACADEMY';
                                          });
                                        }),
                                    Text(' ACADEMY')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomContainerButton(
                            onTap: () async {
                              if (groupNameController.text.trim() != '' &&
                                  groupStageController.text != '') {
                                groupsController.createGroup(
                                    stage: groupStageController.text,
                                    gameId: user.gameId!.id!,
                                    name: groupNameController.text);
                                if (groupStageController.text == "SCHOOL") {
                                  _tabController.index = 0;
                                } else if (groupStageController.text ==
                                    "ACADEMY") {
                                  _tabController.index = 1;
                                }
                                Get.back();
                              }
                            },
                            label: 'Submit')
                      ],
                    ),
                  ),
                )),
          ).then((val) => groupsController.isLoading = true);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Select Stage'),
      ),
      body: CustomTabBar(tabController: _tabController, customTabs: [
        ...user.stage.map(
          (e) => Text(e),
        )
      ], tabViewScreens: [
        ...user.stage.map((e) => PlayersByStage(
              externalOnTap: true,
              stage: e,
              onTap: () async {
                List<UserModel>? users = [];
                users = await groupsController.fetchGroupMembers();

                setState(() {});
                Get.to(() => ViewGroupMembers(
                      players: users!,
                    ));
              },
            )),
      ]),
    );
  }
}
