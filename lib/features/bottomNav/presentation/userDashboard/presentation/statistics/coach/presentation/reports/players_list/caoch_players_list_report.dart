
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
class ReportsPlayersList extends StatefulWidget {
  const ReportsPlayersList({super.key, });

  @override
  State<ReportsPlayersList> createState() => _ReportsPlayersListState();
}

class _ReportsPlayersListState extends State<ReportsPlayersList> {
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title:Text("players".tr),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column()
        ),
      ),
    );
  }
}
