import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
    return CustomLoader(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            kRepeatedCards(kOverviewColor(), "Overview"),
            kRepeatedCards(kTrainingLoadColor(), "Training Load"),
            kRepeatedCards(kReadiness(), "Readiness"),
            kRepeatedCards(kTestResults(), "Test Results"),
          ],
        ),
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
