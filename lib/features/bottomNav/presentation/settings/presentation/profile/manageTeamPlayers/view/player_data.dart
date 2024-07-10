import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/presentation/settings/presentation/profile/manageTeamPlayers/view/update_player_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerDataForProfile extends StatelessWidget {
  final UserModel player;
  const PlayerDataForProfile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => UpdatePlayerData(player: player));
                  },
                  child: Text('Edit')),
            ],
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
                player.pic,
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
                    if (player.request["status"] != null)
                      kCustomListTile(
                          key: "status".tr, value: player.request["status"]),
                    kCustomListTile(key: "email".tr, value: player.email),
                    kCustomListTile(key: "mobile".tr, value: player.mobile),
                    kCustomListTile(
                        key: "bloodGroup".tr, value: player.bloodGroup),
                    kCustomListTile(key: "gender".tr, value: player.gender),
                    kCustomListTile(key: "height".tr, value: player.height),
                    kCustomListTile(key: "weight".tr, value: player.weight),
                    if (player.chestSize != 0) ...[
                      kCustomListTile(
                          key: "chestSize".tr, value: player.chestSize),
                      kCustomListTile(
                          key: "normalChestSize".tr,
                          value: player.normalChestSize),
                      kCustomListTile(
                          key: "heartbeatingRate".tr,
                          value: player.heartBeatingRate),
                      kCustomListTile(
                          key: "highJump".tr, value: player.highJump),
                      kCustomListTile(key: "lowJump".tr, value: player.lowJump),
                      kCustomListTile(
                          key: "pulseRate".tr, value: player.pulseRate),
                      kCustomListTile(
                          key: "shoeSize".tr, value: player.shoeSize),
                      kCustomListTile(
                          key: "tshirtSize".tr, value: player.tshirtSize),
                      kCustomListTile(
                          key: "waistSize".tr, value: player.waistSize),
                    ],
                    kCustomListTile(
                        key: "fatherName".tr, value: player.fatherName),
                    kCustomListTile(
                        key: "motherName".tr, value: player.motherName),
                    kCustomListTile(
                        key: "dateOfBirth".tr,
                        value: customDateFormat(player.dateOfBirth)),
                    kCustomListTile(key: "address".tr, value: player.address),
                    kCustomListTile(key: "city".tr, value: player.city),
                    kCustomListTile(key: "state".tr, value: player.state),
                    kCustomListTile(key: "country".tr, value: player.country),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("idProofFront".tr),
                            Image.network(
                              player.idFrontImage,
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
                              player.idBackImage,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: player.certificateLink != '',
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text("certificate".tr),
                            Image.network(
                              player.certificateLink,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
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

  Container kCustomListTile({required String key, required dynamic value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: kAppGreyColor(), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(key),
        subtitle: Text(
          value.toString().capitalize!,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
