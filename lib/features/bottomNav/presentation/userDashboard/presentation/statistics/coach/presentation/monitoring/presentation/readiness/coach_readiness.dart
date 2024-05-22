
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_slider.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachReadiness extends StatefulWidget {
  final dynamic player;
  const CoachReadiness({super.key, required this.player});

  @override
  State<CoachReadiness> createState() => _CoachReadinessState();
}

class _CoachReadinessState extends State<CoachReadiness> {
  num? nutrition = 0;
  num? hydration = 0;
  num? stress = 0;
  num? sleep = 0;
  num? overall = 0;
  num? injury = 0;
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
          title: Text("readiness".tr),
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
                value: nutrition!,
                label: "nutrition".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    nutrition = newValue.round();
                  });
                },
              ),
              CustomSlider(
                value: hydration!,
                label: "hydration".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    hydration = newValue.round();
                  });
                },
              ),
              CustomSlider(
                value: stress!,
                label: "stress".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    stress = newValue.round();
                  });
                },
              ),
              CustomSlider(
                value: sleep!,
                label: "sleep".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    sleep = newValue.round();
                  });
                },
              ),
              CustomSlider(
                value: overall!,
                label: "overall".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    overall = newValue.round();
                  });
                },
              ),
              CustomSlider(
                value: injury!,
                label: "injury".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    injury = newValue.round();
                  });
                },
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
