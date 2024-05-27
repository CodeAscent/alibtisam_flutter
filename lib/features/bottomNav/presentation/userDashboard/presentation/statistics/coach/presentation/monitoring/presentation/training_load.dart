import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_slider.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomLoader(child: GetBuilder(
      builder: (MonitoringController monitoringController) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Training Load'),
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
                          canUpdate ? "Cancel" : "Edit",
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
                      label: "Monday",
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
                      label: "Tuesday",
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
                      label: "Wednesday",
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
                      label: "Thursday",
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
                      label: "Sunday",
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
                                await ApiRequests().updateMonitoringByPlayerId({
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

                                monitoringController.fetchMonitoringData();
                                setState(() {
                                  canUpdate = false;
                                });
                              },
                              label: "Save")),
                    SizedBox(height: 20),
                  ],
                )));
      },
    ));
  }
}
