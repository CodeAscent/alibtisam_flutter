
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MoniteringTeamsList extends StatefulWidget {
  const MoniteringTeamsList({super.key});

  @override
  State<MoniteringTeamsList> createState() => _MoniteringTeamsListState();
}

class _MoniteringTeamsListState extends State<MoniteringTeamsList> {
  @override
  void initState() {
    super.initState();
  }

  


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
