import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/playerRequests/request_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/playerRequests/presentation/request/player_requests.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementForm extends StatelessWidget {
  final UserModel user;
  final String requestId;
  const MeasurementForm(
      {super.key, required this.user, required this.requestId});

  @override
  Widget build(BuildContext context) {
    List<dynamic> selectStage = ["SCHOOL", "ACADEMY"];

    final heightController =
        TextEditingController(text: user.height.toString());
    final weightController =
        TextEditingController(text: user.weight.toString());
    final chestController = TextEditingController();
    final normalController = TextEditingController();
    final highJumpController = TextEditingController();
    final lowJumpController = TextEditingController();
    final heartBeatingRateController = TextEditingController();
    final pulseRateController = TextEditingController();
    final tShirtSizeController = TextEditingController();
    final waistSizeController = TextEditingController();
    final shoesSizeController = TextEditingController();
    final groupStageController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    List tshirtSize = ['S', 'M', 'L'];
    return Form(
      key: formKey,
      child: CustomLoader(
        child: Scaffold(
          appBar: AppBar(
            title: Text("form".tr),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: heightController,
                        width: Get.width * 0.46,
                        label: "height".tr),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: weightController,
                        width: Get.width * 0.46,
                        label: "weight".tr)
                  ],
                ),
                Row(
                  children: [
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: chestController,
                        width: Get.width * 0.46,
                        label: "chestSize".tr),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: normalController,
                        width: Get.width * 0.46,
                        label: "normal chest size".tr)
                  ],
                ),
                Row(
                  children: [
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: highJumpController,
                        width: Get.width * 0.46,
                        label: "highJump".tr),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: lowJumpController,
                        width: Get.width * 0.46,
                        label: "lowJump".tr)
                  ],
                ),
                Row(
                  children: [
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: heartBeatingRateController,
                        width: Get.width * 0.46,
                        label: "heartBeatingRate".tr),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: pulseRateController,
                        width: Get.width * 0.46,
                        label: "pulseRate".tr)
                  ],
                ),
                Row(
                  children: [
                    CustomTextField(
                        readOnly: true,
                        suffix: DropdownButton(
                            items: tshirtSize
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (Object? val) {
                              tShirtSizeController.text = val.toString();
                            }),
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: tShirtSizeController,
                        width: Get.width * 0.46,
                        label: "tShirtSize".tr),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: waistSizeController,
                        width: Get.width * 0.46,
                        label: "waistSize".tr)
                  ],
                ),
                Row(
                  children: [
                    CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: shoesSizeController,
                        width: Get.width * 0.46,
                        label: "shoeSize".tr),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 70,
                  child: CustomContainerButton(
                      onTap: () async {
                        String selectedGroup = '';

                        if (formKey.currentState!.validate()) {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    GroupsController groupsController =
                                        Get.find<GroupsController>();
                                    return GetBuilder<GroupsController>(
                                      initState: (state) {
                                        groupsController.fetchGroups(
                                            stage: user.stage,
                                            gameId: user.gameId!.id);
                                      },
                                      builder: (groupsController) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: CupertinoActionSheet(
                                            actions: [
                                              SizedBox(
                                                height: 70,
                                                child: CustomContainerButton(
                                                    onTap: () async {
                                                      if (selectedGroup == '') {
                                                        return customSnackbar(
                                                            message:
                                                                "Please select a group first");
                                                      } else {
                                                        groupsController
                                                            .isLoading = true;
                                                        await ApiRequests().submitMeasurementRequest(
                                                            height: heightController
                                                                .text,
                                                            weight:
                                                                weightController
                                                                    .text,
                                                            chestSize:
                                                                chestController
                                                                    .text,
                                                            normalChestSize:
                                                                normalController
                                                                    .text,
                                                            highJump:
                                                                highJumpController
                                                                    .text,
                                                            lowJump:
                                                                lowJumpController
                                                                    .text,
                                                            heartBeatingRate:
                                                                heartBeatingRateController
                                                                    .text,
                                                            pulseRate:
                                                                pulseRateController
                                                                    .text,
                                                            tshirtSize:
                                                                tShirtSizeController
                                                                    .text,
                                                            waistSize:
                                                                waistSizeController
                                                                    .text,
                                                            shoeSize:
                                                                shoesSizeController
                                                                    .text,
                                                            requestId:
                                                                requestId,
                                                            stage: user.stage);
                                                        await groupsController
                                                            .addMemberToGroup(
                                                                memberId:
                                                                    user.id!,
                                                                groupId:
                                                                    selectedGroup);
                                                        Get.off(
                                                            PlayerRequestsTabBar());
                                                      }
                                                    },
                                                    label: 'Submit'),
                                              ),
                                            ],
                                            title: Text(
                                              'Update Details',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            message: Container(
                                              height: 500,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 20),
                                                      Text(
                                                        "Game: ${user.gameId!.name.capitalize}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Visibility(
                                                            visible: user
                                                                .gameId!.stage
                                                                .contains(
                                                                    'SCHOOL'),
                                                            child: Row(
                                                              children: [
                                                                CupertinoCheckbox(
                                                                    value: user
                                                                            .stage ==
                                                                        'SCHOOL',
                                                                    onChanged:
                                                                        (val) {
                                                                      user.stage =
                                                                          'SCHOOL';
                                                                      setState(
                                                                          () {});
                                                                      groupsController.fetchGroups(
                                                                          stage: user
                                                                              .stage,
                                                                          gameId: user
                                                                              .gameId!
                                                                              .id);
                                                                    }),
                                                                Text(' SCHOOL')
                                                              ],
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: user
                                                                .gameId!.stage
                                                                .contains(
                                                                    'ACADEMY'),
                                                            child: Row(
                                                              children: [
                                                                CupertinoCheckbox(
                                                                    value: user
                                                                            .stage ==
                                                                        'ACADEMY',
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        user.stage =
                                                                            'ACADEMY';
                                                                        groupsController.fetchGroups(
                                                                            stage:
                                                                                user.stage,
                                                                            gameId: user.gameId!.id);
                                                                      });
                                                                    }),
                                                                Text(' ACADEMY')
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(),
                                                      SizedBox(height: 20),
                                                      groupsController.isLoading
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Spacer(),
                                                                    CustomContainerButton(
                                                                        flexibleHeight:
                                                                            40,
                                                                        onTap:
                                                                            () {
                                                                          final groupNameController =
                                                                              TextEditingController();
                                                                          groupStageController.text =
                                                                              user.stage;
                                                                          showCupertinoDialog(
                                                                            context:
                                                                                context,
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
                                                                                        CustomTextField(controller: groupNameController, label: 'GroupName'),
                                                                                        StatefulBuilder(
                                                                                          builder: (context, newState) => Row(
                                                                                            children: [
                                                                                              Visibility(
                                                                                                visible: user.gameId!.stage.contains('SCHOOL'),
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    CupertinoCheckbox(
                                                                                                        value: groupStageController.text == 'SCHOOL',
                                                                                                        onChanged: (val) {
                                                                                                          groupStageController.text = 'SCHOOL';
                                                                                                          newState(() {});
                                                                                                        }),
                                                                                                    Text(' SCHOOL')
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Visibility(
                                                                                                visible: user.gameId!.stage.contains('ACADEMY'),
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    CupertinoCheckbox(
                                                                                                        value: groupStageController.text == 'ACADEMY',
                                                                                                        onChanged: (val) {
                                                                                                          newState(() {
                                                                                                            groupStageController.text = 'ACADEMY';
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
                                                                                              if (groupNameController.text.trim() != '' && groupStageController.text != '') {
                                                                                                groupsController.createGroup(stage: groupStageController.text, gameId: user.gameId!.id, name: groupNameController.text);
                                                                                                setState(() {
                                                                                                  user.stage = groupStageController.text;
                                                                                                });
                                                                                                Get.back();
                                                                                              }
                                                                                            },
                                                                                            label: 'Submit')
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ).then((val) =>
                                                                              groupsController.isLoading = true);
                                                                        },
                                                                        label:
                                                                            'Create'),
                                                                  ],
                                                                ),
                                                                ...List.generate(
                                                                    groupsController
                                                                        .groups!
                                                                        .length,
                                                                    (int
                                                                        index) {
                                                                  GroupModel
                                                                      group =
                                                                      groupsController
                                                                              .groups![
                                                                          index];
                                                                  return CupertinoListTile(
                                                                      title: Text(
                                                                          group
                                                                              .name!),
                                                                      trailing:
                                                                          CupertinoCheckbox(
                                                                              value: selectedGroup ==
                                                                                  group
                                                                                      .id!,
                                                                              onChanged: (bool?
                                                                                  val) {
                                                                                setState(() {
                                                                                  selectedGroup = group.id!;
                                                                                });
                                                                              }),
                                                                      subtitle:
                                                                          Text(
                                                                              'Members Count: ${group.totalMembers}'),
                                                                      leading: Text(
                                                                          "${index + 1}) "));
                                                                })
                                                              ],
                                                            )
                                                    ]),
                                              ),
                                            ),
                                            cancelButton: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.xmark,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              });
                        }
                      },
                      label: "next".tr),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
