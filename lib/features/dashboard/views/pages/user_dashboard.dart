import 'package:alibtisam/features/dashboard/viewmodel/dashboard.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/dashboard/models/dashboard.dart';
import 'package:alibtisam/features/events/controller/event_navigation.dart';
import 'package:alibtisam/features/dashboard/views/widgets/custom_dashboard_card.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final eventNavigationController = Get.find<EventNavigation>();
  final userController = Get.find<UserController>();
  final dashboardController = Get.find<DashboardViewModel>();

  @override
  void initState() {
    super.initState();
    userController.fetchUser();
    dashboardController.fetchDashboardItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: primaryColor(),
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          dashboardController.fetchDashboardItems();
        },
        child: GetBuilder(
            init: serviceLocator<DashboardViewModel>(),
            builder: (controller) {
              return controller.state == ViewState.Busy
                  ? CustomLoader()
                  : SingleChildScrollView(
                      child: SafeArea(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Center(
                              child: Wrap(
                                children: [
                                  ...List.generate(
                                    controller.dashboard.length,
                                    (int index) {
                                      DashboardModel dashboard =
                                          controller.dashboard[index];
                                      Logger()
                                          .w("---------> " + "${Get.locale}");
                                      return GestureDetector(
                                        onTap: () {
                                          if (dashboard.name == "Events") {
                                            eventNavigationController
                                                .navigatingFromSplash(false);
                                          }
                                          Get.toNamed(dashboard.route)!
                                              .then((_) {
                                            userController.fetchUser();
                                            dashboardController
                                                .fetchDashboardItems();
                                          });
                                        },
                                        child: CustomDashboardCard(
                                          label: Get.locale.toString() ==
                                                      'en_US' ||
                                                  Get.locale.toString() == 'en'
                                              ? dashboard.name
                                              : dashboard.arabicName!,
                                          icon: dashboard.icon,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 250),
                          ],
                        ),
                      )),
                    );
            }),
      ),
    );
  }
}
