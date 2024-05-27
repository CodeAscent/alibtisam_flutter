import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/overview.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/readiness.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/test_results.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/training_load.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
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
              child: kRepeatedCards(kOverviewColor(), "Overview")),
          GestureDetector(
              onTap: () {
                Get.to(() => TrainingLoad());
              },
              child: kRepeatedCards(kTrainingLoadColor(), "Training Load")),
          GestureDetector(
              onTap: () {
                Get.to(() => Readiness());
              },
              child: kRepeatedCards(kReadiness(), "Readiness")),
          GestureDetector(
              onTap: () {
                Get.to(() => TestResults());
              },
              child: kRepeatedCards(kTestResults(), "Test Results")),
        ],
      ),
    );
  }

  Widget kRepeatedCards(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        child: Container(
            decoration: BoxDecoration(
                color: kAppGreyColor(),
                borderRadius: BorderRadius.circular(20)),
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )),
      ),
    );
  }
}
