import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/controller/attendance.dart';
import 'package:alibtisam/features/bottomNav/controller/groups_controller.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_history_list.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/presentation/attendance_tab_screen.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/stages_tab_bar.dart';
import 'package:alibtisam/features/bottomNav/viewModel/age_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class CoachAttendanceStages extends StatefulWidget {
  const CoachAttendanceStages({super.key});

  @override
  State<CoachAttendanceStages> createState() => _CoachAttendanceStagesState();
}

class _CoachAttendanceStagesState extends State<CoachAttendanceStages>
    with TickerProviderStateMixin {
  late TabController _tabController;
  UserController userController = Get.find<UserController>();
  final groupsController = Get.find<GroupsController>();
  late UserModel user;
  @override
  void initState() {
    super.initState();
    user = userController.user!;
    _tabController = TabController(length: user.stage.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('selectstage'.tr),
      ),
      body: CustomTabBar(tabController: _tabController, customTabs: [
        ...user.stage.map(
          (e) => Text(e),
        )
      ], tabViewScreens: [
        ...user.stage.map((e) => GroupsByStage(
              externalOnTap: true,
              stage: e,
              onTap: () {
                Get.to(() => AttendanceTabScreen(
                    groupId: groupsController.selectedGroupId));
              },
            )),
      ]),
    );
  }
}
