import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/coach_player_monitoring.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/reports/coach_player_reports.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerStatistics extends StatefulWidget {
  const PlayerStatistics({super.key});

  @override
  State<PlayerStatistics> createState() => _PlayerStatisticsState();
}

class _PlayerStatisticsState extends State<PlayerStatistics>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: CustomTabBar(
        tabController: _tabController,
        customTabs: [
          Tab(
            text: "Monitoring".tr,
          ),
          Tab(
            text: "Reports".tr,
          ),
        ],
        tabViewScreens: [CoachPlayerMonitering(), CoachPlayerReports()],
      ),
    );
  }
}
