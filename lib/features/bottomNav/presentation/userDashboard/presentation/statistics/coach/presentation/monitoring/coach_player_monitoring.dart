import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/overview.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/readiness.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/test_results.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/presentation/training_load.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/helper/theme/app_colors.dart';
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
              child: kRepeatedCards(kOverviewColor(), "overview".tr)),
          GestureDetector(
              onTap: () {
                Get.to(() => TrainingLoad());
              },
              child: kRepeatedCards(kTrainingLoadColor(), "trainingLoad".tr)),
          GestureDetector(
              onTap: () {
                Get.to(() => Readiness());
              },
              child: kRepeatedCards(kReadiness(), "readiness".tr)),
          GestureDetector(
              onTap: () {
                Get.to(() => TestResults());
              },
              child: kRepeatedCards(kTestResults(), "testResults".tr)),
        ],
      ),
    );
  }

  Widget kRepeatedCards(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: primaryColor(), borderRadius: BorderRadius.circular(15)),
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )),
      ),
    );
  }
}
