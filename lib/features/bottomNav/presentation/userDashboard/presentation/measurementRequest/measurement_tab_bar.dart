import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/history/measurement_history.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/request/measurement_form.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/request/measurement_request.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementTabBar extends StatefulWidget {
  const MeasurementTabBar({super.key});

  @override
  State<MeasurementTabBar> createState() => _MeasurementTabBarState();
}

class _MeasurementTabBarState extends State<MeasurementTabBar>
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
        title: Text("Measurement Request"),
      ),
      body: CustomTabBar(
        tabController: _tabController,
        customTabs: [
          Tab(
            text: "Request".tr,
          ),
          Tab(
            text: "History".tr,
          ),
        ],
        tabViewScreens: [MeasurementRequest(), MeasurementHistory()],
      ),
    );
  }
}
