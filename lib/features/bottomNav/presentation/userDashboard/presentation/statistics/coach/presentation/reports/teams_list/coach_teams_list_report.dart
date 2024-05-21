
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CoachTeamsListReport extends StatefulWidget {
  const CoachTeamsListReport({super.key});

  @override
  State<CoachTeamsListReport> createState() => _CoachTeamsListReportState();
}

class _CoachTeamsListReportState extends State<CoachTeamsListReport> {
 
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("teams".tr),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            
              
          ),
        ),
      ),
    );
  }
}
