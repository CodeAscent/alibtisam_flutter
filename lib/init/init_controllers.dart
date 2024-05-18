import 'package:alibtisam_flutter/features/commons/events/controller/active_player.dart';
import 'package:alibtisam_flutter/features/commons/home/presentation/settings/controller/theme_controller.dart';
import 'package:alibtisam_flutter/helper/common/controller/custom_loading_controller.dart';
import 'package:alibtisam_flutter/features/commons/events/controller/event_navigation.dart';
import 'package:get/get.dart';

initControllers() {
  Get.put(ActivePlayerController());
  Get.put(EventNavigation());
  Get.put(CustomLoadingController());
  Get.put(ThemeController());
}
