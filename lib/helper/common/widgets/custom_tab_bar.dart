import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required TabController tabController,
    required this.customTabs,
    required this.tabViewScreens,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<Widget> customTabs;
  final List<Widget> tabViewScreens;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            dividerHeight: 0,
            // labelStyle: TextStyle(fontSize: 12),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            indicatorWeight: 5,
            indicator: BoxDecoration(
                gradient: kGradientColor(),
                borderRadius: BorderRadius.circular(20)),
            controller: _tabController,
            tabs: customTabs,
          ),
        ),
        Expanded(
          child:
              TabBarView(controller: _tabController, children: tabViewScreens),
        )
      ],
    );
  }
}
