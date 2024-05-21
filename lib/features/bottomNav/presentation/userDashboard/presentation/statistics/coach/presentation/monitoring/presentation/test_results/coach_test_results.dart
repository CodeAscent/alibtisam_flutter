
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_slider.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CoachTestResults extends StatefulWidget {
  final dynamic player;
  const CoachTestResults({super.key, required this.player});

  @override
  State<CoachTestResults> createState() => _CoachTestResultsState();
}

class _CoachTestResultsState extends State<CoachTestResults> {
  num? wellness = 0;
  num? workload = 0;
  num? health = 0;
  num? performance = 0;
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
          title: Text("testResults".tr),
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
                value: wellness!,
                label: "wellness".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    wellness = newValue.round();
                  });
                },
                // color: Colors.red,
              ),
              CustomSlider(
                value: workload!,
                label: "workload".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    workload = newValue.round();
                  });
                },
                // color: Colors.red,
              ),
              CustomSlider(
                value: health!,
                label: "health".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    health = newValue.round();
                  });
                },
                // color: Colors.red,
              ),
              CustomSlider(
                value: performance!,
                label: "performance".tr,
                canChange: canUpdate,
                onChanged: (double newValue) {
                  setState(() {
                    performance = newValue.round();
                  });
                },
                // color: Colors.red,
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
                    "save".tr,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  )),
                ),
              )),
      ),
    );
  }
}
