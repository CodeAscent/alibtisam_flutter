import 'package:SNP/features/dummySplash/dummy_splash.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/presentation/global_events.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/presentation/user_events.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  final eventNavigationController = Get.find<EventNavigation>();

  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      onWillPop: () async {
        eventNavigationController.navigatingFromSplashScreen.isTrue
            ? Get.to(() => DummySplash())
            : Get.back();
        return true;
      },
      shouldAddCallback: true,
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 120,
          automaticallyImplyLeading: false,
          title: Text("events".tr),
          leading: IconButton(
              onPressed: () {
                eventNavigationController.navigatingFromSplashScreen.isTrue
                    ? Get.offAll(() => DummySplash())
                    : Get.back();
              },
              icon: Icon(
                Icons.navigate_before,
                size: 45,
              )),
        ),
        body: GlobalEvents(),

        // TabBarView(
        //   controller: tabController,
        //   children: [GlobalEvents(), UserEvents()],
        // ),
      ),
    );
  }
}


// Column(children: [
            //   Stack(
            //     children: [
            //       Center(
            //           child: Column(
            //         children: [
            //           SizedBox(height: 15),
            //           Text("events".tr),
            //         ],
            //       )),
            //       Align(
            //         alignment: Alignment.topLeft,
            //         child: IconButton(
            //             onPressed: () {
            //               eventNavigationController
            //                       .navigatingFromSplashScreen.isTrue
            //                   ? Get.offAll(() => DummySplash())
            //                   : Get.back();
            //             },
            //             icon: Icon(
            //               Icons.navigate_before,
            //               size: 45,
            //             )),
            //       ),
            //     ],
            //   ),
            //   // TabBar(controller: tabController, tabs: [
            //   //   Tab(
            //   //     text: "globalEvents".tr,
            //   //   ),
            //   //   Tab(
            //   //     text: "myEvents".tr,
            //   //   ),
            //   // ]),
            // ]),