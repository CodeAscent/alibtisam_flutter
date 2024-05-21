import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/monitoring/presentation/overview/coach_overview.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/monitoring/presentation/readiness/coach_readiness.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/monitoring/presentation/test_results/coach_test_results.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/monitoring/monitoring/presentation/training_load/coach_training_load.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachMonitering extends StatefulWidget {
  const CoachMonitering({
    super.key,
  });

  @override
  State<CoachMonitering> createState() => _CoachMoniteringState();
}

class _CoachMoniteringState extends State<CoachMonitering> {
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("monitoring".tr),
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }

  Widget kRepeatedCards(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        color: color,
        surfaceTintColor: Colors.white,
        child: Container(
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            )),
      ),
    );
  }
}
