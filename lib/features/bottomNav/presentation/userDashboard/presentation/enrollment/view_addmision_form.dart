import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAddmisionForm extends StatelessWidget {
  final UserModel player;
  const ViewAddmisionForm({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    kCustomListTile(key: "Name", value: player.name),
                    if (player.request["status"] != null)
                      kCustomListTile(
                          key: "Status", value: player.request["status"]),
                    kCustomListTile(key: "Game", value: player.name),
                    kCustomListTile(key: "E-mail", value: player.email),
                    kCustomListTile(key: "Mobile", value: player.mobile),
                    kCustomListTile(
                        key: "Blood Group", value: player.bloodGroup),
                    kCustomListTile(key: "Gender", value: player.gender),
                    kCustomListTile(key: "Height", value: player.height),
                    kCustomListTile(key: "Weight", value: player.weight),
                    if (player.chestSize != 0) ...[
                      kCustomListTile(
                          key: "Chest Size", value: player.chestSize),
                      kCustomListTile(
                          key: "Normal Chest Size",
                          value: player.normalChestSize),
                      kCustomListTile(
                          key: "Heartbeating Rate",
                          value: player.heartBeatingRate),
                      kCustomListTile(key: "HighJump", value: player.highJump),
                      kCustomListTile(key: "Low Jump", value: player.lowJump),
                      kCustomListTile(
                          key: "Pulse Rate", value: player.pulseRate),
                      kCustomListTile(key: "Shoe Size", value: player.shoeSize),
                      kCustomListTile(
                          key: "T-shirt Size", value: player.tshirtSize),
                      kCustomListTile(
                          key: "Waist Size", value: player.waistSize),
                    ],
                    kCustomListTile(
                        key: "Father's Name", value: player.fatherName),
                    kCustomListTile(
                        key: "Mother's Name", value: player.motherName),
                    kCustomListTile(
                        key: "Date of birth",
                        value: customDateFormat(player.dateOfBirth)),
                    kCustomListTile(key: "Address", value: player.address),
                    kCustomListTile(key: "City", value: player.city),
                    kCustomListTile(key: "State", value: player.state),
                    kCustomListTile(key: "Country", value: player.country),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("ID PROOF FRONT"),
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
                            Text("ID PROOF BACK"),
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
                            Text("CERTIFICATE"),
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
