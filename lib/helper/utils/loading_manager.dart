import 'package:alibtisam_flutter/helper/common/controller/custom_loading_controller.dart';
import 'package:get/get.dart';

class LoadingManager {
  static final loadingController = Get.find<CustomLoadingController>();
  static startLoading() async => await loadingController.startLoading();
  static endLoading() async => await loadingController.endLoading();
  static dummyLoading() async => await loadingController.dummyLoading();
}
