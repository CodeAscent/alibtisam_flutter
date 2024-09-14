import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/features/groupsManagement/data/viewModel/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/groupsManagement/views/screens/view_members.dart';
import 'package:alibtisam/features/statistics/coach/stages_tab_bar.dart';
import 'package:alibtisam/features/statistics/controller/monitoring.dart';
import 'package:alibtisam/features/store/viewmodel/products_viewmodel.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class SelectGroupsScreen extends StatefulWidget {
  const SelectGroupsScreen({super.key});

  @override
  State<SelectGroupsScreen> createState() => _SelectGroupsScreenState();
}

class _SelectGroupsScreenState extends State<SelectGroupsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  UserController userController = Get.find<UserController>();
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
              onTap: () {
                Get.to(() => PlayersByStage());
              },
            )),
      ]),
    );
  }
}

class PlayersByStage extends StatefulWidget {
  const PlayersByStage({super.key});

  @override
  State<PlayersByStage> createState() => _PlayersByStageState();
}

class _PlayersByStageState extends State<PlayersByStage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    players = (await groupsController.fetchGroupMembers())!;
    setState(() {});
  }

  List<UserModel> players = [];
  List<dynamic> selectedPlayers = [];
  final groupsController = Get.find<GroupsController>();
  final productsViewmodel = Get.find<ProductsViewmodel>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: Visibility(
          visible: selectedPlayers.isNotEmpty,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => CustomContainerButton(
                  loading: productsViewmodel.loading.value,
                  flexibleHeight: 60,
                  onTap: () {
                    productsViewmodel.orderProducts(playerIds: selectedPlayers);
                  },
                  label: 'submit'.tr,
                ),
              )),
        ),
        appBar: AppBar(
          title: Text("players".tr),
          actions: [
            TextButton(
              onPressed: () {
                if (players.length == selectedPlayers.length) {
                  selectedPlayers.clear();
                } else {
                  selectedPlayers.clear();

                  for (var player in players) {
                    selectedPlayers.add(player.id!);
                  }
                }
                Logger().w(selectedPlayers);
                setState(() {});
              },
              child: Text(players.length == selectedPlayers.length
                  ? 'Clear All'.tr
                  : 'Select All'.tr),
            )
          ],
        ),
        body: groupsController.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : players.length == 0
                ? CustomEmptyWidget()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: players.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    if (selectedPlayers
                                        .contains(players[index].id)) {
                                      selectedPlayers.remove(players[index].id);
                                    } else {
                                      selectedPlayers.add(players[index].id!);
                                    }
                                    setState(() {});
                                  },
                                  child: PlayerCard(
                                      selected: selectedPlayers
                                          .contains(players[index].id),
                                      name: players[index].name!.capitalize!,
                                      image: players[index].pic!,
                                      playerId:
                                          players[index].pId!.toString()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
      
    );
  }
}
