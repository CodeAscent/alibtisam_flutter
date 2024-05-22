
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_slider.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CoachTrainingLoad extends StatefulWidget {
  final dynamic player;
  const CoachTrainingLoad({super.key, required this.player});

  @override
  State<CoachTrainingLoad> createState() => _CoachTrainingLoadState();
}

class _CoachTrainingLoadState extends State<CoachTrainingLoad> {
  num? monday = 0;
  num? tuesday = 0;
  num? wednesday = 0;
  num? thursday = 0;
  num? sunday = 0;
  bool canUpdate = false;
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("trainingLoad".tr),
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () async {
                LoadingManager.dummyLoading();
                setState(() {
                  canUpdate = !canUpdate;
                });
              },
              child: Text(
                canUpdate ? "cancel".tr : "edit".tr,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSlider(
                value: monday!,
                label: "monday".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    monday = newValue.round();
                  });
                },
                // color: Colors.greenAccent.shade700,
              ),
              CustomSlider(
                value: tuesday!,
                label: "tuesday".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    tuesday = newValue.round();
                  });
                },
                // color: Colors.greenAccent.shade700,
              ),
              CustomSlider(
                value: wednesday!,
                label: "wednesday".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    wednesday = newValue.round();
                  });
                },
                // color: Colors.greenAccent.shade700,
              ),
              CustomSlider(
                value: thursday!,
                label: "thursday".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    thursday = newValue.round();
                  });
                },
              ),
              CustomSlider(
                value: sunday!,
                label: "sunday".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    sunday = newValue.round();
                  });
                },
                // color: Colors.greenAccent.shade700,
              ),
            ],
          ),
        ),
        bottomNavigationBar: !canUpdate
            ? null
            : SafeArea(
                child: GestureDetector(
                onTap: () async {
                  LoadingManager.dummyLoading();
              
                  setState(() {
                    canUpdate = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.green),
                  height: 50,
                  child: Center(
                      child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  )),
                ),
              )),
      ),
    );
  }
}
