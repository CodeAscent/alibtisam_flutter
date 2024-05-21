import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/monitoring/coach_monitoring.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/reports/teams_list/coach_teams_list_report.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachStatistics extends StatefulWidget {
  const CoachStatistics({super.key});

  @override
  State<CoachStatistics> createState() => _CoachStatisticsState();
}

class _CoachStatisticsState extends State<CoachStatistics>
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
        tabViewScreens: [CoachMonitering(), CoachTeamsListReport()],
      ),
    );
  }
}
