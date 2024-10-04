import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/enrollment/views/pages/view_addmision_form.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/groups_management.dart';
import 'package:alibtisam/features/statistics/coach/stages_tab_bar.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolarizePlayer extends StatefulWidget {
  final UserModel player;
  const PolarizePlayer({super.key, required this.player});

  @override
  State<PolarizePlayer> createState() => _PolarizePlayerState();
}

class _PolarizePlayerState extends State<PolarizePlayer> {
  GroupsController groupsManagement = Get.find<GroupsController>();

  bool loading = false;
  updatePlayer() async {
    try {
      Get.back();

      setState(() {
        loading = true;
      });
      await ApiRequests().updatePlayerStage(
          playerId: widget.player.id!,
          stage: widget.player.stage == 'ACADEMY' ? 'SCHOOL' : 'PROFESSIONAL',
        );
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name!.capitalize!),
      ),
      bottomNavigationBar: loading
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                // height: 180,
                child: CustomContainerButton(
                  onTap: () {
                    Get.defaultDialog(
                        titleStyle: TextStyle(fontSize: 12),
                        title:
                            "${'Are you sure you want update'.tr} \n${widget.player.name}'s ${'stage'.tr}?",
                        content: Column(
                          children: [
                            Text('Update Stage From'.tr),
                            Text(
                              '${widget.player.stage} --> ${widget.player.stage == 'ACADEMY' ? 'SCHOOL' : 'PROFESSIONAL'}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                        confirm: TextButton(
                            onPressed: () async {
                              updatePlayer();
                            },
                            child: Text('Confirm'.tr)));
                  },
                  flexibleHeight: 60,
                  label: 'Update Stage'.tr,
                ),
              ),
            ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 200,
                            width: 200,
                            child: HttpWrapper.networkImageRequest(
                                widget.player.pic!)),
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => ViewPlayerByUserModel(
                                      player: widget.player));
                                },
                                child: Text('VIEW DETAILS'.tr)))
                      ],
                    ),
                    SizedBox(height: 20),
                    kCustomListTile(
                        () {}, 'Current Game'.tr, widget.player.gameId!.name!),
                    kCustomListTile(
                        () {}, 'Current Stage'.tr, widget.player.stage!),
                    kCustomListTile(() {}, 'upgradableTo'.tr,
                        "${widget.player.stage == 'ACADEMY' ? 'SCHOOL' : 'PROFESSIONAL'}"),
                    kCustomListTile(
                        () {},
                        '${'Age'.tr} : ',
                        AgeCalculator.age(
                                DateTime.parse(widget.player.dateOfBirth!))
                            .years
                            .toString()),
                  ],
                ),
              ),
            ),
    );
  }

  GestureDetector kCustomListTile(
      void Function()? onTap, String key, String val) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kAppGreyColor())),
        child: ListTile(
          title: Text(key),
          subtitle: Text(val.toString()),
        ),
      ),
    );
  }
}
