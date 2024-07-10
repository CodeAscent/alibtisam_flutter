import 'dart:io';

import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/features/bottomNav/controller/teams.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/settings/presentation/profile/manageTeamPlayers/viewmodel/update_player_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/enrollment/external/external_enrollment_form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePlayerData extends StatefulWidget {
  final UserModel player;
  const UpdatePlayerData({super.key, required this.player});

  @override
  State<UpdatePlayerData> createState() => _UpdatePlayerDataState();
}

class _UpdatePlayerDataState extends State<UpdatePlayerData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController chestSizeController = TextEditingController();
  TextEditingController normalChestSizeController = TextEditingController();
  TextEditingController heartBeatRateController = TextEditingController();
  TextEditingController highJumpController = TextEditingController();
  TextEditingController lowJumpController = TextEditingController();
  TextEditingController pulseRateController = TextEditingController();
  XFile? pic;

  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  final userController = Get.find<UserController>();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.player.name;
    phoneController.text = widget.player.mobile;
    bloodGroupController.text = widget.player.bloodGroup;
    heightController.text = widget.player.height.toString();
    weightController.text = widget.player.weight.toString();
    chestSizeController.text = widget.player.chestSize.toString();
    normalChestSizeController.text = widget.player.normalChestSize.toString();
    heartBeatRateController.text = widget.player.heartBeatingRate.toString();
    highJumpController.text = widget.player.highJump.toString();
    lowJumpController.text = widget.player.lowJump.toString();
    pulseRateController.text = widget.player.pulseRate.toString();
  }

  TeamsController teamsController = Get.find<TeamsController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SafeArea(
                  child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    collapsedHeight: 150,
                    stretch: true,
                    flexibleSpace: Stack(
                      children: [
                        pic == null
                            ? Image.network(
                                widget.player.pic,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Image.file(
                                File(pic!.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton.filledTonal(
                              onPressed: () async {
                                pic = await pickImageFromGalary();
                                setState(() {});
                              },
                              icon: Icon(Icons.filter)),
                        )
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          CustomTextField(
                              controller: nameController, label: "fullName".tr),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                label: "mobile".tr,
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: phoneController,
                              ),
                              CustomTextField(
                                maxLines: 1,
                                label: "bloodGroup".tr,
                                width: Get.width * 0.44,
                                readOnly: true,
                                controller: bloodGroupController,
                                suffix: DropdownButton(
                                  iconSize: 40,
                                  isDense: true,
                                  items: bloodGroups.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    bloodGroupController.text = val ?? '';
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                label: "Height (ft)*",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: heightController,
                              ),
                              CustomTextField(
                                label: "Weight (kg)*",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: weightController,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                label: "Chest Size",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: chestSizeController,
                              ),
                              CustomTextField(
                                label: "Normal Chest Size",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: normalChestSizeController,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                label: "Heart Beating Rate",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: heartBeatRateController,
                              ),
                              CustomTextField(
                                label: "High Jump",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: highJumpController,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                label: "Low Jump",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: lowJumpController,
                              ),
                              CustomTextField(
                                label: "Pulse Rate",
                                width: Get.width * 0.44,
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                controller: pulseRateController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: CustomContainerButton(
                  onTap: () async {
                    print(weightController.text);
                    if (formKey.currentState!.validate()) {
                      await UpdatePlayerViewmodel().updateUserById(
                        uid: widget.player.id,
                        body: {
                          "name": nameController.text,
                          "mobile": phoneController.text,
                          "bloodGroup": bloodGroupController.text,
                          "height": heightController.text,
                          "weight": weightController.text,
                          "chestSize": chestSizeController.text,
                          "heartBeatingRate": heartBeatRateController.text,
                          "highJump": highJumpController.text,
                          "lowJump": lowJumpController.text,
                          "normalChestSize": normalChestSizeController.text,
                          "pulseRate": pulseRateController.text,
                        },
                      );
                      teamsController.fetchTeams();
                    }
                  },
                  flexibleHeight: 50,
                  label: "update".tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
