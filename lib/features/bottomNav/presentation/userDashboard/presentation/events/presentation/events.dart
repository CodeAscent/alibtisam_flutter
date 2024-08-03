import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/custom_events_call_by_category.dart';
import 'package:alibtisam/features/dummySplash/dummy_splash.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:alibtisam/core/services/api_requests.dart';
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
      child: CustomLoader(
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
          body: FutureBuilder(
              future: Future.wait([
                ApiRequests().allEvents("ANNOUNCEMENT EVENT"),
                ApiRequests().allEvents("SPORT EVENT"),
                ApiRequests().allEvents("GENERAL EVENT")
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data![0].length == 0 &&
                          snapshot.data![1].length == 0 &&
                          snapshot.data![2].length == 0
                      ? CustomEmptyWidget()
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (snapshot.data![0].length != 0)
                                CustomEventsCallByCategory(
                                  label: 'announcementEvent'.tr,
                                  snapshot: snapshot.data![0],
                                ),
                              if (snapshot.data![1].length != 0)
                                CustomEventsCallByCategory(
                                  label: 'sportEvent'.tr,
                                  snapshot: snapshot.data![1],
                                ),
                              if (snapshot.data![2].length != 0)
                                CustomEventsCallByCategory(
                                  label: 'globalEvents'.tr,
                                  snapshot: snapshot.data![2],
                                ),
                            ],
                          ),
                        );
                }
                return SizedBox();
              }),
        ),
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