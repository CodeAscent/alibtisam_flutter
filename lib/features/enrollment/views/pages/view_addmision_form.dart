import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/model/game.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/enrollment/viewmodel/enrollment_viewmodel.dart';
import 'package:alibtisam/features/playerRequests/presentation/request/measurement_from.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPlayerByUserModel extends StatefulWidget {
  final UserModel player;
  final bool? updatePlayer;
  final bool? changeGame;
  final String? measurementId;
  const ViewPlayerByUserModel(
      {super.key,
      required this.player,
      this.updatePlayer,
      this.measurementId,
      this.changeGame = false});

  @override
  State<ViewPlayerByUserModel> createState() => _ViewPlayerByUserModelState();
}

class _ViewPlayerByUserModelState extends State<ViewPlayerByUserModel> {
  List<GameModel>? gamesList;
  Future fetchGames(selectedStage) async {
    gamesList = await ApiRequests().getGames(stage: selectedStage);
    setState(() {});
    return gamesList;
  }

  final enrollmentViewmodel = Get.find<EnrollmentViewmodel>();
  @override
  Widget build(BuildContext context) {
    // print('-------> ${player.request}');
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: widget.updatePlayer ?? false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 70,
                child: CustomContainerButton(
                    onTap: () {
                      Get.to(() {
                        return MeasurementForm(
                          user: widget.player,
                          requestId: widget.measurementId!,
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
                widget.player.pic!,
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
            toolbarHeight: 60,
            actions: [
              if (widget.changeGame == true)
                CustomContainerButton(
                  label: 'Change Game',
                  onTap: () {
                    String selectedGameId = '';
                    String selectedStage = 'ACADEMY';
                    showDialog(
                      context: Get.context ?? context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Material(
                            // color: Colors.white30,
                            child: Column(
                              children: [
                                Text('Change Game'),
                                Container(
                                    height: Get.height * 0.55,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CupertinoCheckbox(
                                                value:
                                                    selectedStage == 'ACADEMY',
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedStage = 'ACADEMY';
                                                    fetchGames(selectedStage);
                                                  });
                                                }),
                                            Text('ACADEMY'),
                                            CupertinoCheckbox(
                                                value:
                                                    selectedStage == 'SCHOOL',
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedStage = 'SCHOOL';
                                                    fetchGames(selectedStage);
                                                  });
                                                }),
                                            Text('SCHOOL'),
                                          ],
                                        ),
                                        FutureBuilder(
                                          future: fetchGames(selectedStage),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedGameId =
                                                            snapshot
                                                                    .data![
                                                                        index]
                                                                    .id ??
                                                                '';
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: selectedGameId ==
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id
                                                              ? primaryColor()
                                                              : null,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.network(
                                                              snapshot
                                                                  .data![index]
                                                                  .icon,
                                                              height: 70,
                                                              width: 80,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                  color: selectedGameId ==
                                                                          snapshot
                                                                              .data![
                                                                                  index]
                                                                              .id
                                                                      ? Colors
                                                                          .white
                                                                      : null),
                                                            ),
                                                            SizedBox(height: 5),
                                                          ]),
                                                    ),
                                                  );
                                                },
                                                gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent:
                                                            160),
                                              );
                                            }
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        )
                                      ],
                                    ))),
                                CustomContainerButton(
                                    onTap: () {
                                      Get.back();
                                    },
                                    color: Colors.grey,
                                    label: 'Cancel'),
                                Obx(() => CustomContainerButton(
                                    loading: enrollmentViewmodel.loading.value,
                                    onTap: () async {
                                      if (selectedGameId == '') {
                                        customSnackbar('Please select a game',
                                            ContentType.help);
                                      } else {
                                        await enrollmentViewmodel
                                            .updateGameByUser(
                                                id: widget.player.id!,
                                                gameId: selectedGameId,
                                                stage: selectedStage);
                                        Get.back();
                                        Get.back();
                                      }
                                    },
                                    label: 'Submit'))
                              ],
                            ),
                          );
                        });
                      },
                    );
                  },
                )
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kCustomListTile(key: "name".tr, value: widget.player.name),
                    kCustomListTile(
                        key: "age".tr,
                        value: AgeCalculator.age(DateTime.parse(
                                widget.player.dateOfBirth.toString()))
                            .years),
                    // if (player.request!["status"] != null)
                    //   kCustomListTile(
                    //       key: "status".tr, value: player.request["status"]),
                    // kCustomListTile(
                    //     key: "game".tr,
                    //     value:
                    //         player.gameId!.name! + " " + "(${player.stage})"),
                    kCustomListTile(
                        key: "email".tr, value: widget.player.email),
                    kCustomListTile(
                        key: "mobile".tr, value: widget.player.mobile),
                    kCustomListTile(
                        key: "bloodGroup".tr, value: widget.player.bloodGroup),
                    kCustomListTile(
                        key: "gender".tr, value: widget.player.gender),
                    kCustomListTile(
                        key: "height".tr, value: widget.player.height),
                    kCustomListTile(
                        key: "weight".tr, value: widget.player.weight),
                    if (widget.player.chestSize != null) ...[
                      kCustomListTile(
                          key: "chestSize".tr, value: widget.player.chestSize),
                      kCustomListTile(
                          key: "normal chest size".tr,
                          value: widget.player.normalChestSize),
                      kCustomListTile(
                          key: "heartBeatingRate".tr,
                          value: widget.player.heartBeatingRate),
                      kCustomListTile(
                          key: "highJump".tr, value: widget.player.highJump),
                      kCustomListTile(
                          key: "lowJump".tr, value: widget.player.lowJump),
                      kCustomListTile(
                          key: "pulseRate".tr, value: widget.player.pulseRate),
                      kCustomListTile(
                          key: "shoeSize".tr, value: widget.player.shoeSize),
                      kCustomListTile(
                          key: "tShirtSize".tr,
                          value: widget.player.tshirtSize),
                      kCustomListTile(
                          key: "waistSize".tr, value: widget.player.waistSize),
                    ],
                    kCustomListTile(
                        key: "fatherName".tr, value: widget.player.fatherName),
                    kCustomListTile(
                        key: "motherName".tr, value: widget.player.motherName),
                    kCustomListTile(
                        key: "dateOfBirth".tr,
                        value: customDateFormat(widget.player.dateOfBirth!)),
                    kCustomListTile(
                        key: "address".tr, value: widget.player.address),
                    kCustomListTile(key: "city".tr, value: widget.player.city),
                    kCustomListTile(
                        key: "state".tr, value: widget.player.state),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("idProofFront".tr),
                            Image.network(
                              widget.player.idFrontImage!,
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
                              widget.player.idBackImage!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (widget.player.certificateLink != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text("certificate".tr),
                            Image.network(
                              widget.player.certificateLink!,
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
