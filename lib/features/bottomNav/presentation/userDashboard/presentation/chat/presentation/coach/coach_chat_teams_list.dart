import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/coach/players_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/presentation/coach/teams_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/chat/widgets/custom_chat_cards.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_players_list.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachChatTeamList extends StatefulWidget {
  const CoachChatTeamList({super.key});

  @override
  State<CoachChatTeamList> createState() => _CoachChatTeamListState();
}

class _CoachChatTeamListState extends State<CoachChatTeamList>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text('chat'.tr),
        ),
        body: CustomTabBar(
          tabController: _tabController,
          customTabs: [
            Tab(text: "team".tr),
            Tab(
              text: "player".tr,
            )
          ],
          tabViewScreens: [TeamChatList(), PlayerChatList()],
        ),
      ),
    );
  }
}
