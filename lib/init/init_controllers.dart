import 'package:alibtisam_flutter/features/bottomNav/controller/chat_messages.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/chats_list.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/dashboard.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/measurement_req.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/controller/organization.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/monitoring.dart';
import 'package:alibtisam_flutter/helper/theme/controller/theme_controller.dart';
import 'package:alibtisam_flutter/helper/common/controller/custom_loading_controller.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:get/get.dart';

initControllers() {
  Get.put(ActivePlayerController());
  Get.put(EventNavigation());
  Get.put(CustomLoadingController());
  Get.put(ThemeController());
  Get.put(UserController());
  Get.put(DashboardController());
  Get.put(MeasurementReqController());
  Get.put(ChatMessagesController());
  Get.put(ChatsListController());
  Get.put(MonitoringController());
  Get.put(OrganizationController());
}
