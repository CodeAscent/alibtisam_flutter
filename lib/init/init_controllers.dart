import 'package:alibtisam_flutter/features/bottomNav/controller/dashboard.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
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
}
