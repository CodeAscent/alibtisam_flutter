import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/overview.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/readiness.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/test_results.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/training_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachPlayerMonitering extends StatefulWidget {
  const CoachPlayerMonitering({
    super.key,
  });

  @override
  State<CoachPlayerMonitering> createState() => _CoachPlayerMoniteringState();
}

class _CoachPlayerMoniteringState extends State<CoachPlayerMonitering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                Get.to(() => Overview());
              },
              child: CustomContainerButton(
                label: "overview".tr,
                flexibleHeight: 70,
              )),
          GestureDetector(
              onTap: () {
                Get.to(() => TrainingLoad());
              },
              child: CustomContainerButton(
                label: "trainingLoad".tr,
                flexibleHeight: 70,
              )),
          GestureDetector(
              onTap: () {
                Get.to(() => Readiness());
              },
              child: CustomContainerButton(
                label: "readiness".tr,
                flexibleHeight: 70,
              )),
          GestureDetector(
              onTap: () {
                Get.to(() => TestResults());
              },
              child: CustomContainerButton(
                label: "testResults".tr,
                flexibleHeight: 70,
              )),
        ],
      ),
    );
  }
}
