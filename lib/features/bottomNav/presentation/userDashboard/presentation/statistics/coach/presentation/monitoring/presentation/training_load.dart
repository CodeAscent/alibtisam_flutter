import 'package:alibtisam/features/bottomNav/controller/selected_player.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_slider.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingLoad extends StatefulWidget {
  const TrainingLoad({super.key});

  @override
  State<TrainingLoad> createState() => _TrainingLoadState();
}

class _TrainingLoadState extends State<TrainingLoad> {
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
              title: Text('trainingLoad'.tr),
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
                          monitoringController.monitoring!.trainingLoad.monday,
                      label: "monday".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.trainingLoad.monday =
                            val;
                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value:
                          monitoringController.monitoring!.trainingLoad.tuesday,
                      label: "tuesday".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.trainingLoad.tuesday =
                            val;

                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value: monitoringController
                          .monitoring!.trainingLoad.wednesday,
                      label: "wednesday".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController
                            .monitoring!.trainingLoad.wednesday = val;

                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value: monitoringController
                          .monitoring!.trainingLoad.thursday,
                      label: "thursday".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.trainingLoad.thursday =
                            val;

                        setState(() {});
                      },
                    ),
                    CustomSlider(
                      value:
                          monitoringController.monitoring!.trainingLoad.sunday,
                      label: "sunday".tr,
                      canChange: canUpdate,
                      onChanged: (val) {
                        monitoringController.monitoring!.trainingLoad.sunday =
                            val;

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
