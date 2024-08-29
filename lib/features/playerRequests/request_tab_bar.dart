import 'package:alibtisam/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam/features/playerRequests/presentation/history/player_requests_history.dart';
import 'package:alibtisam/features/playerRequests/presentation/request/player_requests.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerRequestsTabBar extends StatefulWidget {
  const PlayerRequestsTabBar({super.key});

  @override
  State<PlayerRequestsTabBar> createState() => _PlayerRequestsTabBarState();
}

class _PlayerRequestsTabBarState extends State<PlayerRequestsTabBar>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:  Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.to(() => BottomNav());
                },
                icon: Icon(
                  Icons.navigate_before,
                  size: 32,
                )),
            automaticallyImplyLeading: false,
            title: Text("playerRequests".tr),
          ),
          body: CustomTabBar(
            tabController: _tabController,
            customTabs: [
              Tab(
                text: "request".tr,
              ),
              Tab(
                text: "history".tr,
              ),
            ],
            tabViewScreens: [PlayerRequests(), PlayersRequestHistory()],
          ),
        ),
      
    );
  }
}
