import 'package:SNP/helper/theme/app_colors.dart';
import 'package:SNP/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatefulWidget {
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
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._tabController.dispose();
  }

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
            onTap: (value) {},
            labelPadding: EdgeInsets.symmetric(
                horizontal: widget.tabViewScreens.length <= 2 ? 50 : 20,
                vertical: 4),
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            dividerHeight: 0,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            indicatorWeight: 5,
            indicator: BoxDecoration(
                gradient: kGradientColor(),
                borderRadius: BorderRadius.circular(20)),
            controller: widget._tabController,
            tabs: widget.customTabs,
          ),
        ),
        Expanded(
          child: TabBarView(
              controller: widget._tabController,
              children: widget.tabViewScreens),
        )
      ],
    );
  }
}
