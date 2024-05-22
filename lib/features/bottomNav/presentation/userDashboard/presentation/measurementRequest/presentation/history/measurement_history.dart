import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/measurementRequest/presentation/history/measurement_player_data.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeasurementHistory extends StatelessWidget {
  const MeasurementHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: kAppGreyColor(),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Get.to(() {
                    return MeasurementPlayerData();
                  });
                },
                title: Text("ABCD"),
                subtitle: Text("123456"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
