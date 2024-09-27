import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/view_members.dart';
import 'package:alibtisam/features/statistics/coach/stages_tab_bar.dart';
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
                child: CupertinoAlertDialog(
                  title: Row(
                    children: [
                      Text("createGroup".tr),
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
                        CustomTextField(
                            controller: groupNameController,
                            label: 'groupName'.tr),
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
                                    Text('school'.tr)
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
                                    Text('academy'.tr)
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
                            label: 'submit'.tr)
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
                Get.to(() => ViewGroupMembers(
                          canUpdate: e == 'PROFESSIONAL' ? false : true,
                        ))!
                    .then((val) => groupsController.fetchGroups(
                        stage: e, gameId: userController.user!.gameId!.id!));
              },
            )),
      ]),
    );
  }
}
