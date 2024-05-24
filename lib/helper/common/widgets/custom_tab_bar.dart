import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor()),
                borderRadius: BorderRadius.circular(20)),
            height: 40,
            child: TabBar(
              dividerHeight: 0,
              labelStyle: TextStyle(fontSize: 12),
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
            child: TabBarView(
                controller: _tabController, children: tabViewScreens),
          )
        ],
      ),
    );
  }
}
