import 'package:SNP/features/bottomNav/controller/selected_player.dart';
import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:SNP/core/common/widgets/custom_gradient_button.dart';
import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/common/widgets/custom_slider.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
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
  SelectedPlayerController selectedPlayerController =
      Get.find<SelectedPlayerController>();

  @override
  Widget build(BuildContext context) {
    return CustomLoader(child: GetBuilder(
      builder: (MonitoringController monitoringController) {
        return Scaffold(
            appBar: AppBar(
              title: Text('testResults'.tr),
              actions: userController.user!.role == "COACH"
                  ? [
                      GestureDetector(
                        onTap: () async {
                          LoadingManager.dummyLoading();
                          setState(() {
                            canUpdate = !canUpdate;
                          });
                          if (!canUpdate) {
                            monitoringController.fetchMonitoringData(
                                selectedPlayerController.playerId);
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
                                await ApiRequests().updateMonitoringByPlayerId(
                                    selectedPlayerController.playerId, {
                                  "readiness": {
                                    "hydration": monitoringController
                                        .monitoring!.readiness.hydration,
                                    "stress": monitoringController
                                        .monitoring!.readiness.stress,
                                    "sleep": monitoringController
                                        .monitoring!.readiness.sleep,
                                    "overall": monitoringController
                                        .monitoring!.readiness.overall,
                                    "nutrition": monitoringController
                                        .monitoring!.readiness.nutrition,
                                    "injury": monitoringController
                                        .monitoring!.readiness.injury
                                  },
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
                                  "trainingLoad": {
                                    "monday": monitoringController
                                        .monitoring!.trainingLoad.monday,
                                    "tuesday": monitoringController
                                        .monitoring!.trainingLoad.tuesday,
                                    "wednesday": monitoringController
                                        .monitoring!.trainingLoad.wednesday,
                                    "thursday": monitoringController
                                        .monitoring!.trainingLoad.thursday,
                                    "sunday": monitoringController
                                        .monitoring!.trainingLoad.sunday
                                  },
                                });

                                monitoringController.fetchMonitoringData(
                                    selectedPlayerController.playerId);
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
