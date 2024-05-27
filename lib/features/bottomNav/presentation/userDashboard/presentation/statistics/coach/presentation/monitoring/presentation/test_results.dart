import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_slider.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TestResults extends StatefulWidget {
  const TestResults({super.key});

  @override
  State<TestResults> createState() => _TestResultsState();
}

class _TestResultsState extends State<TestResults> {
  bool canUpdate = false;
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return CustomLoader(child: GetBuilder(
      builder: (MonitoringController monitoringController) {
        return Scaffold(
            appBar: AppBar(
              title: Text('testResults'.tr),
              actions: userController.user!.role == "EXTERNAL USER"
                  ? [
                      GestureDetector(
                        onTap: () async {
                          LoadingManager.dummyLoading();
                          setState(() {
                            canUpdate = !canUpdate;
                          });
                          if (!canUpdate) {
                            monitoringController.fetchMonitoringData();
                          }
                        },
                        child: Text(
                          canUpdate ? "cancel".tr : "edit".tr,
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(width: 20),
                    ]
                  : [],
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    CustomSlider(
                      value:
                          monitoringController.monitoring!.testResults.wellness,
                      label: "wellness".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.testResults.wellness =
                            val;
                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value:
                          monitoringController.monitoring!.testResults.workload,
                      label: "workload".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.testResults.workload =
                            val;

                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value:
                          monitoringController.monitoring!.testResults.health,
                      label: "health".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.testResults.health =
                            val;

                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value: monitoringController
                          .monitoring!.testResults.performance,
                      label: "performance".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController
                            .monitoring!.testResults.performance = val;

                        setState(() {});
                      },
                    ),
                    Spacer(),
                    if (canUpdate)
                      SizedBox(
                          height: 60,
                          child: CustomGradientButton(
                              onTap: () async {
                                await ApiRequests().updateMonitoringByPlayerId({
                                  "testResults": {
                                    "wellness": monitoringController
                                        .monitoring!.testResults.wellness,
                                    "workload": monitoringController
                                        .monitoring!.testResults.workload,
                                    "health": monitoringController
                                        .monitoring!.testResults.health,
                                    "performance": monitoringController
                                        .monitoring!.testResults.performance,
                                  },
                                });

                                monitoringController.fetchMonitoringData();
                                setState(() {
                                  canUpdate = false;
                                });
                              },
                              label: "save".tr)),
                    SizedBox(height: 20),
                  ],
                )));
      },
    ));
  }
}
