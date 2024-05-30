import 'package:alibtisam_flutter/features/bottomNav/controller/selected_player.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/coach_player_monitoring.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/reports/coach_player_reports.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam_flutter/network/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerStatistics extends StatefulWidget {
  final String playerId;
  const PlayerStatistics({super.key, required this.playerId});

  @override
  State<PlayerStatistics> createState() => _PlayerStatisticsState();
}

class _PlayerStatisticsState extends State<PlayerStatistics>
    with TickerProviderStateMixin {
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    monitoringController.fetchMonitoringData(widget.playerId);
    selectedPlayerController.playerId = widget.playerId;
  }

  MonitoringController monitoringController = Get.find<MonitoringController>();
  late TabController _tabController;
SelectedPlayerController selectedPlayerController = Get.find<SelectedPlayerController>();
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("statistics".tr),
        ),
        body: CustomTabBar(
          tabController: _tabController,
          customTabs: [
            Tab(
              text: "monitoring".tr,
            ),
            Tab(
              text: "reports".tr,
            ),
          ],
          tabViewScreens: [CoachPlayerMonitering(), CoachPlayerReports()],
        ),
      ),
    );
  }
}
