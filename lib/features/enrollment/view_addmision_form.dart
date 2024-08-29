import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/playerRequests/presentation/request/measurement_from.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPlayerByUserModel extends StatelessWidget {
  final UserModel player;
  final bool? updatePlayer;
  final String? measurementId;
  const ViewPlayerByUserModel(
      {super.key, required this.player, this.updatePlayer, this.measurementId});

  @override
  Widget build(BuildContext context) {
    // print('-------> ${player.request}');
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: updatePlayer ?? false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 70,
                child: CustomContainerButton(
                    onTap: () {
                      Get.to(() {
                        return MeasurementForm(
                          user: player,
                          requestId: measurementId!,
                        );
                      });
                    },
                    label: 'next'.tr)),
          ),
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            collapsedHeight: 150,
            stretch: true,
            pinned: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                player.pic!,
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kCustomListTile(key: "name".tr, value: player.name),
                    kCustomListTile(
                        key: "age".tr,
                        value: AgeCalculator.age(
                                DateTime.parse(player.dateOfBirth.toString()))
                            .years),
                    // if (player.request!["status"] != null)
                    //   kCustomListTile(
                    //       key: "status".tr, value: player.request["status"]),
                    kCustomListTile(
                        key: "game".tr,
                        value:
                            player.gameId!.name! + " " + "(${player.stage})"),
                    kCustomListTile(key: "email".tr, value: player.email),
                    kCustomListTile(key: "mobile".tr, value: player.mobile),
                    kCustomListTile(
                        key: "bloodGroup".tr, value: player.bloodGroup),
                    kCustomListTile(key: "gender".tr, value: player.gender),
                    kCustomListTile(key: "height".tr, value: player.height),
                    kCustomListTile(key: "weight".tr, value: player.weight),
                    if (player.chestSize != null) ...[
                      kCustomListTile(
                          key: "chestSize".tr, value: player.chestSize),
                      kCustomListTile(
                          key: "normal chest size".tr,
                          value: player.normalChestSize),
                      kCustomListTile(
                          key: "heartBeatingRate".tr,
                          value: player.heartBeatingRate),
                      kCustomListTile(
                          key: "highJump".tr, value: player.highJump),
                      kCustomListTile(key: "lowJump".tr, value: player.lowJump),
                      kCustomListTile(
                          key: "pulseRate".tr, value: player.pulseRate),
                      kCustomListTile(
                          key: "shoeSize".tr, value: player.shoeSize),
                      kCustomListTile(
                          key: "tShirtSize".tr, value: player.tshirtSize),
                      kCustomListTile(
                          key: "waistSize".tr, value: player.waistSize),
                    ],
                    kCustomListTile(
                        key: "fatherName".tr, value: player.fatherName),
                    kCustomListTile(
                        key: "motherName".tr, value: player.motherName),
                    kCustomListTile(
                        key: "dateOfBirth".tr,
                        value: customDateFormat(player.dateOfBirth!)),
                    kCustomListTile(key: "address".tr, value: player.address),
                    kCustomListTile(key: "city".tr, value: player.city),
                    kCustomListTile(key: "state".tr, value: player.state),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("idProofFront".tr),
                            Image.network(
                              player.idFrontImage!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text("idProofBack".tr),
                            Image.network(
                              player.idBackImage!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (player.certificateLink != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text("certificate".tr),
                            Image.network(
                              player.certificateLink!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
